# 7e — Define Policy as Code in a CI/CD pipeline

🔵 **Needs a free HCP Terraform account** (app.terraform.io) and a token from `terraform login`.

## 📚 Official docs

- [Manage policies and policy sets in HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs/policy-enforcement/manage-policy-sets)
- [Configure connections to policy sets](https://developer.hashicorp.com/terraform/cloud-docs/policy-enforcement/manage-policy-sets/configure)
- [Sentinel enforcement levels](https://developer.hashicorp.com/sentinel/docs/concepts/enforcement-levels)
- [View policy enforcement results](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/policy-enforcement/view-results)
- [Tutorial: Upload your Sentinel policy set to HCP Terraform](https://developer.hashicorp.com/terraform/tutorials/policy/sentinel-cloud-integration)

## 🎯 What the exam wants from you

Policy sets can come from **VCS** (auto-updated on push), be **uploaded** via API/CLI from a pipeline,
or be managed with the tfe provider. Test policies in CI with the Sentinel CLI **before** they reach
HCP Terraform, and know where to view results (run page → policy check).

## 🧪 Lab

```
7e-policy-as-code-pipeline/
├── policies/
│   ├── sentinel.hcl
│   ├── restrict-instance-types.sentinel
│   └── test/restrict-instance-types/
│       ├── pass.hcl
│       ├── fail.hcl
│       └── mock-tfplan-pass.sentinel / mock-tfplan-fail.sentinel
├── policy-set.tf               # policy set managed with the tfe provider (VCS-backed)
└── github-actions/sentinel.yml # CI: sentinel fmt + sentinel test
```
```bash
cd policies
sentinel test -verbose      # runs pass/fail cases against mock plans
sentinel fmt -check=true .
```
Then connect the policy set (`policy-set.tf`) and run a plan in a workspace with an `m5.4xlarge` → open the run → **Policy check** to view the result.

Tip: generate real mocks from any HCP run: run page → **Download Sentinel mocks**.

## ⚠️ Exam traps

- Policy sets from VCS update automatically when you push; uploaded versions need a new upload.
- `sentinel test` looks in `test/<policy-name>/*.hcl`; each test file sets `mock` data and expected `test { rules = { main = true } }`.
- Policy set scope: global, projects, or specific workspaces; you can **exclude** workspaces too.
- Overrides of soft-mandatory failures are logged (audit trail).

## ✅ Self-check

**Q1. Where do you find downloadable mock data to test Sentinel policies?**

<details><summary>Answer</summary>

On an HCP Terraform run page (plan) → Download Sentinel mocks.

</details>

**Q2. What does `sentinel test` need for each policy?**

<details><summary>Answer</summary>

A `test/<policy>/` folder with test case `.hcl` files referencing mocks and the expected rule results.

</details>


---
[⬅ Back to the roadmap](../../README.md)
