#!/usr/bin/env bash
# Usage: ./check-plan.sh plan.json
# Fails (exit 1) if the plan deletes or replaces anything.
set -euo pipefail

PLAN="${1:-plan.json}"

risky=$(jq -r '
  .resource_changes[]
  | select(.change.actions | index("delete"))
  | "\(.address): \(.change.actions | join(","))"
' "$PLAN")

if [[ -n "$risky" ]]; then
  echo "RISKY CHANGES FOUND:"
  echo "$risky"
  exit 1
fi

echo "No deletes or replacements."
