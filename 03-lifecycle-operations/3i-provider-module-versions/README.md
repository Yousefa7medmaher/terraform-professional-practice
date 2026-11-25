# 3i — Manage provider and module versions

🟡 **AWS config** — `terraform init && terraform validate` work without credentials. `plan`/`apply` need an AWS account (stay in free tier and `destroy` afterwards).

## 📚 Official docs

- [Version constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)
- [terraform block reference](https://developer.hashicorp.com/terraform/language/block/terraform)
- [Use modules in your configuration](https://developer.hashicorp.com/terraform/language/modules/configuration)
- [Tutorial: Lock and upgrade provider versions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/provider-versioning)
- [Tutorial: Use registry modules in configuration](https://developer.hashicorp.com/terraform/tutorials/modules/module-use)

## 🎯 What the exam wants from you

Pin and upgrade both **providers** (`required_providers` + lock file) and **modules** (`version` argument,
registry sources only), and know that `init -upgrade` respects constraints.

## 🧪 Lab

```bash
terraform init
cat .terraform.lock.hcl        # aws provider is locked
cat .terraform/modules/modules.json | jq    # which module version was installed
```
**Upgrade a module (sample exam question 4):**
1. Change `version = "5.8.0"` to `version = "~> 6.0"` in `main.tf`.
2. `terraform init` → error/still old? Run `terraform init -upgrade`.
3. `terraform plan` → read the changes the new major version introduces.

**Upgrade a provider:**
1. Change `~> 5.0` to `~> 6.0`.
2. `terraform init -upgrade` → the lock file changes → commit it.

## ⚠️ Exam traps

- `version` in a `module` block works only for **registry** modules (public or private). For Git sources use `?ref=v1.2.3`.
- `init -upgrade` picks the newest version **allowed by the constraint** — it never ignores a pinned version.
- Deleting `.terraform.lock.hcl` isn't the right way to upgrade (and doesn't affect modules at all).
- `required_version` is about the **Terraform CLI**, not modules or providers.

## ✅ Self-check

**Q1. A registry module pinned to `1.4.0` doesn't support the new Terraform version; the latest release does. How to upgrade?**

<details><summary>Answer</summary>

Update the `version` argument in the module block, then run `terraform init -upgrade`.

</details>

**Q2. How do you pin a module from GitHub to a tag?**

<details><summary>Answer</summary>

`source = "git::https://github.com/org/repo.git?ref=v1.2.0"`

</details>


---
[⬅ Back to the roadmap](../../README.md)
