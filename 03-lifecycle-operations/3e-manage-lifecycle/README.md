# 3e — Manage infrastructure lifecycle

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Remove a resource from state](https://developer.hashicorp.com/terraform/language/state/remove)
- [Resource Address Reference](https://developer.hashicorp.com/terraform/cli/state/resource-addressing)
- [Refactor modules](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring)
- [resource block reference](https://developer.hashicorp.com/terraform/language/block/resource)
- [lifecycle reference](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)
- [terraform plan command](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [Destroy a resource](https://developer.hashicorp.com/terraform/language/resources/destroy)
- [Tutorial: Manage resource lifecycle](https://developer.hashicorp.com/terraform/tutorials/state/resource-lifecycle)

## 🎯 What the exam wants from you

Every way to change how Terraform treats an existing resource:

| Goal | Modern (code) | Legacy (CLI) |
|---|---|---|
| Rename / move into a module | `moved` block | `terraform state mv` |
| Stop managing, **keep** the real resource | `removed` + `destroy = false` | `terraform state rm` |
| Force recreation | `-replace=ADDR` / `replace_triggered_by` | `terraform taint` (deprecated) |
| Adopt an existing resource | `import` block | `terraform import` |
| Delete one resource | remove block from code + apply | `terraform destroy -target` |

## 🧪 Lab

```bash
terraform init && terraform apply -auto-approve
terraform state list
```
Do each step, `plan` before every `apply`:
1. **Rename** `random_pet.old_name` → `random_pet.new_name` and add a `moved` block (see `steps/1-moved.tf.example`).
2. **Move into a module**: move `random_string.token` into `./modules/token` with `moved { from = random_string.token  to = module.token.random_string.this }`.
3. **Forget without destroying**: delete the `random_pet.sandbox` block and add the `removed` block from `steps/3-removed.tf.example`. Plan must say "will no longer be managed by Terraform", **0 to destroy**.
4. **Force replace**: `terraform apply -replace='random_pet.new_name'`.
5. Do step 3 again with the CLI instead: `terraform state rm 'random_pet.x'`.

## ⚠️ Exam traps

- `removed` with `lifecycle { destroy = false }` = keep real object; with `destroy = true` (default) = destroy it.
- `state rm` and `removed` both leave the real object running. `destroy -target` deletes it.
- You can't put `moved` for a resource in a **different state**; across states use `terraform state mv -state-out` or remove + import.

## ✅ Self-check

**Q1. A sandbox VM must stay running but no longer be managed by Terraform. Two valid ways?**

<details><summary>Answer</summary>

A `removed` block with `lifecycle { destroy = false }`, or `terraform state rm <address>`.

</details>

**Q2. Which block lets you move a resource into a child module without recreating it?**

<details><summary>Answer</summary>

`moved`.

</details>


---
[⬅ Back to the roadmap](../../README.md)
