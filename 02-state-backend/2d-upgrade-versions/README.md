# 2d — Upgrade Terraform versions across environments

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [terraform block reference](https://developer.hashicorp.com/terraform/language/block/terraform)
- [Version constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)
- [Tutorial: Manage Terraform versions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/versions)

## 🎯 What the exam wants from you

Safely move a fleet of configurations (dev → stage → prod) to a new Terraform version: pin with
`required_version`, test in the lowest environment first, and understand that a newer version
**upgrades the state format** so older binaries can't read it afterwards.

## 🧪 Lab

1. Install a version manager: [`tfenv`](https://github.com/tfutils/tfenv) or [`tfswitch`](https://tfswitch.warrensbox.com/).
2. In `envs/dev`, `envs/prod` there is a `.terraform-version` file and `required_version`.
```bash
cd envs/dev
tfenv install 1.14.0 && tfenv use 1.14.0
terraform init && terraform apply -auto-approve
# Upgrade dev first
echo "1.15.0" > .terraform-version && tfenv install
# edit versions.tf -> required_version = "~> 1.15.0"
terraform init && terraform plan          # must show NO changes before you continue
terraform apply -auto-approve
```
3. Now try to run the old 1.14 binary against the upgraded state → see why the upgrade order and backups (state versioning) matter.
4. Repeat for prod only after dev is clean.

## ⚠️ Exam traps

| Constraint | Means |
|---|---|
| `= 1.15.0` / `1.15.0` | exactly |
| `>= 1.10` | 1.10 or newer (no upper bound — risky) |
| `~> 1.15.0` | `>= 1.15.0, < 1.16.0` (patch only) |
| `~> 1.15` | `>= 1.15, < 2.0` (minor + patch) |
| `>= 1.10, < 2.0` | range |

- `required_version` checks the **CLI** version; `required_providers` checks providers.
- Upgrade path: read the upgrade guide, run `plan` → expect **no changes**, then apply. Do one environment at a time.

## ✅ Self-check

**Q1. `required_version = "~> 1.15"` — is Terraform 1.16.2 allowed? 2.0.0?**

<details><summary>Answer</summary>

1.16.2 yes; 2.0.0 no.

</details>

**Q2. Why upgrade dev before prod?**

<details><summary>Answer</summary>

To catch breaking changes on low-risk infra first; once state is written by a newer version, older binaries may not read it.

</details>


---
[⬅ Back to the roadmap](../../README.md)
