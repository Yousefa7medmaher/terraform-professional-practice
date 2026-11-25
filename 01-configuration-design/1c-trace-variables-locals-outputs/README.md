# 1c — Trace input variables, local values, and outputs to find a configuration issue

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Conditional Expressions](https://developer.hashicorp.com/terraform/language/expressions/conditionals)
- [Splat Expressions](https://developer.hashicorp.com/terraform/language/expressions/splat)
- [count reference](https://developer.hashicorp.com/terraform/language/meta-arguments/count)
- [Use locals to reuse expressions](https://developer.hashicorp.com/terraform/language/values/locals)
- [Use outputs to expose module data](https://developer.hashicorp.com/terraform/language/values/outputs)
- [Type Constraints](https://developer.hashicorp.com/terraform/language/expressions/type-constraints)
- [Types and Values](https://developer.hashicorp.com/terraform/language/expressions/types)
- [module block reference](https://developer.hashicorp.com/terraform/language/block/module)
- [Use input variables to add module arguments](https://developer.hashicorp.com/terraform/language/values/variables)
- [Tutorial: Create dynamic expressions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/expressions)
- [Tutorial: Simplify Terraform configuration with locals](https://developer.hashicorp.com/terraform/tutorials/configuration-language/locals)
- [Tutorial: Output data from Terraform](https://developer.hashicorp.com/terraform/tutorials/configuration-language/outputs)
- [Tutorial: Customize Terraform configuration with variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables)

## 🎯 What the exam wants from you

The exam shows a variable → local → module → output chain and asks *why the output is wrong* or
*which line causes the error*. You need to follow a value through every hop and know how types,
conditionals, `count` and splat expressions change it.

## 🧪 Lab

This folder is a **bug hunt**. The config "works" but produces wrong results.

```bash
terraform init
terraform apply -auto-approve -var="environment=prod"
terraform output
```

The ticket says: *in prod we want 3 instances named `web-prod-0..2`, in other envs 1 instance,
and the output `instance_names` must list all names.*

Find the **3 bugs** without looking at the answer:
1. Prod creates the wrong number of instances.
2. Names have the wrong format.
3. The output only shows one name.

Use `terraform console` to evaluate `local.instance_count`, `var.environment`, etc. step by step.

## ⚠️ Exam traps

- `count = var.enabled ? 1 : 0` → the resource becomes a **list**; you must reference `[0]` or use splat `[*]`.
- `resource.x[*].id` on a resource **with `for_each`** does not work — use `values(resource.x)[*].id` or a `for` expression.
- Type conversion: a `"3"` string is automatically converted to number for `count`, but `"three"` errors.
- A conditional needs both results to be of a compatible type: `var.x ? [] : {}` errors.

## ✅ Self-check

**Q1. Find the three bugs in `main.tf`.**

<details><summary>Answer</summary>

1. `local.instance_count` compares with `"production"` instead of `"prod"` → prod falls into the else branch (1).
2. The name uses `count.index + 1` and `var.env_short` (which defaults to `"dev"`) instead of `count.index` and `var.environment`.
3. The output uses `random_pet.instance[0].id` instead of `random_pet.instance[*].id`.
The fixed version is in `solution/main.tf`.

</details>

**Q2. `resource "x" "y" { count = 0 }` — what does `x.y[*].id` return?**

<details><summary>Answer</summary>

An empty list `[]`. Splat on an empty list does not error.

</details>


---
[⬅ Back to the roadmap](../../README.md)
