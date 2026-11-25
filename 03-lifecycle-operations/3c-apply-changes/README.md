# 3c — Apply changes to infrastructure

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [Use provisioners to perform post-apply operations](https://developer.hashicorp.com/terraform/language/provisioners)
- [terraform force-unlock command](https://developer.hashicorp.com/terraform/cli/commands/force-unlock)
- [State Locking](https://developer.hashicorp.com/terraform/language/state/locking)
- [terraform apply command](https://developer.hashicorp.com/terraform/cli/commands/apply)
- [Purpose of Terraform State](https://developer.hashicorp.com/terraform/language/state/purpose)
- [Tutorial: Apply Terraform configuration](https://developer.hashicorp.com/terraform/tutorials/cli/apply)

## 🎯 What the exam wants from you

Apply a **saved plan** (what CI does), understand state locking and when `force-unlock` is safe,
`-parallelism`, `-lock-timeout`, and why provisioners are a last resort.

## 🧪 Lab

```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan            # no prompt, applies exactly what was reviewed
```
**Locking:** open two terminals.
```bash
# terminal 1
terraform apply                   # leave it waiting at the "yes" prompt (lock is held)
# terminal 2
terraform apply                   # -> Error acquiring the state lock (shows Lock ID)
terraform apply -lock-timeout=60s # waits up to 60s instead of failing
```
Kill terminal 1 with `kill -9` to simulate a crashed CI job, then:
```bash
terraform force-unlock <LOCK_ID>   # only when you're SURE no other run is active
```
**Provisioners:** `terraform_data.notify` uses `local-exec`. Apply and see the output, then read why HashiCorp calls provisioners a last resort.

## ⚠️ Exam traps

- `apply tfplan` → no approval prompt and **no new plan**. If state changed since the plan, the saved plan is **stale** and apply fails.
- `force-unlock` needs the **lock ID**, and it only removes the lock — it doesn't stop a running process.
- `-parallelism=n` default is **10**.
- Provisioner failure → resource is marked **tainted** (for creation-time provisioners). `when = destroy` provisioners run on destroy.
- Prefer `user_data`/cloud-init, images (Packer) or config management over provisioners.

## ✅ Self-check

**Q1. A CI job crashed and left the state locked. What do you do?**

<details><summary>Answer</summary>

Confirm no run is still active, then `terraform force-unlock LOCK_ID`.

</details>

**Q2. What happens if a creation-time provisioner fails?**

<details><summary>Answer</summary>

The apply errors and the resource is marked tainted, so it will be replaced next apply.

</details>


---
[⬅ Back to the roadmap](../../README.md)
