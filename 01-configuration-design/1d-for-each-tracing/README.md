# 1d — Trace dynamic resources created with for_each

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [for_each reference](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
- [terraform state show command](https://developer.hashicorp.com/terraform/cli/commands/state/show)
- [Types and Values](https://developer.hashicorp.com/terraform/language/expressions/types)
- [terraform state list command](https://developer.hashicorp.com/terraform/cli/commands/state/list)
- [data block reference](https://developer.hashicorp.com/terraform/language/block/data)
- [Tutorial: Manage similar resources with for each](https://developer.hashicorp.com/terraform/tutorials/configuration-language/for-each)

## 🎯 What the exam wants from you

Given a `for_each` over a map/set (often built with `flatten` or a `for` expression) you must say
**how many** resources are created and **their exact addresses**, e.g. `aws_subnet.this["app-a"]`,
and how to look them up in state.

## 🧪 Lab

```bash
terraform init
terraform apply -auto-approve
terraform state list
terraform state show 'local_file.subnet["app-us-east-1a"]'
terraform console
> local.subnets
> keys(local_file.subnet)
> local_file.team_file["alice"].filename
```

**Before you apply**, write on paper:
1. How many `local_file.subnet` instances? What are the keys?
2. How many `local_file.team_file` instances?
3. Then run `terraform state list` and check yourself.

**Experiment — why for_each beats count:**
- Remove `"web"` from `var.tiers`, plan → only the `web-*` instances are destroyed.
- Do the same with the `count` version in `count-vs-for-each.tf.example` and see all indexes shift.

## ⚠️ Exam traps

- Quotes matter in the shell: `terraform state show 'x.y["key"]'` (single quotes around the whole address).
- `for_each` keys must be **known at plan time** — you can't use an attribute that's only known after apply (e.g. a generated ID) as a key.
- `toset()` removes duplicates and the order is lost; `each.key == each.value` for sets.
- `flatten` + `for` is the standard pattern for nested loops (tiers × AZs).

## ✅ Self-check

**Q1. `for_each = toset(["a", "b", "a"])` — how many instances?**

<details><summary>Answer</summary>

2 (`["a"]` and `["b"]`). Sets remove duplicates.

</details>

**Q2. What is the address of the subnet for tier `db` in `us-east-1b`?**

<details><summary>Answer</summary>

`local_file.subnet["db-us-east-1b"]`

</details>

**Q3. Why does Terraform reject `for_each = { for u in random_id.x : u.hex => u }`?**

<details><summary>Answer</summary>

`hex` is unknown until apply, and `for_each` keys must be known at plan time.

</details>


---
[⬅ Back to the roadmap](../../README.md)
