# 4d — Overwrite Terraform variables using auto.tfvars / .tfvars

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Use input variables to add module arguments](https://developer.hashicorp.com/terraform/language/values/variables)
- [Tutorial: Customize Terraform configuration with variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables)

## 🎯 What the exam wants from you

Know the **exact order** Terraform loads variable values (later wins):

1. `default` in the `variable` block
2. Environment variables `TF_VAR_name`
3. `terraform.tfvars`
4. `terraform.tfvars.json`
5. `*.auto.tfvars` / `*.auto.tfvars.json` — in **lexical (alphabetical) order** of filename
6. `-var` and `-var-file` on the command line — in the **order given**

In HCP Terraform, workspace variables override `.tfvars` values committed in the configuration, and
`-var` / `-var-file` flags aren't supported for remote runs (see the *Variables overview* doc in section 7c).

## 🧪 Lab

Every file in this folder sets `var.color` to a different value. Predict, then run:
```bash
terraform init
terraform apply -auto-approve                       # ? (b.auto.tfvars wins over a.auto.tfvars)
TF_VAR_color=env terraform apply -auto-approve      # ? (env loses to any tfvars file)
terraform apply -auto-approve -var-file=extra.tfvars          # ?
terraform apply -auto-approve -var='color=cli' -var-file=extra.tfvars   # ? (last flag wins)
terraform apply -auto-approve -var-file=extra.tfvars -var='color=cli'   # ?
```
Then delete `b.auto.tfvars` and run again. Then rename `extra.tfvars` → `extra.auto.tfvars`.

## ⚠️ Exam traps

- `terraform.tfvars` is loaded automatically; **`prod.tfvars` is not** (needs `-var-file`) unless named `*.auto.tfvars`.
- `TF_VAR_` env vars are **lower** priority than any `.tfvars` file.
- On the command line, `-var` and `-var-file` are processed **in order** — the last one wins.
- Complex types via CLI: `-var='tags={env="dev"}'`; via env: `TF_VAR_tags='{env="dev"}'`.

## ✅ Self-check

**Q1. `terraform.tfvars` sets x=1, `a.auto.tfvars` x=2, `z.auto.tfvars` x=3, `TF_VAR_x=4`. Value?**

<details><summary>Answer</summary>

`3` — `z.auto.tfvars` loads last among auto files.

</details>

**Q2. Same as above plus `-var='x=5'`?**

<details><summary>Answer</summary>

`5` — command-line flags win.

</details>


---
[⬅ Back to the roadmap](../../README.md)
