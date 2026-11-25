# 3h — Input and output data from infrastructure projects

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Backend block configuration overview](https://developer.hashicorp.com/terraform/language/backend)
- [The terraform_remote_state Data Source](https://developer.hashicorp.com/terraform/language/state/remote-state-data)
- [variable block reference](https://developer.hashicorp.com/terraform/language/block/variable)
- [Use input variables to add module arguments](https://developer.hashicorp.com/terraform/language/values/variables)
- [module block reference](https://developer.hashicorp.com/terraform/language/block/module)
- [count reference](https://developer.hashicorp.com/terraform/language/meta-arguments/count)
- [Use outputs to expose module data](https://developer.hashicorp.com/terraform/language/values/outputs)
- [Tutorial: Query data sources](https://developer.hashicorp.com/terraform/tutorials/configuration-language/data-sources)

## 🎯 What the exam wants from you

How data moves **in** (variables, data sources, remote state, files) and **out** (outputs, module outputs,
`output -json`) of a project — and which option to choose for sharing between projects.

## 🧪 Lab

```bash
terraform init
terraform apply -auto-approve -var='owner=yousef'
terraform output
terraform output -json | jq .
terraform output -raw greeting
```
Look at how each value enters:
- `var.owner` → CLI flag
- `data.local_file.settings` → reads `settings.json`
- `local.settings` → `jsondecode()` of the file
- `module.child.summary` → output of a child module
- From another project → `terraform_remote_state` (see 2a) or a provider data source

## ⚠️ Exam traps

- Outputs of **child** modules are only visible in the parent via `module.<name>.<output>`; to show them on the CLI, re-export them from the root.
- `terraform output -raw` → string without quotes (great for scripts); `-json` → everything, including sensitive values in plain text.
- Data sources are read during **plan** (unless they depend on unknown values → deferred to apply).
- Prefer provider data sources (e.g. `aws_vpc` by tag) or HCP Terraform `tfe_outputs` over `terraform_remote_state` (which needs full state access).

## ✅ Self-check

**Q1. A shell script needs a single output as plain text. Command?**

<details><summary>Answer</summary>

`terraform output -raw <name>`

</details>

**Q2. Why might a data source show `(known after apply)` in the plan?**

<details><summary>Answer</summary>

Its arguments depend on values that aren't known until apply, so reading is deferred.

</details>


---
[⬅ Back to the roadmap](../../README.md)
