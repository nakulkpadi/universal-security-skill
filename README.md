<div align="center">

# Universal Security Skill

### Stack-aware application security auditing for VS Code, GitHub Copilot, coding agents, web apps, APIs, SaaS, AI apps, and website builders

**Engineered by Nakul.Kapdi**

[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](VERSION)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Security Policy](https://img.shields.io/badge/security-policy-brightgreen.svg)](SECURITY.md)
[![Agent Skill](https://img.shields.io/badge/Agent%20Skill-universal--security-purple.svg)](.github/skills/universal-security/SKILL.md)

**Discover → Threat model → Review → Scan → Prioritize → Fix → Verify → Report**

</div>

## What is Universal Security Skill?

Universal Security Skill is an open-source, reusable **application security Agent Skill** designed for developers using **VS Code, GitHub Copilot and compatible coding-agent workflows**. It helps an agent inspect a project, identify the real technology stack, focus on relevant security risks, recommend minimal fixes, verify changes, and produce an evidence-based security report.

It is built for modern projects including **Next.js, React, Node.js, Express, Python, Django, FastAPI, Flask, PHP, Laravel, Supabase, Firebase, SaaS applications, REST/GraphQL APIs, payment integrations, file-upload systems, CI/CD pipelines, cloud deployments, and AI/LLM applications**.

This project is a defensive engineering aid. It is **not a penetration-testing authorization, compliance certification, or guarantee that a project is vulnerability-free**.

## Why developers use it

Many security prompt lists apply the same advice to every project, treat guesses as findings, or declare a vulnerability fixed as soon as code changes. Universal Security Skill uses a stricter model:

- **Stack-aware:** detect what the project actually uses before choosing checks.
- **Evidence-first:** label conclusions as `Observed`, `Inferred`, or `Not verified`.
- **Authorization-focused:** prioritize broken access control, tenant isolation and privilege boundaries.
- **Safe remediation:** make minimal changes and avoid unrelated rewrites.
- **Verification-required:** never call a finding `Fixed` without re-testing or equivalent evidence.
- **Privacy-conscious:** redact secrets and personal data from reports.
- **Tool-friendly:** works alongside Gitleaks, Semgrep, OSV-Scanner, Trivy and project-native audit tools when already installed or approved.
- **AI-aware:** includes prompt injection, tool authorization, untrusted retrieval/output, data leakage and spend-abuse checks when LLM features exist.

## Quick start

### 1. Add the skill to your repository

Copy this folder into your project:

```text
.github/skills/universal-security/
```

The important entry point is:

```text
.github/skills/universal-security/SKILL.md
```

### 2. Open the project in VS Code

Use GitHub Copilot Agent mode or another environment that supports Agent Skills. Ask the agent to perform a security review using the installed skill.

### 3. Start with one of these prompts

```text
Run a full security review of this project before deployment.
Detect the stack first. Do not edit files until you show me Critical and High findings.
```

```text
Review my current git changes for security regressions. Fix only confirmed Critical/High issues, add regression tests, and verify every fix.
```

```text
Audit authentication, authorization and tenant isolation only. Do not modify files. Create SECURITY_REPORT.md.
```

```text
Security-review this Supabase project. Focus on RLS, service-role exposure, storage policies, auth, API authorization and cross-user access.
```

## Security coverage

| Area | Examples of checks |
| --- | --- |
| Secrets & configuration | hardcoded credentials, browser-exposed server secrets, `.env`, logs, leaked history, key rotation guidance |
| Authentication | login, signup, reset, MFA, OAuth/OIDC, session expiry, cookie/JWT handling, enumeration, brute-force controls |
| Authorization | BOLA/IDOR, tenant isolation, role checks, ownership checks, admin boundaries, server-side enforcement |
| Data & privacy | collection, storage, logs, analytics, third-party sharing, minimization, retention/deletion, AI traces |
| Browser security | XSS, CSP, unsafe HTML, CSRF applicability, CORS, redirects, security headers |
| Injection & server-side input | SQL/NoSQL injection, command execution, SSRF, path traversal, unsafe parsing/deserialization |
| API abuse | rate limits, quotas, resource exhaustion, pagination, mass signup/spam, endpoint exposure |
| Files & media | content/type validation, size/resource limits, path safety, authorization, active content isolation |
| Payments & webhooks | server-authoritative totals, signatures, replay/idempotency, entitlements, concurrency/business logic |
| Dependencies & supply chain | lockfiles, vulnerable packages, secret scanning, SAST, CI permissions, untrusted PR workflows |
| Infrastructure | Docker/IaC, production debug exposure, database/network boundaries, TLS, backups, logging |
| AI/LLM security | direct/indirect prompt injection, tool permissions, data leakage, unsafe outputs, cost/spend abuse |

## Repository structure

```text
.
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/
│   ├── pull_request_template.md
│   └── skills/
│       └── universal-security/
│           ├── SKILL.md
│           ├── examples/
│           ├── references/
│           ├── scripts/
│           └── templates/
├── docs/
├── examples/
├── tests/
├── AUTHORS.md
├── CHANGELOG.md
├── CITATION.cff
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE
├── NOTICE.md
├── README.md
├── SECURITY.md
├── SUPPORT.md
└── VERSION
```

## Optional local helper scripts

Detect likely project technologies:

```bash
.github/skills/universal-security/scripts/detect-stack.sh .
```

Run a conservative local baseline using only scanners already available on the machine:

```bash
.github/skills/universal-security/scripts/security-check.sh .
```

The helper does **not** automatically install scanners, upload source code, or attack remote systems. Missing tools are reported as skipped.

## Supported scanner integrations

The skill can reason about results from tools such as:

- Gitleaks — secret scanning
- Semgrep / CodeQL — static analysis
- OSV-Scanner — vulnerable dependency discovery
- Trivy — filesystem, container, dependency and IaC scanning
- npm / pnpm / yarn audit — JavaScript dependency checks
- OWASP ZAP — authorized dynamic application testing

These projects are not bundled. Review and install third-party tools according to your organization’s security policy and the tool’s own documentation/license.

## Findings and severity

A finding should include **severity and confidence separately**. Scanner severity alone is not enough.

```text
SEC-001
Severity: High
Confidence: High
Status: Open

Finding:
Invoice lookup is not scoped to the authenticated tenant.

Evidence:
src/api/invoices/[id].ts:42

Impact:
A valid user may be able to access another tenant's invoice.

Fix:
Scope the lookup using the authenticated tenant ID and central authorization policy.

Verification:
Cross-tenant integration test must return 403/404.
```

Default severity levels are `Critical`, `High`, `Medium`, `Low`, and `Informational`. Full criteria are in [`severity-model.md`](.github/skills/universal-security/references/severity-model.md).

## What makes a fix verified?

The skill uses this sequence:

1. Establish evidence for the vulnerable path.
2. Apply the smallest appropriate fix.
3. Add or update a focused regression test when practical.
4. Re-run the relevant test/scanner/static check.
5. Inspect the diff for bypasses or sensitive-data exposure.
6. Mark the issue `Fixed` only when evidence supports it.

If runtime access, test accounts, secrets or tooling are missing, the result remains `Not verified`.

## Use with website builders and AI app builders

The skill can also help review source code exported from or maintained alongside AI website/app builders. The same rule applies: it can only verify what it can inspect and test. A prompt-only review of an inaccessible production system is not equivalent to a security test.

## Safety and authorization

This repository is for **defensive security work**. Active testing must stay within the current repository, a local environment, or a system the user owns or has explicit authorization to test. Do not use the skill to bypass access controls on third-party systems, steal data, create destructive traffic, or hide malicious activity.

## Standards and learning resources

The design is informed by widely used defensive references such as OWASP ASVS, OWASP API Security Top 10 and OWASP Cheat Sheet Series, plus established open-source security tooling. See [`NOTICE.md`](NOTICE.md) and [`standards.md`](.github/skills/universal-security/references/standards.md).

## Testing this repository

Run:

```bash
bash tests/test-scripts.sh
```

The test suite validates shell syntax, basic stack detection, conservative execution without optional scanners, and required repository files. See [`TESTING.md`](TESTING.md) for the exact scope and limitations.

## GitHub repository topics

Recommended topics for discoverability:

`application-security`, `web-security`, `cybersecurity`, `secure-coding`, `devsecops`, `owasp`, `vscode`, `github-copilot`, `agent-skills`, `ai-security`, `security-audit`, `sast`, `api-security`, `supabase-security`

Suggested GitHub description:

> Stack-aware security Agent Skill for VS Code, GitHub Copilot and coding agents. Audit, fix, verify and document web, API, SaaS and AI application security issues.

## Roadmap

- More framework-specific review profiles
- Test fixtures for IDOR, XSS, SSRF, insecure webhook and RLS mistakes
- JSON/SARIF-compatible finding export
- More deterministic checks for changed-files security review
- Additional CI examples
- Community-contributed framework modules with regression fixtures

## Contributing

Contributions are welcome. Start with [`CONTRIBUTING.md`](CONTRIBUTING.md). Security checks should document applicability, evidence, impact, remediation, verification and common false positives.

Please follow [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md). Report vulnerabilities privately according to [`SECURITY.md`](SECURITY.md).

## Credits

**Engineered by Nakul.Kapdi.**

The project is original work built with respect for established security standards and open-source projects. Upstream references and inspiration are documented in [`NOTICE.md`](NOTICE.md).

## License

Released under the [MIT License](LICENSE).

---

If this project helps you, consider starring the repository and sharing feedback through GitHub Discussions or Issues. Security improves when checks are reproducible, reviewable and continuously tested.
