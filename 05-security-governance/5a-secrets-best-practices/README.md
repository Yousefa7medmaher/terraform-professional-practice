# 5a — Identify best practices for secrets

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Encrypt your state and plan files](https://developer.hashicorp.com/terraform/cloud-docs/hold-your-own-key)
- [Manage sensitive data in your configuration](https://developer.hashicorp.com/terraform/language/manage-sensitive-data)
- [Securely store secrets for CI/CD pipelines](https://developer.hashicorp.com/well-architected-framework/secure-systems/secure-applications/ci-cd-secrets)
- [Terraform Language Documentation](https://developer.hashicorp.com/terraform/language)
- [ephemeral block reference](https://developer.hashicorp.com/terraform/language/block/ephemeral)
- [Tutorial: Protect sensitive input variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables)
- [Tutorial: Upgrade RDS major version](https://developer.hashicorp.com/terraform/tutorials/aws/rds-upgrade)

## 🎯 What the exam wants from you

Ranked from weakest to strongest way to handle a secret in Terraform:

| Technique | Hidden in CLI output | Kept out of **state** & plan |
|---|---|---|
| hard-coded in `.tf` | ❌ | ❌ (and it's in Git!) |
| `variable { sensitive = true }` | ✅ | ❌ |
| `ephemeral = true` variable / output | ✅ | ✅ |
| `ephemeral` resource (e.g. `ephemeral "random_password"`, Vault/Secrets Manager reads) | ✅ | ✅ |
| **write-only argument** (`password_wo` + `password_wo_version`) | ✅ | ✅ |

Plus: encrypt state at rest (S3 SSE-KMS, HCP Terraform encryption / Hold Your Own Key), restrict who can read state.

## 🧪 Lab

**Part A — local, see where secrets leak:**
```bash
cd local
terraform init && terraform apply -auto-approve -var='api_key=SuperSecret123'
terraform output                       # api_key_out is (sensitive value)
grep -n SuperSecret123 terraform.tfstate   # ...but it IS in state (through the output)!
jq '.resources[] | select(.type=="random_password") | .instances[].attributes.result' terraform.tfstate
jq -r '.resources[] | "\(.mode) \(.type).\(.name)"' terraform.tfstate
```
The stored password is in plain text in state. The `ephemeral "random_password"` resource doesn't appear
in the state file at all — check the last command's output.

**Part B — AWS (validate):** `aws/` creates an RDS instance whose password comes from an **ephemeral** resource
and goes into the **write-only** `password_wo` argument, so it's never stored. Bump `password_wo_version` to rotate.

## ⚠️ Exam traps

- `sensitive = true` ≠ secure storage. The value is still in **state and plan files**.
- Ephemeral values can be referenced only in other ephemeral contexts: provider blocks, provisioner/connection blocks, write-only arguments, ephemeral variables/outputs, `locals`.
- Write-only arguments are never stored, so Terraform can't detect changes → you bump the `*_wo_version` argument to trigger an update.
- Never commit `.tfvars` with secrets; pass them via `TF_VAR_` from a secret store or use HCP Terraform **sensitive** variables (write-only in the UI).

## ✅ Self-check

**Q1. A `sensitive = true` variable holds a DB password used in `aws_db_instance.password`. Is it in state?**

<details><summary>Answer</summary>

Yes. Use `password_wo` (write-only) with an ephemeral source to keep it out of state.

</details>

**Q2. How do you rotate a password passed through a write-only argument?**

<details><summary>Answer</summary>

Change the value and increment the matching `password_wo_version` argument.

</details>


---
[⬅ Back to the roadmap](../../README.md)
