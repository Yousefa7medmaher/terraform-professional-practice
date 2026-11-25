# 1b — Predictable and secure Terraform configuration

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Refactor modules](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring)
- [Use outputs to expose module data](https://developer.hashicorp.com/terraform/language/values/outputs)
- [Style Guide](https://developer.hashicorp.com/terraform/language/style)
- [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers)
- [Validate your configuration](https://developer.hashicorp.com/terraform/language/validate)
- [Tutorial: Use configuration to move resources](https://developer.hashicorp.com/terraform/tutorials/configuration-language/move-config)

## 🎯 What the exam wants from you

"Predictable" = same code gives the same result: pinned versions, a committed lock file,
no hidden defaults, standard file layout, `moved` blocks instead of destroy/recreate when
you rename. "Secure" = no secrets in code, `sensitive` outputs, providers configured only in the root module.

## 🧪 Lab

```bash
terraform init
terraform apply -auto-approve
terraform output                     # db_password shows as (sensitive value)
terraform output -raw db_password    # explicit read works
```

**Refactor without destroying:**
1. In `main.tf` rename `random_pet.server` to `random_pet.app_server`.
2. Run `terraform plan` → Terraform wants to **destroy and create**.
3. Uncomment the `moved` block in `moved.tf` and plan again → `has moved to`, 0 to destroy.

**Style:**
- Run `terraform fmt -check -recursive` (what CI runs) and `terraform fmt -diff`.
- Compare the layout here with the Style Guide: `versions.tf`, `variables.tf`, `main.tf`, `outputs.tf`.

## ⚠️ Exam traps

- `sensitive = true` **hides** values in CLI output but the value is **still stored in plain text in state**.
- An output that references a sensitive value must itself be marked `sensitive = true` or Terraform errors.
- Provider configuration (`provider "x" {}`) belongs in the **root** module. A child module only declares `required_providers`.
- `moved` is preferred over `terraform state mv` because it is reviewed in code and works for everyone who uses the module.

## ✅ Self-check

**Q1. You rename a resource and `plan` shows it will be destroyed and recreated. What is the recommended fix?**

<details><summary>Answer</summary>

Add a `moved { from = old_address  to = new_address }` block.

</details>

**Q2. Is a `sensitive = true` output encrypted in the state file?**

<details><summary>Answer</summary>

No. It is only redacted from CLI/UI output. Protect the state itself (encrypted backend, access control).

</details>


---
[⬅ Back to the roadmap](../../README.md)
