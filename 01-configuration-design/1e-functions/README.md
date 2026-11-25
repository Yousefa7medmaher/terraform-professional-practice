# 1e — Predict the value of an expression that uses a Terraform function

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Function Calls](https://developer.hashicorp.com/terraform/language/expressions/function-calls)
- [Built-in Functions](https://developer.hashicorp.com/terraform/language/functions)
- [References to Named Values](https://developer.hashicorp.com/terraform/language/expressions/references)
- [Tutorial: Perform dynamic operations with functions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/functions)

## 🎯 What the exam wants from you

You'll see an expression like `lookup(merge(var.a, var.b), "x", "none")` and must pick the exact result.
No terminal in the exam — you must evaluate it in your head. The only way to get fast at this is practice in `terraform console`.

## 🧪 Lab

1. Open [`exercises.md`](exercises.md). For each line, **write your prediction first**.
2. Then check it:

```bash
terraform init
terraform console
> merge({a=1,b=2},{b=3})
```

The variables in `variables.tf` are available inside the console (`var.tags`, `var.ports` …).

Functions you must know by heart:

| Category | Functions |
|---|---|
| Collections | `merge` `lookup` `keys` `values` `flatten` `concat` `distinct` `contains` `length` `element` `slice` `zipmap` `setproduct` `setunion` `coalescelist` `one` `toset` `tomap` `tolist` |
| Strings | `format` `join` `split` `replace` `lower` `upper` `trimspace` `substr` `startswith` `endswith` `regex` `templatefile` |
| Numbers | `min` `max` `ceil` `floor` `abs` `sum` |
| Encoding | `jsonencode` `jsondecode` `yamlencode` `base64encode` |
| Network | `cidrsubnet` `cidrhost` `cidrsubnets` |
| Errors / types | `try` `can` `coalesce` `type` `nonsensitive` `sensitive` |
| Files | `file` `fileexists` `templatefile` `abspath` |

## ⚠️ Exam traps

- `merge` → **last argument wins** on duplicate keys.
- `lookup(map, key)` without default errors if the key is missing; with default returns the default.
- `element(list, index)` **wraps around** (`element(["a","b"], 3)` = `"b"`); `list[3]` errors.
- `coalesce` skips `null` **and empty strings**; `coalescelist` skips empty lists.
- `join(",", list)` — the separator comes **first**. `split(",", string)` too.
- `cidrsubnet("10.0.0.0/16", 8, 2)` = `"10.0.2.0/24"`.
- `one([])` = `null`, `one(["a"])` = `"a"`, `one(["a","b"])` → error.

## ✅ Self-check

**Q1. `element(["a", "b", "c"], 4)` = ?**

<details><summary>Answer</summary>

`"b"` (4 mod 3 = 1).

</details>

**Q2. `try(var.config.missing.key, "fallback")` where `missing` does not exist = ?**

<details><summary>Answer</summary>

`"fallback"`

</details>

**Q3. `cidrsubnets("10.1.0.0/16", 4, 4, 8)` = ?**

<details><summary>Answer</summary>

`["10.1.0.0/20", "10.1.16.0/20", "10.1.32.0/24"]`

</details>


---
[⬅ Back to the roadmap](../../README.md)
