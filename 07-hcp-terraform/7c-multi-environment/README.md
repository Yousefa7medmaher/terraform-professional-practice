# 7c — Implement multi-environment configuration

🔵 **Needs a free HCP Terraform account** (app.terraform.io) and a token from `terraform login`.

## 📚 Official docs

- [Variables overview (HCP Terraform)](https://developer.hashicorp.com/terraform/cloud-docs/variables)
- [Manage variables and variable sets](https://developer.hashicorp.com/terraform/cloud-docs/variables/managing-variables)
- [Manage workspace state](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/state)
- [Workspace settings](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings)
- [The terraform_remote_state Data Source](https://developer.hashicorp.com/terraform/language/state/remote-state-data)
- [Policy enforcement in workspaces](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/policy-enforcement)
- [Manage policies and policy sets in HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs/policy-enforcement/manage-policy-sets)
- [Tutorial: Manage variable sets in HCP Terraform](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-multiple-variable-sets)
- [Tutorial: Organize workspaces with projects](https://developer.hashicorp.com/terraform/tutorials/cloud/projects)

## 🎯 What the exam wants from you

Model environments in HCP Terraform with **projects** (permissions + grouping), one **workspace per
environment**, **variable sets** for shared values (credentials, tags) scoped to a project, workspace
variables for env-specific values, and state sharing between workspaces.

**Variable precedence in HCP Terraform (high → low):**
1. Priority variable sets (can't be overridden)
2. Workspace-specific variables
3. Variable sets attached to the workspace
4. Variable sets attached to the project
5. Global variable sets

## 🧪 Lab

This config manages HCP Terraform **with Terraform** (the tfe provider):
```bash
terraform login
terraform init
terraform apply -var='organization=YOUR_ORG'
```
It creates:
- project `practice-app`
- workspaces `app-dev`, `app-stage`, `app-prod` (prod: no auto-apply)
- a variable set `aws-common` attached to the project
- per-workspace variable `environment`
- remote state sharing: only `app-prod` may read `network-prod` state

Then open the UI and check where each variable comes from on the workspace **Variables** page.

## ⚠️ Exam traps

- A **priority** variable set overrides workspace variables — use it for values teams must not change.
- Workspace **remote state sharing** must be granted on the *producer* workspace (`global_remote_state` or a list of consumer workspaces).
- Prefer the `tfe_outputs` data source over `terraform_remote_state` for HCP workspaces (needs only output access).
- Variables can be **Terraform** (`var.x`) or **environment** (`TF_VAR_x`, `AWS_REGION`, `TFC_AWS_*`) category.

## ✅ Self-check

**Q1. Security requires that `AWS_REGION` can't be changed by any workspace in a project. How?**

<details><summary>Answer</summary>

A **priority** variable set attached to the project.

</details>

**Q2. How does `app-prod` read outputs from `network-prod` with minimal access?**

<details><summary>Answer</summary>

Allow sharing on `network-prod` (remote state consumers) and use `data "tfe_outputs"` in `app-prod`.

</details>


---
[⬅ Back to the roadmap](../../README.md)
