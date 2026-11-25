# 3b — Plan changes to infrastructure

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [terraform plan command](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [Tutorial: Use refresh-only mode to sync Terraform state](https://developer.hashicorp.com/terraform/tutorials/state/refresh)

## 🎯 What the exam wants from you

All the `plan` modes and flags, and how to read plan symbols.

| Symbol | Meaning |
|---|---|
| `+` | create |
| `-` | destroy |
| `~` | update in-place |
| `-/+` | destroy then create (replace) |
| `+/-` | create then destroy (replace with `create_before_destroy`) |
| `<=` | read (data source) |

## 🧪 Lab

```bash
terraform init
terraform plan                                  # normal
terraform plan -out=tfplan                      # save it -> apply exactly this
terraform plan -destroy                         # what would destroy remove?
terraform plan -refresh-only                    # drift only
terraform plan -replace='random_pet.a'          # force replacement of one resource
terraform plan -target='random_pet.b'           # only one resource (exceptional use!)
terraform plan -var='length=5'                  # change an attribute that forces replacement
terraform plan -detailed-exitcode; echo $?      # 0 = no changes, 1 = error, 2 = changes
terraform plan -generate-config-out=gen.tf      # used with import blocks (see 3d)
```
Apply once, then run each command and **predict the symbol** before reading the output.

## ⚠️ Exam traps

- `-detailed-exitcode` → `2` means "changes present" (useful for drift detection in CI).
- `-target` is for **exceptional** situations (recovering from errors); HashiCorp warns against routine use.
- `-replace` replaced the deprecated `terraform taint`.
- An attribute marked "forces replacement" turns `~` into `-/+`.

## ✅ Self-check

**Q1. CI must fail a nightly job if there's drift. Which flag?**

<details><summary>Answer</summary>

`terraform plan -detailed-exitcode` (exit code 2 = changes).

</details>

**Q2. What replaced `terraform taint`?**

<details><summary>Answer</summary>

`terraform apply -replace=ADDRESS` (or `plan -replace`).

</details>


---
[⬅ Back to the roadmap](../../README.md)
