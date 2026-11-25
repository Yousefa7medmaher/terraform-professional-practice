# 4b — Understand deployment strategies

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [terraform force-unlock command](https://developer.hashicorp.com/terraform/cli/commands/force-unlock)
- [State Locking](https://developer.hashicorp.com/terraform/language/state/locking)
- [terraform init command](https://developer.hashicorp.com/terraform/cli/commands/init)
- [Create a Terraform CLI configuration file](https://developer.hashicorp.com/terraform/cli/config/config-file)
- [Terraform CLI environment variables reference](https://developer.hashicorp.com/terraform/cli/config/environment-variables)
- [Tutorial: Running Terraform in automation](https://developer.hashicorp.com/terraform/tutorials/automation/automate-terraform)

## 🎯 What the exam wants from you

Running Terraform non-interactively and safely at scale: the env vars that control automation,
the CLI config file (plugin cache, credentials, mirrors), locking behaviour, and rollout strategies
(blue/green with `create_before_destroy`, promotion dev → prod, canary with feature flags).

## 🧪 Lab

**Environment variables — try each one:**
```bash
export TF_IN_AUTOMATION=1          # shorter output, no "run terraform apply" hints
export TF_INPUT=0                  # same as -input=false
export TF_VAR_environment=ci       # sets var.environment
export TF_CLI_ARGS_plan="-lock-timeout=120s"   # extra args for one command
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
export TF_DATA_DIR=.tfdata         # move the .terraform directory
terraform init && terraform plan
```
**CLI config file:** copy [`terraformrc.example`](terraformrc.example) to `~/.terraformrc`.

**Blue/green:** `main.tf` replaces the "green" version with `create_before_destroy` so the new one exists
before the old one is removed. Change `var.release` and look at the plan symbol (`+/-`).

## ⚠️ Exam traps

- `TF_CLI_ARGS` applies to **every** command; `TF_CLI_ARGS_plan` only to `plan`.
- `TF_VAR_name` has **lower** precedence than `.tfvars` files and `-var`.
- The plugin cache is **not safe for concurrent** `init` runs writing to the same directory unless the provider is already cached.
- `-lock=false` disables locking — almost never correct in CI.
- `TF_TOKEN_app_terraform_io` provides an HCP Terraform token through an environment variable (no `terraform login` needed in CI).

## ✅ Self-check

**Q1. How do you pass an HCP Terraform token to CI without `terraform login`?**

<details><summary>Answer</summary>

Environment variable `TF_TOKEN_app_terraform_io=<token>`.

</details>

**Q2. Which setting speeds up `init` in CI by reusing downloaded providers?**

<details><summary>Answer</summary>

`TF_PLUGIN_CACHE_DIR` (or `plugin_cache_dir` in the CLI config file).

</details>


---
[⬅ Back to the roadmap](../../README.md)
