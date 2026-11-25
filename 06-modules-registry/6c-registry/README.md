# 6c — Use the Terraform registry to build or update a configuration

🟡 **AWS config** — `terraform init && terraform validate` work without credentials. `plan`/`apply` need an AWS account (stay in free tier and `destroy` afterwards).

## 📚 Official docs

- [module block reference](https://developer.hashicorp.com/terraform/language/block/module)
- [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
- [Create a Terraform CLI configuration file](https://developer.hashicorp.com/terraform/cli/config/config-file)
- [Use modules in your configuration](https://developer.hashicorp.com/terraform/language/modules/configuration)
- [variable block reference](https://developer.hashicorp.com/terraform/language/block/variable)
- [Tutorial: Use registry modules in configuration](https://developer.hashicorp.com/terraform/tutorials/modules/module-use)

## 🎯 What the exam wants from you

Read a registry module page (inputs, outputs, examples, versions), use it with a proper `version`
constraint, and know source address formats for public, private (HCP Terraform / Enterprise) and Git modules,
plus the **standard module structure** required to publish.

## 🧪 Lab

1. Open [terraform-aws-modules/s3-bucket/aws](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest) and find:
   required inputs, the output with the bucket ARN, the latest version.
2. `main.tf` uses it — run `terraform init && terraform validate`.
3. Look inside `.terraform/modules/` to see the module's real structure.
4. **Private registry (HCP):** publish `../6b-module-contract/modules/bucket` to your org:
   - it must be in its own repo named `terraform-<PROVIDER>-<NAME>` (e.g. `terraform-local-bucket`)
   - tag a SemVer release `v1.0.0`
   - then use `source = "app.terraform.io/YOUR_ORG/bucket/local"`

**Standard module structure:**
```
terraform-aws-bucket/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── LICENSE
├── modules/        # nested sub-modules
├── examples/       # runnable examples
└── tests/          # terraform test files
```

## ⚠️ Exam traps

| Source | Format |
|---|---|
| Public registry | `NAMESPACE/NAME/PROVIDER` → `terraform-aws-modules/vpc/aws` |
| Private registry | `HOSTNAME/ORG/NAME/PROVIDER` → `app.terraform.io/acme/vpc/aws` |
| Git | `git::https://github.com/org/repo.git//subdir?ref=v1.2.0` |
| Local | `./modules/vpc` (no `version` allowed) |

- `version` only for registry sources.
- Private registry auth: `terraform login` or a `credentials` block / `TF_TOKEN_<host>` env var.
- Repos for registry publishing must be named `terraform-<PROVIDER>-<NAME>` and use SemVer tags.

## ✅ Self-check

**Q1. What's the source for module `network` (provider `aws`) in org `acme` on HCP Terraform?**

<details><summary>Answer</summary>

`app.terraform.io/acme/network/aws`

</details>

**Q2. Can you use `version = "1.0.0"` with a Git source?**

<details><summary>Answer</summary>

No — use `?ref=` in the URL instead.

</details>


---
[⬅ Back to the roadmap](../../README.md)
