# 3g — Troubleshoot deployment issues

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [terraform validate command](https://developer.hashicorp.com/terraform/cli/commands/validate)
- [Enable Terraform logs](https://developer.hashicorp.com/terraform/internals/debugging)
- [Timeouts](https://developer.hashicorp.com/terraform/plugin/framework/resources/timeouts)
- [terraform state pull command](https://developer.hashicorp.com/terraform/cli/commands/state/pull)
- [terraform state push command](https://developer.hashicorp.com/terraform/cli/commands/state/push)
- [Refactor Terraform state](https://developer.hashicorp.com/terraform/language/state/refactor)
- [Configure a resource](https://developer.hashicorp.com/terraform/language/resources/configure)
- [Version constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)
- [Tutorial: Troubleshoot Terraform](https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow)

## 🎯 What the exam wants from you

Classify the error (syntax → `validate`, provider/API → logs, state → `state` commands, version → constraints)
and pick the right tool.

## 🧪 Lab

`broken/` has **4 bugs**. Fix them one at a time:
```bash
cd broken
terraform fmt -check       # 1. formatting
terraform init
terraform validate         # 2-4. references, types, dependency cycle
```
**Logging:**
```bash
export TF_LOG=DEBUG            # TRACE, DEBUG, INFO, WARN, ERROR, OFF
export TF_LOG_PATH=./tf.log
terraform plan
export TF_LOG_PROVIDER=TRACE   # only provider logs (TF_LOG_CORE for core)
unset TF_LOG TF_LOG_PATH TF_LOG_PROVIDER
```
**State recovery:**
```bash
terraform state pull > backup.tfstate   # always back up first
# ... fix things ...
terraform state push backup.tfstate     # last resort, checks lineage & serial
```

## ⚠️ Exam traps

- `TF_LOG_PATH` only works when `TF_LOG` is also set.
- `terraform validate` doesn't contact providers' APIs or check state; it checks syntax and internal consistency (it needs `init` first).
- `state push` refuses a state with a different **lineage** or a **lower serial** unless `-force`.
- `timeouts {}` blocks are per-resource and only if the provider supports them (e.g. `create = "60m"` for slow RDS).
- "Cycle" errors: two resources referencing each other — break with a separate resource (e.g. `aws_security_group_rule`) instead of inline blocks.

## ✅ Self-check

**Q1. How do you send only provider debug logs to a file?**

<details><summary>Answer</summary>

`TF_LOG_PROVIDER=DEBUG` (or TRACE) and `TF_LOG_PATH=file.log`.

</details>

**Q2. List the 4 bugs in `broken/`.**

<details><summary>Answer</summary>

See `solution/main.tf` — bad formatting, a reference to an undeclared variable, a list passed to `count`, and a cycle between two resources.

</details>


---
[⬅ Back to the roadmap](../../README.md)
