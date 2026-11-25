# Terraform Infrastructure Engineer Professional (002): Practice Labs

Hands-on practice for the **HashiCorp Certified: Terraform Infrastructure Engineer Professional (002)** exam
(Terraform **1.15**, 90 minutes, multiple choice and multiple answer).

Every exam objective has its own folder. Each folder contains:

- 📚 **Official docs**: the links HashiCorp lists for that objective in the [Exam Content List](https://developer.hashicorp.com/terraform/tutorials/certification-infra-professional/cert-pro-review)
- 🎯 **What the exam wants**: a short summary of what the objective tests
- 🧪 **Lab**: a small runnable project with step-by-step tasks
- ⚠️ **Exam traps**: the details that wrong answers are built on
- ✅ **Self-check**: questions with hidden answers

> **How to use it (بالعربي):** امشي على الـ objectives بالترتيب. في كل فولدر اقرا الـ docs الأول، وبعدين اعمل الـ lab بإيدك.
> قبل ما تشغّل أي أمر، اكتب توقعك للنتيجة وقارنه باللي حصل. وجاوب على الـ Self-check من غير ما تفتح الإجابة.
> علّم ✅ قدام كل objective تخلصه في الجدول اللي تحت.

## Lab cost legend

| Badge | Meaning |
|---|---|
| 🟢 | Runs locally for free (`random`, `local`, `time`, `terraform_data`) |
| 🟡 | AWS config: `init` + `validate` work without credentials |
| 🟠 | Creates real AWS resources. Use the free tier and run `terraform destroy` when you finish |
| 🔵 | Needs a free HCP Terraform account |
| 📖 | Reading and config only |

## Setup

```bash
# Terraform 1.15 (or use tfenv / tfswitch)
terraform version

# Tools used by the labs
jq --version
aws --version          # for AWS labs
terraform login        # for HCP Terraform labs (section 7)
```

## Study plan and progress

| Week | Objective | Lab | Cost | Done |
|---|---|---|---|---|
| 1 | 1a Translate business requirements into code | [01/1a](01-configuration-design/1a-business-requirements) | 🟢 | ⬜ |
| 1 | 1b Predictable and secure configuration | [01/1b](01-configuration-design/1b-predictable-secure-config) | 🟢 | ⬜ |
| 1 | 1c Trace variables, locals, outputs | [01/1c](01-configuration-design/1c-trace-variables-locals-outputs) | 🟢 | ⬜ |
| 1 | 1d Trace for_each resources | [01/1d](01-configuration-design/1d-for-each-tracing) | 🟢 | ⬜ |
| 1 | 1e Predict function results | [01/1e](01-configuration-design/1e-functions) | 🟢 | ⬜ |
| 2 | 1f Advanced configurations | [01/1f](01-configuration-design/1f-advanced-config) | 🟢🟡 | ⬜ |
| 2 | 1g Configure providers | [01/1g](01-configuration-design/1g-providers) | 🟡 | ⬜ |
| 2 | 1h Terraform MCP server | [01/1h](01-configuration-design/1h-mcp-server) | 📖 | ⬜ |
| 3 | 2a Remote backend & remote state | [02/2a](02-state-backend/2a-remote-backend) | 🟢🟠 | ⬜ |
| 3 | 2b State drift | [02/2b](02-state-backend/2b-drift) | 🟢 | ⬜ |
| 3 | 2c Dependency chains before upgrades | [02/2c](02-state-backend/2c-dependency-chains) | 🟢 | ⬜ |
| 3 | 2d Upgrade Terraform versions | [02/2d](02-state-backend/2d-upgrade-versions) | 🟢 | ⬜ |
| 3 | 2e Inspect state | [02/2e](02-state-backend/2e-inspect-state) | 🟢 | ⬜ |
| 4 | 3a Manage and scale projects | [03/3a](03-lifecycle-operations/3a-manage-scale-projects) | 🟢 | ⬜ |
| 4 | 3b Plan changes | [03/3b](03-lifecycle-operations/3b-plan-changes) | 🟢 | ⬜ |
| 4 | 3c Apply changes, locking | [03/3c](03-lifecycle-operations/3c-apply-changes) | 🟢 | ⬜ |
| 4 | 3d Import existing infrastructure | [03/3d](03-lifecycle-operations/3d-import) | 🟠 | ⬜ |
| 4 | 3e Lifecycle: moved / removed / replace | [03/3e](03-lifecycle-operations/3e-manage-lifecycle) | 🟢 | ⬜ |
| 4 | 3f Multiple environments | [03/3f](03-lifecycle-operations/3f-multiple-environments) | 🟢 | ⬜ |
| 4 | 3g Troubleshooting | [03/3g](03-lifecycle-operations/3g-troubleshooting) | 🟢 | ⬜ |
| 4 | 3h Input and output data | [03/3h](03-lifecycle-operations/3h-input-output-data) | 🟢 | ⬜ |
| 4 | 3i Provider & module versions | [03/3i](03-lifecycle-operations/3i-provider-module-versions) | 🟡 | ⬜ |
| 5 | 4a CI/CD pipeline | [04/4a](04-cicd-automation/4a-cicd-pipeline) | 📖🟠 | ⬜ |
| 5 | 4b Deployment strategies & automation env vars | [04/4b](04-cicd-automation/4b-deployment-strategies) | 🟢 | ⬜ |
| 5 | 4c Dynamic provider credentials (OIDC) | [04/4c](04-cicd-automation/4c-dynamic-credentials) | 🟠🔵 | ⬜ |
| 5 | 4d Variable precedence (.tfvars / auto.tfvars) | [04/4d](04-cicd-automation/4d-tfvars-precedence) | 🟢 | ⬜ |
| 5 | 5a Secrets best practices (ephemeral, write-only) | [05/5a](05-security-governance/5a-secrets-best-practices) | 🟢🟡 | ⬜ |
| 5 | 5b Secret rotation & secret managers | [05/5b](05-security-governance/5b-secret-rotation) | 🟢 | ⬜ |
| 5 | 5c Secure pipeline identities | [05/5c](05-security-governance/5c-secure-pipeline-identities) | 🟠 | ⬜ |
| 5 | 5d Compliance policies (Sentinel / OPA) | [05/5d](05-security-governance/5d-policy-compliance) | 🔵 | ⬜ |
| 5 | 5e Risky changes | [05/5e](05-security-governance/5e-risky-changes) | 🟢 | ⬜ |
| 6 | 6a Refactor into a module | [06/6a](06-modules-registry/6a-refactor-into-module) | 🟢 | ⬜ |
| 6 | 6b Module contract | [06/6b](06-modules-registry/6b-module-contract) | 🟢 | ⬜ |
| 6 | 6c Registry (public & private) | [06/6c](06-modules-registry/6c-registry) | 🟡 | ⬜ |
| 6 | 6d `terraform test` & mocks | [06/6d](06-modules-registry/6d-terraform-test) | 🟢 | ⬜ |
| 7 | 7a Operate HCP Terraform (VCS / CLI / API runs) | [07/7a](07-hcp-terraform/7a-operate-hcp-terraform) | 🔵 | ⬜ |
| 7 | 7b Usage & cost estimation | [07/7b](07-hcp-terraform/7b-usage-and-cost) | 🔵 | ⬜ |
| 7 | 7c Multi-environment (projects, variable sets) | [07/7c](07-hcp-terraform/7c-multi-environment) | 🔵 | ⬜ |
| 7 | 7d Upgrade versions across workspaces | [07/7d](07-hcp-terraform/7d-upgrade-versions-workspaces) | 🔵 | ⬜ |
| 7 | 7e Policy as code in CI/CD | [07/7e](07-hcp-terraform/7e-policy-as-code-pipeline) | 🔵 | ⬜ |
| 8 | Review + timed practice exams | [Sample questions](https://developer.hashicorp.com/terraform/tutorials/certification-infra-professional/cert-pro-questions) | | ⬜ |

## Official resources

- [Exam page](https://developer.hashicorp.com/certifications/infrastructure-automation)
- [Learning path](https://developer.hashicorp.com/terraform/tutorials/certification-infra-professional/cert-pro-study)
- [Exam content list](https://developer.hashicorp.com/terraform/tutorials/certification-infra-professional/cert-pro-review)
- [Sample questions](https://developer.hashicorp.com/terraform/tutorials/certification-infra-professional/cert-pro-questions)

## Rules for yourself

1. **Predict first, run second.** The exam gives you code with no terminal, so train that skill.
2. **Break things on purpose.** Find out why each wrong answer is wrong.
3. **Always `terraform destroy`** AWS labs when you finish.
4. **Never commit secrets** or state files. `.gitignore` already blocks state files, `.terraform/`, plan files and generated output. The `.tfvars` files here are lab fixtures with no secrets. Keep yours that way.
