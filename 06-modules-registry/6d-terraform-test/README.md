# 6d — Validate modules with Terraform unit tests

🟢 **Runs locally for free** — only uses the `random`, `local`, `null`, `time` providers or built-ins.

## 📚 Official docs

- [terraform test command](https://developer.hashicorp.com/terraform/cli/commands/test)
- [Test Files](https://developer.hashicorp.com/terraform/language/files/tests)
- [Validate your configuration](https://developer.hashicorp.com/terraform/language/validate)
- [Tests](https://developer.hashicorp.com/terraform/language/tests)
- [Mocks](https://developer.hashicorp.com/terraform/language/tests/mocking)
- [check block reference](https://developer.hashicorp.com/terraform/language/block/check)
- [resource block reference](https://developer.hashicorp.com/terraform/language/block/resource)
- [Tutorial: Write Terraform Tests](https://developer.hashicorp.com/terraform/tutorials/configuration-language/test)

## 🎯 What the exam wants from you

Write `.tftest.hcl` files: `run` blocks with `command = plan` (unit, fast, no infra) or `apply`
(integration, creates then destroys), `assert`, `expect_failures` for validation tests, file-level
`variables`, and **mocks** (`mock_provider`, `override_resource`, `override_data`) to test without credentials.

## 🧪 Lab

```bash
terraform init
terraform test                              # runs every file in tests/
terraform test -filter=tests/unit.tftest.hcl
terraform test -verbose                     # print plan/state for each run
```
Exercises:
1. Make a test fail on purpose (change an expected value) and read the output.
2. Add a run block that checks `name = "Bad Name"` fails validation (`expect_failures`).
3. `tests/mocked.tftest.hcl` uses `mock_provider "aws"` — runs **without** AWS credentials. Add an assertion on the mocked ARN.

## ⚠️ Exam traps

- Default `command` is **`apply`** — real resources are created and destroyed at the end of the test file.
- `expect_failures` lists checkable objects (variables, outputs, resources, check blocks) whose conditions are expected to fail.
- A later `run` block can reference an earlier one's outputs: `run.setup.bucket_name`.
- Tests live in `*.tftest.hcl` (root or `tests/` directory by default); `.tftest.json` also works.
- Mocks need Terraform ≥ 1.7. A `mock_provider` generates fake values for computed attributes.

## ✅ Self-check

**Q1. Which `command` value tests logic without creating infrastructure?**

<details><summary>Answer</summary>

`command = plan`

</details>

**Q2. How do you assert that an invalid variable is rejected?**

<details><summary>Answer</summary>

`expect_failures = [var.name]` in the run block.

</details>


---
[⬅ Back to the roadmap](../../README.md)
