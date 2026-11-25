# 1f — Implement advanced configurations

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Conditional Expressions](https://developer.hashicorp.com/terraform/language/expressions/conditionals)
- [for Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)
- [Splat Expressions](https://developer.hashicorp.com/terraform/language/expressions/splat)
- [check block reference](https://developer.hashicorp.com/terraform/language/block/check)
- [lifecycle reference](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)
- [dynamic Blocks](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)
- [Validate your configuration](https://developer.hashicorp.com/terraform/language/validate)
- [Tutorial: Use checks to validate infrastructure](https://developer.hashicorp.com/terraform/tutorials/configuration-language/checks)
- [Tutorial: Validate modules with custom conditions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/custom-conditions)

## 🎯 What the exam wants from you

Know when to use each validation tool and each lifecycle argument, and how to generate nested blocks with `dynamic`.

| Tool | When it runs | Fails the run? |
|---|---|---|
| `variable { validation }` | plan, on input | ✅ yes |
| `precondition` | before the resource is planned/applied | ✅ yes |
| `postcondition` | after the resource is applied/read | ✅ yes |
| `check { assert }` | end of plan & apply | ❌ **warning only** |

## 🧪 Lab

Two parts:

**Part A — `local/` (free):** lifecycle + conditions with `terraform_data`.
```bash
cd local
terraform init && terraform apply -auto-approve
# 1. change var.app_version -> plan shows terraform_data.deploy will be REPLACED (replace_triggered_by)
# 2. set var.replicas = 0 -> precondition error
# 3. try `terraform destroy` -> prevent_destroy blocks it. Remove it to clean up.
```

**Part B — `aws/` (validate only):** `dynamic` blocks for security group rules.
```bash
cd aws
terraform init && terraform validate
terraform console    # > local.ingress_rules
```
Add a new rule to `var.ingress` and notice you never touch the resource block.

## ⚠️ Exam traps

- `check` blocks **never block** an apply — they only produce warnings. If the question says "must stop the deployment", it's a `precondition`/`postcondition` or `validation`.
- `ignore_changes = all` ignores every attribute; `ignore_changes = [tags]` only tags.
- `create_before_destroy` is inherited by dependencies.
- `prevent_destroy` can't stop you deleting the resource **block** from code together with removing the lifecycle — it only blocks plans that destroy while it's present.
- Inside `dynamic "ingress"` the iterator is named `ingress` by default (`ingress.value`), not `each`.

## ✅ Self-check

**Q1. You want a warning (not a failure) when a website health endpoint isn't returning 200. Which block?**

<details><summary>Answer</summary>

A `check` block with an `assert` (optionally with a scoped `data` source).

</details>

**Q2. A resource must be recreated whenever another resource's ID changes. Which lifecycle argument?**

<details><summary>Answer</summary>

`replace_triggered_by = [other_resource.id]`

</details>


---
[⬅ Back to the roadmap](../../README.md)
