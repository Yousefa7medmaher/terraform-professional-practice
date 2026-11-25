# Function drills — predict first, then check in `terraform console`

Cover the answers (scroll only after writing yours).

| # | Expression |
|---|---|
| 1 | `merge(var.tags, var.extra_tags)` |
| 2 | `merge(var.extra_tags, var.tags)["Environment"]` |
| 3 | `lookup(var.tags, "Owner", "unknown")` |
| 4 | `distinct(var.ports)` |
| 5 | `toset(var.ports)` |
| 6 | `length(var.ports)` |
| 7 | `[for n in var.names : lower(trimspace(n)) if n != ""]` |
| 8 | `flatten(var.nested)` |
| 9 | `element(var.ports, 5)` |
| 10 | `join("-", ["a", "b", "c"])` |
| 11 | `split(",", "a,b,,c")` |
| 12 | `coalesce("", null, "x")` |
| 13 | `coalescelist([], ["y"])` |
| 14 | `zipmap(["a", "b"], [1, 2])` |
| 15 | `cidrsubnet("10.0.0.0/16", 8, 10)` |
| 16 | `cidrhost("10.0.1.0/24", 5)` |
| 17 | `try(var.config.cache.port, 6379)` |
| 18 | `can(regex("^ami-", "ami-1234"))` |
| 19 | `format("%s-%03d", "web", 7)` |
| 20 | `{ for k, v in var.tags : lower(k) => upper(v) }` |
| 21 | `keys(var.extra_tags)` |
| 22 | `max(var.ports...)` |
| 23 | `slice(["a", "b", "c", "d"], 1, 3)` |
| 24 | `one([for p in var.ports : p if p > 8000])` |
| 25 | `jsonencode({ b = 1, a = [true] })` |

<details><summary>Answers</summary>

1. `{ Department = "Platform", Environment = "Production", Owner = "yousef" }`
2. `"Development"` (the last map wins)
3. `"unknown"`
4. `[80, 443, 8080]`
5. `toset([80, 443, 8080])` (a set, shown sorted)
6. `4`
7. `["web", "api", "db"]`
8. `["a", "b", "c"]`
9. `443` (index 5 mod 4 = 1)
10. `"a-b-c"`
11. `["a", "b", "", "c"]`
12. `"x"`
13. `["y"]`
14. `{ a = 1, b = 2 }`
15. `"10.0.10.0/24"`
16. `"10.0.1.5"`
17. `6379`
18. `true`
19. `"web-007"`
20. `{ department = "PLATFORM", environment = "DEVELOPMENT" }`
21. `["Environment", "Owner"]` (sorted)
22. `8080` (the `...` expands the list into arguments)
23. `["b", "c"]` (end index is exclusive)
24. `8080`
25. `"{\"a\":[true],\"b\":1}"` (keys sorted)

</details>
