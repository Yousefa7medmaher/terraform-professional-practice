# 6b — Understand the contract of a Terraform module

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Use modules in your configuration](https://developer.hashicorp.com/terraform/language/modules/configuration)
- [Use outputs to expose module data](https://developer.hashicorp.com/terraform/language/values/outputs)
- [providers reference](https://developer.hashicorp.com/terraform/language/meta-arguments/providers)
- [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers)
- [variable block reference](https://developer.hashicorp.com/terraform/language/block/variable)
- [Use input variables to add module arguments](https://developer.hashicorp.com/terraform/language/values/variables)
- [Conditional Expressions](https://developer.hashicorp.com/terraform/language/expressions/conditionals)
- [count reference](https://developer.hashicorp.com/terraform/language/meta-arguments/count)
- [Creating Modules](https://developer.hashicorp.com/terraform/language/modules/develop)
- [Tutorial: Modules overview](https://developer.hashicorp.com/terraform/tutorials/modules/module)
- [Tutorial: Customize modules with object attributes](https://developer.hashicorp.com/terraform/tutorials/modules/module-object-attributes)

## 🎯 What the exam wants from you

A module's **contract** = its inputs (types, defaults, validation, `optional()` attributes, `nullable`),
its outputs, and its provider requirements. Callers may only rely on outputs. Breaking the contract
(renaming a variable, removing an output, changing a type) is a **major** version change.

## 🧪 Lab

```bash
terraform init && terraform apply -auto-approve
terraform output
```
Read `modules/bucket/variables.tf` and answer:
1. Which inputs are required? (no default)
2. What does `optional(bool, true)` do when the caller omits `versioning`?
3. What happens if a caller passes `lifecycle_days = null`? (look at `nullable = false`)
4. Call the module with `name = "UPPER"` → which validation fails?
5. Add an output `arn`-like value and think: is that a minor or major version bump?

## ⚠️ Exam traps

- `optional(type, default)` inside `object()` — attribute can be omitted; without a default it becomes `null`.
- `nullable = false` → passing `null` uses the default instead of `null`.
- A child module **can't** access parent variables or other modules' resources — only what's passed in.
- Removing/renaming an output or a variable = breaking change → **major** version (SemVer).
- `count`/`for_each` on a module make its outputs a list/map: `module.x[0].id`, `module.x["k"].id`.

## ✅ Self-check

**Q1. A module variable `settings = object({ size = optional(string, "small") })` and the caller passes `{}`. Value of `var.settings.size`?**

<details><summary>Answer</summary>

`"small"`

</details>

**Q2. `module "b" { count = 2 }` — how do you reference output `id` of the second one?**

<details><summary>Answer</summary>

`module.b[1].id`

</details>


---
[⬅ Back to the roadmap](../../README.md)
