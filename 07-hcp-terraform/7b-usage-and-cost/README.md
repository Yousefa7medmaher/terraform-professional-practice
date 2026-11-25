# 7b — Track resource usage and cost

🔵 **Needs a free HCP Terraform account** (app.terraform.io) and a token from `terraform login`.

## 📚 Official docs

- [Manage workspace state](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/state)
- [Estimate HCP Terraform cost](https://developer.hashicorp.com/terraform/cloud-docs/overview/estimate-cost)
- [Cost estimation overview](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/cost-estimation)
- [Run states and stages](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/states)
- [Data Source: tfe_organization](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/organization)
- [UI and VCS-driven run workflow](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/ui)

## 🎯 What the exam wants from you

Two different things are called "cost":
1. **Cloud cost** of your infrastructure → HCP Terraform **cost estimation** (runs after plan, before policy checks; Sentinel can read it through `tfrun`).
2. **HCP Terraform billing** → based on **managed resources** (resources under management in state). Know how to see the count and reduce it.

Run stages: `pending → planning → planned → cost estimating → policy checking → (confirm) → applying → applied`.

## 🧪 Lab

1. Enable cost estimation: **Organization settings → Cost estimation**.
2. Use a workspace with AWS resources (e.g. [6c](../../06-modules-registry/6c-registry) with dynamic credentials from [4c](../../04-cicd-automation/4c-dynamic-credentials)) and run a plan → read the cost estimate panel.
3. Policy on cost — `cost-limit.sentinel`:
   add it to a policy set and plan something expensive.
4. Read your org's usage with the `tfe` provider:
```bash
cd usage
terraform init
terraform apply -var='organization=YOUR_ORG'
```

## ⚠️ Exam traps

- Cost estimation only supports some resources of AWS/Azure/GCP — unsupported resources show as "unestimated".
- Cost estimation happens **before** policy checks, so policies can use `tfrun.cost_estimate.delta_monthly_cost`.
- Data sources and `terraform_data`/`null_resource` don't count the same way as managed cloud resources — read the billing doc for what counts.

## ✅ Self-check

**Q1. In which order do cost estimation and policy checks run?**

<details><summary>Answer</summary>

Plan → cost estimation → policy checks → apply.

</details>

**Q2. How can a policy block a change that adds more than $500/month?**

<details><summary>Answer</summary>

Sentinel with `import "tfrun"` and check `tfrun.cost_estimate.delta_monthly_cost`.

</details>


---
[⬅ Back to the roadmap](../../README.md)
