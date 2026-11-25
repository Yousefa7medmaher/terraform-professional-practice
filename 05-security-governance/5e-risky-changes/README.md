# 5e — Identify and mitigate risky infrastructure changes

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [terraform plan command](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [resource block reference](https://developer.hashicorp.com/terraform/language/block/resource)
- [lifecycle reference](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)
- [Manage sensitive data in your configuration](https://developer.hashicorp.com/terraform/language/manage-sensitive-data)
- [Function Calls](https://developer.hashicorp.com/terraform/language/expressions/function-calls)
- [Tutorial: Protect sensitive input variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables)

## 🎯 What the exam wants from you

Spot dangerous plans (destroys, **replacements** of stateful resources, security-group openings) and put
guard rails in place: `prevent_destroy`, `create_before_destroy`, `precondition`, policy checks,
an automated plan scanner in CI, and human approval.

## 🧪 Lab

```bash
terraform init && terraform apply -auto-approve
# make a risky change: change var.db_engine_version (forces replacement of the "database")
terraform plan -var='db_engine_version=16' -out=tfplan
terraform show -json tfplan > plan.json
./check-plan.sh plan.json        # fails if anything is deleted or replaced
```
Then:
1. Uncomment `prevent_destroy = true` in `main.tf` and plan again → Terraform refuses.
2. Try `var.allowed_cidr = "0.0.0.0/0"` → the `precondition` blocks it.

## ⚠️ Exam traps

- In `resource_changes[].change.actions`: `["delete","create"]` = replace (destroy first), `["create","delete"]` = replace with `create_before_destroy`, `["delete"]` = destroy.
- "Forces replacement" on a database = data loss risk. Mitigate with `prevent_destroy`, snapshots, or a different upgrade path (e.g. in-place major version upgrade with `allow_major_version_upgrade`).
- `ignore_changes` hides drift — use carefully, it can mask risky manual changes.

## ✅ Self-check

**Q1. What JSON `actions` value means a resource will be replaced with create_before_destroy?**

<details><summary>Answer</summary>

`["create", "delete"]`

</details>

**Q2. What stops an accidental `terraform destroy` of a production database in code?**

<details><summary>Answer</summary>

`lifecycle { prevent_destroy = true }` (plus policies / approvals).

</details>


---
[⬅ Back to the roadmap](../../README.md)
