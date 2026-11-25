# 5c — Secure CI/CD pipeline identities and access

🟠 **Needs an AWS account** — creates real resources. Always `terraform destroy` when you finish.

## 📚 Official docs

- [Dynamic provider credentials](https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials)
- [Terraform CLI environment variables reference](https://developer.hashicorp.com/terraform/cli/config/environment-variables)
- [Manage sensitive data in your configuration](https://developer.hashicorp.com/terraform/language/manage-sensitive-data)
- [Use input variables to add module arguments](https://developer.hashicorp.com/terraform/language/values/variables)
- [Workload identity](https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials/workload-identity-tokens)
- [Tutorial: Authenticate providers with dynamic credentials](https://developer.hashicorp.com/terraform/tutorials/cloud/dynamic-credentials)
- [Tutorial: Protect sensitive input variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables)

## 🎯 What the exam wants from you

Least privilege for the identities that run Terraform: OIDC instead of static keys, separate
**plan (read-only)** and **apply (write)** roles, trust scoped to repo/branch/workspace, secrets injected
as masked env vars, and protected branches/environments for apply.

## 🧪 Lab

1. Read `iam.tf` — it creates **two** roles for GitHub Actions:
   - `tf-plan` → assumable from **any PR** in the repo, read-only + state bucket read + lock write.
   - `tf-apply` → assumable **only** from `refs/heads/main` in the `production` environment.
2. Apply it (needs the OIDC provider from [4c](../../04-cicd-automation/4c-dynamic-credentials)).
3. In the 4a workflow, use `AWS_PLAN_ROLE_ARN` for the plan job and `AWS_APPLY_ROLE_ARN` for the apply job.
4. Try to assume the apply role from a PR branch → it must fail.

Checklist to review any pipeline:
- [ ] No `AWS_ACCESS_KEY_ID` stored as a long-lived secret
- [ ] Plan and apply use different identities
- [ ] Trust policy pins repo **and** branch/environment
- [ ] State bucket: encryption, versioning, no public access, limited readers
- [ ] Secrets passed as `TF_VAR_*` from the CI secret store, never echoed

## ⚠️ Exam traps

- In HCP Terraform you can set `TFC_AWS_PLAN_ROLE_ARN` and `TFC_AWS_APPLY_ROLE_ARN` separately.
- Anyone who can read **state** can read every secret in it → state access is a privileged permission.
- A `sub` condition like `repo:org/*` lets **any** repo in the org assume the role.
- Team/user API tokens in CI should be replaced by **team** tokens or dynamic credentials with the smallest scope.

## ✅ Self-check

**Q1. Why separate plan and apply roles?**

<details><summary>Answer</summary>

Plans run on untrusted PR code; giving them write access would let any PR change infrastructure.

</details>

**Q2. Which GitHub OIDC `sub` value limits a role to the production environment?**

<details><summary>Answer</summary>

`repo:OWNER/REPO:environment:production`

</details>


---
[⬅ Back to the roadmap](../../README.md)
