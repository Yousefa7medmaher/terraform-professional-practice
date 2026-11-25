# 7d — Upgrade Terraform versions across workspaces

🔵 **Needs a free HCP Terraform account** (app.terraform.io) and a token from `terraform login`.

## 📚 Official docs

- [Workspace settings](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings)
- [terraform block reference](https://developer.hashicorp.com/terraform/language/block/terraform)
- [Manage workspace state](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/state)
- [UI and VCS-driven run workflow](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/ui)
- [Tutorial: Upgrade Terraform version in HCP Terraform](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-versions)

## 🎯 What the exam wants from you

Each HCP Terraform workspace has a **Terraform version** setting (exact or a constraint like `~> 1.15.0`).
Upgrade safely: check `required_version` in the code, upgrade the lowest environment first, run a plan
(must be no-op), apply, and roll forward. State written by a newer version can't be used by an older one,
so a downgrade usually means restoring an earlier **state version**.

## 🧪 Lab

The workspaces are created in [7c](../7c-multi-environment) with a `terraform_versions` map (all `~> 1.14.0`).

1. Upgrade **only dev** — from the 7c folder:
```bash
terraform apply -var='organization=YOUR_ORG'   -var='terraform_versions={dev="~> 1.15.0", stage="~> 1.14.0", prod="~> 1.14.0"}'
```
2. Trigger a run in `app-dev` → the plan must be clean (no changes).
3. Check what every workspace runs now — from this folder:
```bash
terraform init && terraform apply -var='organization=YOUR_ORG'
```
4. Roll forward to stage, then prod, with the same command.
5. In the UI: workspace → **States** → find the state version from before the upgrade (your rollback point).
6. Set a version **lower** than the code's `required_version` → the run fails at init. Why?

## ⚠️ Exam traps

- Version setting in the workspace **must also satisfy** the configuration's `required_version`, or the run errors.
- Using a constraint (`~> 1.15.0`) lets HCP Terraform pick up patch releases automatically; an exact version never changes.
- `latest` is risky for prod — it upgrades without review.
- Bulk changes across many workspaces: tfe provider / API, or the organization's default version for **new** workspaces.

## ✅ Self-check

**Q1. A workspace is set to Terraform 1.14.3 but the code says `required_version = ">= 1.15"`. What happens?**

<details><summary>Answer</summary>

The run fails because the selected version doesn't satisfy `required_version`.

</details>

**Q2. How do you upgrade 200 workspaces consistently?**

<details><summary>Answer</summary>

Manage `terraform_version` with the tfe provider (or API), rolling out env by env.

</details>


---
[⬅ Back to the roadmap](../../README.md)
