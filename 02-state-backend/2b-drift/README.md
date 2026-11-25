# 2b — Manage state and remediate drift

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [terraform init command](https://developer.hashicorp.com/terraform/cli/commands/init)
- [terraform plan command](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [Tutorial: Manage resource drift](https://developer.hashicorp.com/terraform/tutorials/state/resource-drift)

## 🎯 What the exam wants from you

Drift = the real infrastructure changed outside Terraform. You must know how to **detect** it
(`plan`, `plan -refresh-only`, HCP Terraform health checks) and the two ways to **remediate**:
accept reality into state (`apply -refresh-only` / update code) or overwrite reality (`apply`).

## 🧪 Lab

```bash
terraform init && terraform apply -auto-approve
cat out/config.txt
```
**Simulate drift:**
```bash
echo "changed by hand" > out/config.txt     # someone edited the server
terraform plan                               # Terraform wants to put it back
terraform plan -refresh-only                 # only shows what changed outside Terraform
```
**Simulate deletion:**
```bash
rm out/config.txt
terraform plan            # "has been deleted" -> will be created again
terraform apply -auto-approve
```
**Accept a change:** for attributes you *want* to keep as changed, update the code to match, or use
`terraform apply -refresh-only` to update state without changing infrastructure.

## ⚠️ Exam traps

- `terraform refresh` is **deprecated** → use `terraform apply -refresh-only`.
- `plan -refresh=false` skips checking real infrastructure (faster, but can't detect drift).
- `apply -refresh-only` updates **state only**, never infrastructure.
- If drift should be ignored permanently for an attribute (e.g. autoscaling desired count), use `lifecycle { ignore_changes = [...] }`.

## ✅ Self-check

**Q1. Someone added a tag in the AWS console. You want Terraform's state to reflect it without changing anything in AWS. Command?**

<details><summary>Answer</summary>

`terraform apply -refresh-only` (then update the code, or the next normal apply will remove the tag).

</details>

**Q2. What's the difference between `plan` and `plan -refresh-only`?**

<details><summary>Answer</summary>

`plan` proposes changes to make infrastructure match the code. `plan -refresh-only` only shows how state would be updated to match real infrastructure.

</details>


---
[⬅ Back to the roadmap](../../README.md)
