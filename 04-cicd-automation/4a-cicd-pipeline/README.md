# 4a — Manage CI/CD pipeline functionality

📖 **Reading + config only** — no infrastructure is created.

## 📚 Official docs

- [terraform plan command](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [Tutorial: Deploy infrastructure with Terraform and CircleCI](https://developer.hashicorp.com/terraform/tutorials/automation/circle-ci)
- [Tutorial: Automate Terraform with GitHub Actions](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)

## 🎯 What the exam wants from you

The standard pipeline: **PR → fmt/validate/plan (comment the plan) → review → merge → apply the saved plan**.
Know why you save the plan, why `-input=false`, and how approvals fit.

## 🧪 Lab

1. Copy [`github-actions/terraform.yml`](github-actions/terraform.yml) to `.github/workflows/terraform.yml` in a **separate test repo**.
2. Put the code from `infra/` in that repo.
3. Create a PR → watch the `plan` job; merge → watch `apply` (uses the GitHub `production` environment for manual approval).
4. Break formatting on purpose → the `fmt -check` step must fail the PR.

The workflow uses OIDC to AWS (no static keys) — set that up in [4c](../4c-dynamic-credentials).

## ⚠️ Exam traps

- `terraform fmt -check` exits non-zero if files aren't formatted — that's what CI uses.
- `plan -out=tfplan` + `apply tfplan` guarantees you apply **what was reviewed**. The plan file can contain secrets → treat it as sensitive.
- Always `-input=false` in automation so Terraform never waits for a prompt.
- Apply should run from **one** place (the main branch / one job) to avoid concurrent applies; the backend lock is the safety net.

## ✅ Self-check

**Q1. Why apply a saved plan file in CI instead of running `apply -auto-approve`?**

<details><summary>Answer</summary>

To apply exactly the reviewed changes; if anything changed since, the stale plan is rejected.

</details>

**Q2. Which flag prevents Terraform from prompting for missing variables in CI?**

<details><summary>Answer</summary>

`-input=false`

</details>


---
[⬅ Back to the roadmap](../../README.md)
