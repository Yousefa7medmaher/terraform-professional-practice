# 6a — Understand when to refactor a configuration into a module

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Creating Modules](https://developer.hashicorp.com/terraform/language/modules/develop)
- [Use input variables to add module arguments](https://developer.hashicorp.com/terraform/language/values/variables)
- [Modules overview](https://developer.hashicorp.com/terraform/language/modules)
- [Use modules in your configuration](https://developer.hashicorp.com/terraform/language/modules/configuration)
- [Publishing Modules](https://developer.hashicorp.com/terraform/language/modules/develop/publish)
- [Tutorial: Build and use a local module](https://developer.hashicorp.com/terraform/tutorials/modules/module-create)
- [Tutorial: Use configuration to move resources](https://developer.hashicorp.com/terraform/tutorials/configuration-language/move-config)
- [Tutorial: Refactor monolithic Terraform configuration](https://developer.hashicorp.com/terraform/tutorials/modules/organize-configuration)

## 🎯 What the exam wants from you

Refactor when the same group of resources is repeated, when a group has a clear single purpose and
contract, or when teams need a standard building block. **Don't** wrap a single resource with no added
logic ("thin wrappers"). The exam also checks you can refactor **without destroying** anything (`moved`).

## 🧪 Lab

`before/` is a monolith that copy-pastes two "web apps". `after/` is the same thing as a module.

```bash
cd before
terraform init && terraform apply -auto-approve
terraform state list
```
Now refactor **in place** (don't use `after/` until you've tried):
1. Create `modules/web-app` from the repeated resources.
2. Replace the resources in `before/main.tf` with two `module` blocks.
3. Add `moved` blocks (one per resource) — see `after/moved.tf`.
4. `terraform init && terraform plan` → must say **0 to add, 0 to change, 0 to destroy** (only moves).

## ⚠️ Exam traps

- Good module = **one purpose**, typed inputs with sensible defaults, useful outputs, no provider configuration.
- A module that just passes every argument through to one resource adds maintenance without value.
- After moving code into a module, you need `terraform init` (new module) **and** `moved` blocks to keep state.

## ✅ Self-check

**Q1. Which signals mean you should create a module?**

<details><summary>Answer</summary>

Repeated resource groups, a reusable pattern with a clear interface, or standardizing infrastructure across teams.

</details>

**Q2. You moved `aws_instance.web` into `module.app`. How do you avoid recreation?**

<details><summary>Answer</summary>

`moved { from = aws_instance.web  to = module.app.aws_instance.web }`

</details>


---
[⬅ Back to the roadmap](../../README.md)
