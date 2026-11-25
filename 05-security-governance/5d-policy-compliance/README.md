# 5d — Establish core compliance/policy rules plus team/project-specific policies

🔵 **Needs a free HCP Terraform account** (app.terraform.io) and a token from `terraform login`.

## 📚 Official docs

- [HCP Terraform private registry overview](https://developer.hashicorp.com/terraform/cloud-docs/registry)
- [Manage policies and policy sets in HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs/policy-enforcement/manage-policy-sets)
- [Blog: Enforce private module registry usage with Sentinel](https://www.hashicorp.com/en/blog/enforce-private-module-registry-usage-in-terraform-with-sentinel)
- [UI and VCS-driven run workflow](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/ui)
- [GitOps workflow](https://developer.hashicorp.com/well-architected-framework/define-and-automate-processes/process-automation/gitops)
- [HCP audit log streaming](https://developer.hashicorp.com/hcp/docs/hcp/audit-log)
- [Audit trails API reference](https://developer.hashicorp.com/terraform/cloud-docs/api-docs/audit-trails)
- [Manage sensitive data in your configuration](https://developer.hashicorp.com/terraform/language/manage-sensitive-data)
- [Policy enforcement in workspaces](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/policy-enforcement)
- [Tutorial: Enforce a policy](https://developer.hashicorp.com/terraform/tutorials/policy/policy-quickstart)
- [Tutorial: Detect infrastructure drift and enforce policies](https://developer.hashicorp.com/terraform/tutorials/policy/drift-and-policy)

## 🎯 What the exam wants from you

Policy-as-code in HCP Terraform: **Sentinel** or **OPA** policies grouped in **policy sets**, applied
**globally** (org-wide core rules) or to specific **projects/workspaces** (team rules), with enforcement levels.
Plus governance helpers: private registry, audit trails, VCS/GitOps workflow.

## 🧪 Lab

Folder layout = one policy-set repo:
```
sentinel/
├── global/                     # applied to ALL workspaces (core compliance)
│   ├── sentinel.hcl
│   ├── require-private-modules.sentinel
│   └── require-tags.sentinel
└── team-payments/              # applied to the payments project only
    ├── sentinel.hcl
    └── restrict-instance-types.sentinel
opa/
└── deny-public-s3.rego         # OPA alternative
```
1. Install the [Sentinel CLI](https://developer.hashicorp.com/sentinel/install) and run `sentinel fmt` on the files.
2. In HCP Terraform: **Settings → Policy sets → Connect a new policy set** → choose this repo, path `05-security-governance/5d-policy-compliance/sentinel/global`, scope **global**.
3. Create a second policy set for `team-payments`, scoped to one **project**.
4. Run a plan in a workspace that uses `t3.2xlarge` → see the soft-mandatory failure and the **override** button.

## ⚠️ Exam traps

| Level | Fails → | Who can continue |
|---|---|---|
| `advisory` | warning only | run continues |
| `soft-mandatory` | run stops | users with **override** permission |
| `hard-mandatory` | run stops | nobody — fix the code |

- Policies run **after plan, before apply** (and after cost estimation).
- `tfplan/v2` = planned changes; `tfconfig/v2` = the code (e.g. module sources); `tfstate/v2` = current state; `tfrun` = run metadata (workspace, cost).
- Core rules → global policy set (or one scoped to all projects); team rules → project-scoped set.

## ✅ Self-check

**Q1. A policy must stop runs but a security lead should be able to approve exceptions. Level?**

<details><summary>Answer</summary>

`soft-mandatory`

</details>

**Q2. Which Sentinel import checks that every module comes from the private registry?**

<details><summary>Answer</summary>

`tfconfig/v2` (inspect `module_calls[*].source`).

</details>


---
[⬅ Back to the roadmap](../../README.md)
