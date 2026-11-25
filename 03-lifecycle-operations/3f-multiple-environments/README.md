# 3f — Manage multiple infrastructure environments

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Manage Workspaces Overview](https://developer.hashicorp.com/terraform/cli/workspaces)
- [Workspaces](https://developer.hashicorp.com/terraform/language/state/workspaces)
- [Use input variables to add module arguments](https://developer.hashicorp.com/terraform/language/values/variables)
- [Creating Modules](https://developer.hashicorp.com/terraform/language/modules/develop)
- [Tutorial: Customize Terraform configuration with variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables)

## 🎯 What the exam wants from you

Three common patterns and their trade-offs:

| Pattern | Pros | Cons |
|---|---|---|
| **CLI workspaces** (`terraform workspace`) | one codebase, quick | same backend & credentials, easy to apply to the wrong env, hard to diverge |
| **`.tfvars` per env** + separate backend keys | simple, explicit | must remember the right `-var-file` |
| **Directory per env** calling shared modules | clear isolation, different access per env | some duplication |
| **HCP Terraform workspaces** | per-workspace vars, permissions, policies | needs HCP Terraform |

## 🧪 Lab

**A — CLI workspaces**
```bash
cd workspaces
terraform init
terraform workspace new dev && terraform apply -auto-approve
terraform workspace new prod && terraform apply -auto-approve
terraform workspace list
ls terraform.tfstate.d/          # one state per workspace
```
**B — tfvars per environment**
```bash
cd ../tfvars
terraform init
terraform apply -var-file=envs/dev.tfvars -auto-approve
terraform plan  -var-file=envs/prod.tfvars
```
Compare the outputs of both approaches.

## ⚠️ Exam traps

- `terraform.workspace` returns the current workspace name; the default workspace is `default` and **can't be deleted**.
- Local backend stores workspace state in `terraform.tfstate.d/<name>/`; S3 under `env:/<name>/<key>` (configurable `workspace_key_prefix`).
- HashiCorp says CLI workspaces are **not** a good fit when environments need separate credentials/access controls.
- CLI workspaces ≠ HCP Terraform workspaces (HCP workspaces are more like separate working directories).

## ✅ Self-check

**Q1. Where does the local backend store state for workspace `prod`?**

<details><summary>Answer</summary>

`terraform.tfstate.d/prod/terraform.tfstate`

</details>

**Q2. Prod needs different AWS credentials and approvers than dev. CLI workspaces or separate configs?**

<details><summary>Answer</summary>

Separate configurations/backends (or HCP Terraform workspaces with their own permissions) — not CLI workspaces.

</details>


---
[⬅ Back to the roadmap](../../README.md)
