# 2c — Identify dependency chains before upgrades

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Command: providers](https://developer.hashicorp.com/terraform/cli/commands/providers)
- [Provider Requirements](https://developer.hashicorp.com/terraform/language/providers/requirements)
- [terraform graph command](https://developer.hashicorp.com/terraform/cli/commands/graph)
- [Dependency Graph](https://developer.hashicorp.com/terraform/internals/graph)
- [terraform block reference](https://developer.hashicorp.com/terraform/language/block/terraform)
- [Version constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)
- [import block reference](https://developer.hashicorp.com/terraform/language/block/import)
- [moved block reference](https://developer.hashicorp.com/terraform/language/block/moved)
- [removed block reference](https://developer.hashicorp.com/terraform/language/block/removed)
- [Tutorial: Create resource dependencies](https://developer.hashicorp.com/terraform/tutorials/configuration-language/dependencies)
- [Tutorial: Lock and upgrade provider versions](https://developer.hashicorp.com/terraform/tutorials/configuration-language/provider-versioning)

## 🎯 What the exam wants from you

Before upgrading a provider or module you need to know **who depends on what**: implicit
dependencies (references), explicit `depends_on`, which modules pin which provider versions
(`terraform providers`), and how to read `terraform graph`.

## 🧪 Lab

```bash
terraform init
terraform providers                      # which module requires which provider + constraint
terraform graph | dot -Tsvg > graph.svg  # needs graphviz; or paste output at https://dreampuf.github.io/GraphvizOnline
terraform apply -auto-approve
```
**Questions to answer from the graph:**
1. Which resource is created first? Why?
2. `local_file.app_config` has no reference to `random_password.db` — why does it still wait for it?
3. In `modules/legacy`, the provider constraint is `< 3.6`. Root wants `~> 3.7`. Run `terraform init` and read the error — this is the "dependency conflict before an upgrade" scenario. Fix: upgrade the module's constraint.

## ⚠️ Exam traps

- Implicit dependency (a reference) is **preferred**; `depends_on` only when the dependency is hidden (e.g. IAM policy must exist before an app works).
- `depends_on` on a **module** makes *every* resource in it wait — and can make data sources inside it deferred to apply.
- All constraints for a provider (root + every module) are **combined**; init fails if no version satisfies them all.
- `terraform providers` shows the constraint per module — first command to run before an upgrade.

## ✅ Self-check

**Q1. A module requires `aws < 5.0`, your root requires `aws >= 6.0`. What happens at init?**

<details><summary>Answer</summary>

Init fails: no available version satisfies all constraints. You must upgrade/fork the module first.

</details>

**Q2. When do you need `depends_on`?**

<details><summary>Answer</summary>

Only when there's a dependency Terraform can't see from references (hidden/behavioral dependency).

</details>


---
[⬅ Back to the roadmap](../../README.md)
