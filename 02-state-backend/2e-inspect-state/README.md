# 2e — Inspect Terraform state

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [terraform state list command](https://developer.hashicorp.com/terraform/cli/commands/state/list)
- [Resource Address Reference](https://developer.hashicorp.com/terraform/cli/state/resource-addressing)
- [Query infrastructure data](https://developer.hashicorp.com/terraform/language/data-sources)
- [terraform state show command](https://developer.hashicorp.com/terraform/cli/commands/state/show)
- [terraform show command](https://developer.hashicorp.com/terraform/cli/commands/show)
- [JSON Output Format Overview](https://developer.hashicorp.com/terraform/internals/json-format)
- [count reference](https://developer.hashicorp.com/terraform/language/meta-arguments/count)
- [Tutorial: Manage resources in Terraform state](https://developer.hashicorp.com/terraform/tutorials/state/state-cli)

## 🎯 What the exam wants from you

Read state with the right command and address syntax: `state list` (with filters), `state show`,
`show` / `show -json`, `output -json`, and know the resource address grammar for modules, `count` and `for_each`.

## 🧪 Lab

```bash
terraform init && terraform apply -auto-approve
terraform state list
terraform state list module.app                       # filter by module
terraform state list -id=<some id>                    # find by ID
terraform state show 'random_pet.count_pet[1]'
terraform state show 'module.app.random_string.key["api"]'
terraform show                                        # human readable
terraform show -json | jq '.values.root_module.resources[].address'
terraform plan -out=tfplan && terraform show -json tfplan | jq '.resource_changes[] | {address, actions: .change.actions}'
terraform output -json
```

**Address grammar** (write each one before checking):
- 2nd item of a `count` resource
- `for_each` key `"api"` inside module `app`
- a resource inside module `app` that itself is created with `for_each` key `"eu"`

## ⚠️ Exam traps

- Address syntax: `module.<name>[<key>].<type>.<name>[<index or "key">]`.
- `state show` needs **one** instance address; `state list` accepts a prefix.
- `terraform show -json` on a **plan file** gives `resource_changes` (great for scripts/policy); on state it gives `values`.
- Never edit `terraform.tfstate` by hand — use `state mv/rm`, `moved`, `removed`, `import`.

## ✅ Self-check

**Q1. What's the address of key `"web"` of `aws_instance.app` inside `module.region["eu"]`?**

<details><summary>Answer</summary>

`module.region["eu"].aws_instance.app["web"]`

</details>

**Q2. Which command gives machine-readable details of planned actions for a CI script?**

<details><summary>Answer</summary>

`terraform show -json tfplan` (look at `.resource_changes[].change.actions`).

</details>


---
[⬅ Back to the roadmap](../../README.md)
