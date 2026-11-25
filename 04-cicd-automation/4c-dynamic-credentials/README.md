# 4c — Manage multiple sets of dynamic provider credentials

🟠 **Needs an AWS account** — creates real resources. Always `terraform destroy` when you finish.

## 📚 Official docs

- [Dynamic provider credentials](https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials)
- [Workload identity](https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials/workload-identity-tokens)
- [GitHub: Configuring OpenID Connect in cloud providers](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-cloud-providers)
- [GitHub: OpenID Connect](https://docs.github.com/en/actions/concepts/security/openid-connect)
- [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Tutorial: Authenticate providers with dynamic credentials](https://developer.hashicorp.com/terraform/tutorials/cloud/dynamic-credentials)

## 🎯 What the exam wants from you

Replace long-lived access keys with **OIDC**: the CI system (GitHub Actions or HCP Terraform) gets a short-lived
signed token, the cloud trusts that issuer, and the token is exchanged for temporary credentials.
You must know the trust conditions (`aud`, `sub`) and how HCP Terraform handles **multiple** credential sets
(several accounts/aliases in one workspace).

## 🧪 Lab

`aws/` creates two OIDC trust setups (apply it with an admin profile once):
```bash
cd aws
terraform init
terraform apply -var='github_repo=Yousefa7medmaher/terraform-professional-practice' -var='hcp_org=YOUR_ORG'
```
1. **GitHub Actions** → use the output role ARN as `AWS_PLAN_ROLE_ARN` secret in the [4a](../4a-cicd-pipeline) workflow.
2. **HCP Terraform** → in the workspace (or better, a variable set) add **environment variables**:

| Variable | Value |
|---|---|
| `TFC_AWS_PROVIDER_AUTH` | `true` |
| `TFC_AWS_RUN_ROLE_ARN` | output `hcp_role_arn` |

3. **Multiple sets** (e.g. a second account for DNS): read `hcp-multiple-creds.tf.example` — it uses the
   `tfc_aws_dynamic_credentials` variable with provider aliases, and tagged env vars like
   `TFC_AWS_PROVIDER_AUTH_dns` / `TFC_AWS_RUN_ROLE_ARN_dns`.

## ⚠️ Exam traps

- HCP Terraform's audience for AWS is `aws.workload.identity`; GitHub's is `sts.amazonaws.com`.
- **Scope the `sub` claim**: `organization:ORG:project:PROJ:workspace:WS:run_phase:*` (HCP) or `repo:OWNER/REPO:ref:refs/heads/main` (GitHub). A wildcard on the whole org is a security finding.
- You can use different roles for plan and apply: `TFC_AWS_PLAN_ROLE_ARN` / `TFC_AWS_APPLY_ROLE_ARN`.
- Share credentials across many workspaces with a **variable set** applied to a project.

## ✅ Self-check

**Q1. Which env vars turn on AWS dynamic credentials in an HCP Terraform workspace?**

<details><summary>Answer</summary>

`TFC_AWS_PROVIDER_AUTH=true` and `TFC_AWS_RUN_ROLE_ARN=<role arn>`.

</details>

**Q2. How do you restrict a role so only the `main` branch of one repo can assume it from GitHub Actions?**

<details><summary>Answer</summary>

Trust-policy condition on `token.actions.githubusercontent.com:sub` = `repo:OWNER/REPO:ref:refs/heads/main` (and `aud` = `sts.amazonaws.com`).

</details>


---
[⬅ Back to the roadmap](../../README.md)
