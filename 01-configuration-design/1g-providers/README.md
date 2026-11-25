# 1g — Configure Terraform providers

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [provider block reference](https://developer.hashicorp.com/terraform/language/block/provider)
- [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers)
- [Provider Requirements](https://developer.hashicorp.com/terraform/language/providers/requirements)
- [Dependency Lock File](https://developer.hashicorp.com/terraform/language/files/dependency-lock)
- [terraform providers lock command](https://developer.hashicorp.com/terraform/cli/commands/providers/lock)
- [Tutorial: Lock and upgrade provider versions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/provider-versioning)

## 🎯 What the exam wants from you

Multi-region / multi-account with `alias`, passing aliased providers into modules with
`providers = {}` + `configuration_aliases`, version constraints, and how the lock file behaves.

## 🧪 Lab

```bash
terraform init               # creates .terraform.lock.hcl -> commit it!
cat .terraform.lock.hcl
terraform providers          # tree of which module needs which provider
terraform validate
```

**Lock file experiments:**
1. Change `version = "~> 6.0"` to `"~> 5.0"` and run `terraform init` → error: locked version doesn't match. Fix with `terraform init -upgrade`.
2. Your team uses Mac (arm64) + Linux CI. Generate hashes for all:
   ```bash
   terraform providers lock -platform=linux_amd64 -platform=darwin_arm64 -platform=windows_amd64
   ```

## ⚠️ Exam traps

- `terraform init` **respects** the lock file; only `init -upgrade` picks newer versions inside the constraint.
- The lock file tracks **providers only**, not modules.
- A child module that needs an aliased provider declares `configuration_aliases = [aws.replica]` in its `required_providers`.
- Modules with their own `provider` block can't be used with `count`/`for_each`/`depends_on`.
- Default provider = the one without `alias`. Resources pick an alias with `provider = aws.west`.

## ✅ Self-check

**Q1. CI runs on Linux but the lock file was created on a Mac; `init` fails with a checksum error. Fix?**

<details><summary>Answer</summary>

Run `terraform providers lock -platform=linux_amd64 -platform=darwin_arm64` and commit the updated lock file.

</details>

**Q2. How does a resource use a non-default provider configuration?**

<details><summary>Answer</summary>

`provider = aws.<alias>` meta-argument.

</details>


---
[⬅ Back to the roadmap](../../README.md)
