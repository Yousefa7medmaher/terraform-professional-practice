# 1h — Use the Terraform MCP server with AI coding agents

📖 **Reading + config only** — no infrastructure is created.

## 📚 Official docs

- [Terraform MCP server overview](https://developer.hashicorp.com/terraform/mcp-server)
- [Prompt a model connected to the Terraform MCP server](https://developer.hashicorp.com/terraform/mcp-server/prompt)
- [Terraform MCP server reference](https://developer.hashicorp.com/terraform/mcp-server/reference)
- [Tutorial: Integrate your private module registry with the Terraform MCP server](https://developer.hashicorp.com/terraform/tutorials/cloud/mcp)

## 🎯 What the exam wants from you

The Terraform MCP server gives an AI agent **live** access to the Terraform Registry (provider docs,
modules, policies) and, with a token, to your HCP Terraform private registry and workspaces. The exam
asks *why* you'd use it (current docs instead of the model's stale training data) and *how* to configure it.

## 🧪 Lab

1. Install Docker, then add the server to your agent. Example configs are in this folder:
   - [`claude-code.mcp.json`](claude-code.mcp.json) → save as `.mcp.json` in a project for Claude Code
   - [`vscode.mcp.json`](vscode.mcp.json) → save as `.vscode/mcp.json` for VS Code / Copilot
2. Ask the agent things that need **current** docs:
   - "Using the Terraform MCP server, what are the arguments of the latest `aws_s3_bucket_lifecycle_configuration`?"
   - "Find the most downloaded registry module for an AWS VPC and write a config that pins its latest version."
   - "Write a Sentinel policy that restricts EC2 instance types — look up an existing policy library first."
3. **Private registry (optional):** create an HCP Terraform token, set `TFE_TOKEN` in the config, and ask
   "list modules in my private registry". Follow the tutorial linked above.
4. Read the **reference** page and list which tools the server exposes (search providers, get provider docs, search modules, …).

## ⚠️ Exam traps

- To give an agent the **most current** provider docs → connect it to the Terraform MCP server (default config is enough for the public registry). Upgrading provider versions or adding changelog links does **not** change what the model knows.
- Private registry / workspace tools need a **token** (`TFE_TOKEN`) and the right address (`TFE_ADDRESS` for Terraform Enterprise).
- Treat a token given to the MCP server like any secret — environment variable, not committed.

## ✅ Self-check

**Q1. An AI assistant keeps generating deprecated arguments. What's the fix the exam expects?**

<details><summary>Answer</summary>

Run the Terraform MCP server and connect the assistant to it so it reads current registry docs.

</details>

**Q2. What extra configuration does the server need to read your private modules?**

<details><summary>Answer</summary>

An HCP Terraform/Terraform Enterprise API token (`TFE_TOKEN`), plus `TFE_ADDRESS` for Enterprise.

</details>


---
[⬅ Back to the roadmap](../../README.md)
