# 1a — Translate business requirements into infrastructure code

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Function Calls](https://developer.hashicorp.com/terraform/language/expressions/function-calls)
- [Resource Address Reference](https://developer.hashicorp.com/terraform/cli/state/resource-addressing)
- [for_each reference](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
- [variable block reference](https://developer.hashicorp.com/terraform/language/block/variable)
- [Use input variables to add module arguments](https://developer.hashicorp.com/terraform/language/values/variables)
- [module block reference](https://developer.hashicorp.com/terraform/language/block/module)
- [Validate your configuration](https://developer.hashicorp.com/terraform/language/validate)
- [Tutorial: Perform dynamic operations with functions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/functions)

## 🎯 What the exam wants from you

You get a short business story ("every team needs X, prod must have Y, names must follow Z")
and must pick the configuration that implements it. That means: typed variables that model
the requirement, `validation` blocks that reject bad input, `for_each` over a map of teams,
and naming rules built with functions.

## 🧪 Lab

**Business requirement (the "ticket"):**

> Each team gets one storage area per environment. Names must be `<team>-<env>-<suffix>`, all lowercase.
> Only `dev`, `stage` and `prod` are allowed. Prod storage must have versioning on.
> Every team must have a cost-center tag that starts with `CC-`.

The code in this folder implements that ticket with a local module that writes a JSON "manifest"
file per storage area (so you can run it for free).

```bash
terraform init
terraform plan
terraform apply -auto-approve
ls manifests/            # one file per team+env
terraform state list     # see the module.storage["..."] addresses
```

**Your tasks:**
1. Add a new team `data` with a bad cost center `1234` → watch `validation` fail at plan.
2. Add environment `qa` → it must fail. Then change the requirement to allow `qa`.
3. Add a new requirement: *prod names must end in `-critical`*. Implement it with a conditional.
4. `terraform destroy -auto-approve` when done.

## ⚠️ Exam traps

- `validation` can reference **only the variable itself** in old versions; since Terraform 1.9 it can
  reference other variables, locals and data sources too. Know both facts.
- `for_each` needs a **map or set of strings** — a `list` must be wrapped in `toset()`.
- The key of `for_each` becomes part of the address: `module.storage["platform-prod"]`.

## ✅ Self-check

**Q1. A requirement says “environment must be one of dev, stage, prod”. Which is the cleanest way to enforce it?**

<details><summary>Answer</summary>

A `validation` block on the variable: `condition = contains(["dev","stage","prod"], var.environment)`.

</details>

**Q2. Why is a `map(object({...}))` better than three separate list variables for the teams?**

<details><summary>Answer</summary>

It keeps each team's attributes together, gives stable `for_each` keys (team name) and the type constraint documents the contract.

</details>


---
[⬅ Back to the roadmap](../../README.md)
