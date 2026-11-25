# 3d — Import existing infrastructure

🟠 **Needs an AWS account** — creates real resources. Always `terraform destroy` when you finish.

## 📚 Official docs

- [Generating configuration](https://developer.hashicorp.com/terraform/language/import/generating-configuration)
- [Import a single resource](https://developer.hashicorp.com/terraform/language/import/single-resource)
- [import block reference](https://developer.hashicorp.com/terraform/language/block/import)
- [Tutorial: Import Terraform configuration](https://developer.hashicorp.com/terraform/tutorials/state/state-import)

## 🎯 What the exam wants from you

Bring resources created by hand under Terraform management with the **`import` block** (code-reviewed,
plannable, supports `for_each`) and `-generate-config-out` to write the HCL for you. Know the legacy
`terraform import` command too.

## 🧪 Lab

1. Create resources **outside** Terraform (simulating ClickOps):
```bash
aws s3api create-bucket --bucket yousef-clickops-1 --region us-east-1
aws s3api create-bucket --bucket yousef-clickops-2 --region us-east-1
```
2. Edit `import.tf` with your bucket names.
3. Generate configuration:
```bash
terraform init
terraform plan -generate-config-out=generated.tf
```
4. Review `generated.tf` (clean up attributes, move to `main.tf`), then:
```bash
terraform plan        # should show "2 to import, 0 to add, 0 to change"
terraform apply
```
5. Remove the `import` blocks afterwards (optional — they're no-ops once imported).
6. `terraform destroy` to clean up.

## ⚠️ Exam traps

- `import` blocks are processed during **plan/apply** → reviewable in a PR; `terraform import` CLI changes state immediately with no plan.
- `-generate-config-out` only works for resources **not** already in your config, and the file must not already exist.
- `import` + `for_each` (Terraform ≥ 1.7) imports many at once.
- Import does **not** create the resource and does not write code for you (unless you generate config).

## ✅ Self-check

**Q1. Which approach lets teammates review an import in a pull request?**

<details><summary>Answer</summary>

An `import` block (it appears in the plan).

</details>

**Q2. You have 20 existing buckets in a map. Fastest way to import them?**

<details><summary>Answer</summary>

One `import` block with `for_each` over the map and `to = aws_s3_bucket.this[each.key]`.

</details>


---
[⬅ Back to the roadmap](../../README.md)
