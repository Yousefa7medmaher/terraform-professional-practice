# 5b — Use secret rotation and integration with secrets management tools

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [lifecycle reference](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)
- [terraform refresh command](https://developer.hashicorp.com/terraform/cli/commands/refresh)
- [Query infrastructure data](https://developer.hashicorp.com/terraform/language/data-sources)
- [Tutorial: Query data sources](https://developer.hashicorp.com/terraform/tutorials/configuration-language/data-sources)
- [Tutorial: Manage resource lifecycle](https://developer.hashicorp.com/terraform/tutorials/state/resource-lifecycle)

## 🎯 What the exam wants from you

Rotate secrets on a schedule with `time_rotating` + `replace_triggered_by`, read secrets from Vault / AWS
Secrets Manager / Azure Key Vault at run time (prefer **ephemeral** resources), and refresh state when an
external system rotated something.

## 🧪 Lab

**Local rotation demo:**
```bash
cd local
terraform init && terraform apply -auto-approve
terraform output -raw password_id
# rotation_minutes = 1 → wait a minute
terraform plan          # time_rotating expired → password gets replaced
terraform apply -auto-approve
```
**Vault (optional):** start a dev server and read a secret with an ephemeral resource:
```bash
vault server -dev &                       # prints a root token
export VAULT_ADDR=http://127.0.0.1:8200 VAULT_TOKEN=<root token>
vault kv put secret/app db_password=s3cr3t
cd ../vault && terraform init && terraform apply
```

## ⚠️ Exam traps

- `time_rotating` + `lifecycle { replace_triggered_by = [time_rotating.x] }` is the standard rotation pattern.
- A `data` source that reads a secret **stores it in state**; an `ephemeral` resource does not.
- After an external rotation, `terraform apply -refresh-only` updates state with the new values.
- Dynamic secrets (Vault DB/AWS engines) are short-lived by design — better than rotating static ones.

## ✅ Self-check

**Q1. You read a DB password from Vault with `data "vault_kv_secret_v2"`. Security concern?**

<details><summary>Answer</summary>

The secret is saved in state. Use `ephemeral "vault_kv_secret_v2"` instead.

</details>

**Q2. How do you force a new password every 30 days?**

<details><summary>Answer</summary>

`time_rotating` with `rotation_days = 30` and `replace_triggered_by` on the password resource.

</details>


---
[⬅ Back to the roadmap](../../README.md)
