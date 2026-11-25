# 3a — Manage and scale infrastructure projects

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [module block reference](https://developer.hashicorp.com/terraform/language/block/module)
- [Modules overview](https://developer.hashicorp.com/terraform/language/modules)
- [terraform init command](https://developer.hashicorp.com/terraform/cli/commands/init)
- [Backend block configuration overview](https://developer.hashicorp.com/terraform/language/backend)
- [Manage Workspaces Overview](https://developer.hashicorp.com/terraform/cli/workspaces)
- [Tutorial: Build and use a local module](https://developer.hashicorp.com/terraform/tutorials/modules/module-create)

## 🎯 What the exam wants from you

How to split a growing codebase: a thin **root module** per environment/component that composes
reusable **child modules**, a separate state per component (blast radius), and when workspaces are
(or aren't) the right tool.

## 🧪 Lab

Layout used here:
```
3a-manage-scale-projects/
├── modules/
│   ├── network/      # reusable building blocks
│   └── app/
└── live/
    ├── network/      # own state  -> rarely changes
    └── app/          # own state  -> changes daily, reads network via remote state
```
```bash
cd live/network && terraform init && terraform apply -auto-approve
cd ../app && terraform init && terraform apply -auto-approve
terraform output
```
**Think about:** if `app` and `network` were in one state, what would a bad `apply` on the app put at risk?

## ⚠️ Exam traps

- Smaller states = smaller blast radius + faster plans + separate permissions.
- `terraform init` downloads modules too; after changing a module `source` or `version`, re-run `init` (`-upgrade` for newer versions).
- CLI workspaces share the **same code and backend** — fine for identical copies (dev/test), not for environments that need different access controls or very different config.

## ✅ Self-check

**Q1. A single state holds network, databases and 40 apps. Plans take 15 minutes and every change risks the DB. Best improvement?**

<details><summary>Answer</summary>

Split into separate root modules/states per component (network, data, apps) and share values via outputs/remote state/data sources.

</details>

**Q2. You add a new `module` block. What must you run before `plan`?**

<details><summary>Answer</summary>

`terraform init` (to install the module).

</details>


---
[⬅ Back to the roadmap](../../README.md)
