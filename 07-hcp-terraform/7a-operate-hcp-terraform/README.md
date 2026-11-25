# 7a — Understand how to operate HCP Terraform

🔵 **Needs a free HCP Terraform account** (app.terraform.io) and a token from `terraform login`.

## 📚 Official docs

- [Compare Stacks and workspaces](https://developer.hashicorp.com/terraform/cloud-docs/stack-workspace)
- [Stacks use cases](https://developer.hashicorp.com/terraform/language/stacks/use-cases)
- [Configuration versions API reference](https://developer.hashicorp.com/terraform/cloud-docs/api-docs/configuration-versions)
- [Manage Terraform configurations](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/configurations)
- [The API-driven run workflow](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/api)
- [Health (drift detection & continuous validation)](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/health)
- [Manage and view runs](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/manage)
- [Tutorial: Manage resource drift](https://developer.hashicorp.com/terraform/tutorials/state/resource-drift)
- [Tutorial: Detect infrastructure drift and enforce policies](https://developer.hashicorp.com/terraform/tutorials/cloud/drift-and-policy)

## 🎯 What the exam wants from you

The three run workflows and when to use each, the run lifecycle, health assessments (drift detection +
continuous validation), and Stacks vs workspaces.

| Workflow | Trigger | Use when |
|---|---|---|
| **VCS-driven** | push/PR to a connected repo | standard GitOps; speculative plans on PRs |
| **CLI-driven** | `terraform plan/apply` locally with a `cloud` block | dev experience, runs execute remotely |
| **API-driven** | upload a configuration version + create a run via API | custom CI pipelines / tooling |

**Stacks** = deploy the *same* set of components across many environments/regions/accounts with
orchestration between them. **Workspaces** = one configuration + one state.

## 🧪 Lab

**A — CLI-driven run**
```bash
terraform login
cd cli-driven
# edit main.tf -> your organization
terraform init
terraform plan        # runs in HCP Terraform, output streams to your terminal
terraform apply
```
Open the workspace in the UI: see the run, the state versions, and the plan.

**B — API-driven run** — `api-driven/run.sh` does what a custom CI would do:
1. create a configuration version
2. upload a `.tar.gz` of the code
3. create a run and poll its status
```bash
export TFE_TOKEN=... ORG=... WORKSPACE=api-demo
./api-driven/run.sh ./cli-driven
```
**C — Health:** in workspace settings → Health → enable **drift detection**. Change something outside
Terraform and wait for the assessment (Plus/standard tiers), or read the drift tutorial.

## ⚠️ Exam traps

- Speculative plans (on PRs) **can't be applied**.
- Execution mode: **remote** (HCP runs it), **local** (HCP only stores state), **agent** (runs on your self-hosted agents in a private network).
- Health assessments run `plan -refresh-only` style checks periodically; continuous validation re-evaluates `check` blocks and postconditions.
- CLI-driven runs with the `cloud` block upload your local directory — use `.terraformignore` to exclude files.

## ✅ Self-check

**Q1. Which workflow fits a Jenkins pipeline that must trigger HCP Terraform runs?**

<details><summary>Answer</summary>

API-driven (or CLI-driven from the pipeline with a `cloud` block and `TF_TOKEN_app_terraform_io`).

</details>

**Q2. Execution mode for infrastructure in a private datacenter with no inbound access?**

<details><summary>Answer</summary>

Agent execution mode with HCP Terraform agents inside the network.

</details>


---
[⬅ Back to the roadmap](../../README.md)
