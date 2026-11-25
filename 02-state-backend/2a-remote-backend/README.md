# 2a — Create and manage remote backend and remote state configuration

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Initialize the Working Directory](https://developer.hashicorp.com/terraform/cli/init)
- [Backend: local](https://developer.hashicorp.com/terraform/language/backend/local)
- [Backend: remote](https://developer.hashicorp.com/terraform/language/backend/remote)
- [Backend: S3](https://developer.hashicorp.com/terraform/language/backend/s3)
- [Backend: gcs](https://developer.hashicorp.com/terraform/language/backend/gcs)
- [terraform block reference](https://developer.hashicorp.com/terraform/language/block/terraform)
- [The terraform_remote_state Data Source](https://developer.hashicorp.com/terraform/language/state/remote-state-data)
- [Backend block configuration overview](https://developer.hashicorp.com/terraform/language/backend)
- [Tutorial: Migrate state from S3 to HCP Terraform](https://developer.hashicorp.com/terraform/tutorials/cloud/migrate-remote-s3-backend-hcp-terraform)

## 🎯 What the exam wants from you

Configure an S3 backend with **native locking** (`use_lockfile = true`, Terraform ≥ 1.10), use
partial configuration so the same code works for every environment, migrate state between backends,
and share outputs between projects with `terraform_remote_state`.

## 🧪 Lab

**Part A — share state between two projects (free, local backend):**
```bash
cd producer && terraform init && terraform apply -auto-approve && cd ..
cd consumer && terraform init && terraform apply -auto-approve
terraform output        # values read from producer's state file
```
Then change an output in `producer`, apply, and re-apply `consumer` to see it update.

**Part B — S3 backend + migration (AWS):**
```bash
cd s3-bootstrap && terraform init && terraform apply   # creates the state bucket
cd ../s3-app
# 1. start with the backend block commented out -> local state
terraform init && terraform apply -auto-approve
# 2. uncomment the backend "s3" block, then:
terraform init -backend-config=backend-dev.hcl -migrate-state
# 3. confirm the state is now in S3
aws s3 ls s3://<your-bucket>/ --recursive
```

**Part C — migrate to HCP Terraform:** replace the backend with the `cloud` block in `s3-app/cloud.tf.example`
and run `terraform init` → Terraform offers to copy the state.

## ⚠️ Exam traps

- `use_lockfile = true` → S3 native locking (`.tflock` object). `dynamodb_table` is the **old, deprecated** way.
- Backend blocks **can't use variables or locals**. Use partial config: `-backend-config=file.hcl` or `-backend-config="key=value"`.
- After changing a backend: `init -migrate-state` (copy state) vs `init -reconfigure` (ignore the old backend, don't copy).
- `terraform_remote_state` exposes only the **root-module outputs** of the other state, and it needs read access to the whole state file → prefer data sources or HCP Terraform's output sharing when you can.

## ✅ Self-check

**Q1. Two engineers run `apply` at the same time against an S3 backend with `use_lockfile = true`. Result?**

<details><summary>Answer</summary>

The second run fails with `Error acquiring the state lock` (unless it uses `-lock-timeout`).

</details>

**Q2. You want one codebase for dev and prod with different state keys. Backend blocks don't accept variables — how?**

<details><summary>Answer</summary>

Partial configuration: keep `backend "s3" {}` and pass `-backend-config=backend-dev.hcl` / `backend-prod.hcl` at `init`.

</details>


---
[⬅ Back to the roadmap](../../README.md)
