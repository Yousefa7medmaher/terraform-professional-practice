#!/usr/bin/env bash
# API-driven run workflow (simplified).
# Usage: TFE_TOKEN=... ORG=... WORKSPACE=... ./run.sh <config-dir>
set -euo pipefail

CONFIG_DIR="${1:?config dir}"
ADDR="${TFE_ADDRESS:-https://app.terraform.io}"
H=(-H "Authorization: Bearer $TFE_TOKEN" -H "Content-Type: application/vnd.api+json")

# 1. workspace id
WS_ID=$(curl -s "${H[@]}" "$ADDR/api/v2/organizations/$ORG/workspaces/$WORKSPACE" | jq -r .data.id)
echo "workspace: $WS_ID"

# 2. create a configuration version
CV=$(curl -s "${H[@]}" -X POST "$ADDR/api/v2/workspaces/$WS_ID/configuration-versions" \
  -d '{"data":{"type":"configuration-versions","attributes":{"auto-queue-runs":false}}}')
CV_ID=$(echo "$CV" | jq -r .data.id)
UPLOAD_URL=$(echo "$CV" | jq -r '.data.attributes."upload-url"')

# 3. upload the code
tar -czf /tmp/config.tar.gz -C "$CONFIG_DIR" --exclude .terraform .
curl -s -X PUT -H "Content-Type: application/octet-stream" --data-binary @/tmp/config.tar.gz "$UPLOAD_URL"

# 4. create the run
RUN_ID=$(curl -s "${H[@]}" -X POST "$ADDR/api/v2/runs" -d @- <<EOF | jq -r .data.id
{"data":{"type":"runs","attributes":{"message":"API-driven run"},
 "relationships":{
   "workspace":{"data":{"type":"workspaces","id":"$WS_ID"}},
   "configuration-version":{"data":{"type":"configuration-versions","id":"$CV_ID"}}}}}
EOF
)
echo "run: $ADDR/app/$ORG/workspaces/$WORKSPACE/runs/$RUN_ID"

# 5. poll
while true; do
  STATUS=$(curl -s "${H[@]}" "$ADDR/api/v2/runs/$RUN_ID" | jq -r .data.attributes.status)
  echo "status: $STATUS"
  case "$STATUS" in
    planned|planned_and_finished|applied|errored|discarded|canceled|policy_soft_failed) break ;;
  esac
  sleep 5
done
