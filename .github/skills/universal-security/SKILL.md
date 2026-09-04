---
name: universal-security
description: Stack-aware defensive security review and secure-update workflow for web applications, APIs, SaaS, AI-enabled apps, and website-builder projects. Use for pre-deploy audits, security reviews after changes, authentication/authorization checks, secrets, privacy, dependency/supply-chain risk, payments/webhooks, file uploads, cloud/CI, and evidence-based remediation. Inspect first, change minimally, verify every fix, and never claim a control passed without evidence.
argument-hint: "[scope, e.g. full project | auth only | pre-deploy | changed files]"
---

# Universal Security Skill

Use this skill to improve the security of the current project without turning a security review into uncontrolled penetration testing. The repository, configuration, lockfiles, tests, generated local reports, and explicitly authorized local/staging runtime are the primary evidence.

## Core contract

1. **Discover before judging.** Identify the actual stack, trust boundaries, roles, sensitive assets, and deployment model.
2. **Prioritize exploitability.** Fix reachable authorization, authentication, secret, injection, payment, and tenant-isolation failures before low-impact hardening.
3. **Use evidence labels.** Every conclusion is `Observed`, `Inferred`, or `Not verified`.
4. **Never expose secrets or personal data.** Redact sensitive values in terminal output and reports.
5. **Do not silently install tools or send private code to external services.** Prefer tools already present or repository-pinned tooling.
6. **Make minimal fixes.** Preserve application behavior unless a security requirement requires a behavior change.
7. **Verify after editing.** A code change is not a verified fix. Re-run the smallest relevant test, scanner, or reproduction.
8. **Respect authorization.** Active testing is limited to the current repository, local environment, or a target the user explicitly authorizes.
9. **Do not weaken security to make tests pass.** Do not disable TLS verification, authorization, CSRF protections, signature checks, validation, or scanners as a shortcut.
10. **Escalate high-impact uncertainty.** For financial, regulated, healthcare, safety-critical, or large-scale sensitive-data systems, recommend experienced human review and authorized penetration testing in addition to this workflow.

Read [the review matrix](./references/review-matrix.md) for the control areas, [severity model](./references/severity-model.md) for prioritization, and [tooling guide](./references/tooling.md) before recommending scanner commands.

## Phase 1 — Discover the project

Inspect only files that actually exist. Typical evidence includes:

- package manifests and lockfiles
- framework and build configuration
- API routes/controllers/server actions
- authentication/session middleware
- database schema, migrations, RLS/policies, ORM models
- storage/upload code
- payment and webhook handlers
- environment examples and ignore rules
- Docker, IaC, reverse proxy, serverless, and deployment files
- CI/CD workflows
- tests, especially authorization and integration tests
- AI/LLM provider, tool, retrieval, or agent configuration

Create a compact **Project Security Profile** containing:

- languages/frameworks
- frontend/backend boundary
- auth/session model
- database and tenancy model
- external services
- payments/webhooks
- storage/uploads
- deployment/CI
- sensitive data classes
- highest-value assets
- public/admin/internal entry points
- features not present, so irrelevant checks can be skipped

If key architecture cannot be determined, say `Not verified` instead of guessing.

## Phase 2 — Threat-model critical paths

Trace the paths where an attacker could gain value or cross a trust boundary:

- anonymous -> authenticated
- user A -> user B or tenant B
- user -> admin/moderator/operator
- browser -> server
- server -> database/storage
- third-party webhook -> trusted state change
- user-controlled URL -> server-side outbound request
- upload -> storage -> later download/render
- untrusted content -> AI model -> tool/action
- CI pull request -> secrets/deployment

Prioritize sensitive data access, account takeover, authorization, money/entitlements, code execution, and destructive actions.

## Phase 3 — Run relevant review modules

Use the [review matrix](./references/review-matrix.md). Skip modules that do not apply and state why.

### A. Secrets and configuration

Check source, config, examples, generated artifacts, logs, and git history where available. Confirm that server-only credentials do not enter browser bundles. If a credential was committed, remediation includes **rotation/revocation**; deleting the current string alone is not enough.

### B. Authentication and session management

Review signup, login, logout, reset/recovery, MFA, session refresh, OAuth/OIDC, verification flows, and enumeration/brute-force controls. Session decisions must match the actual architecture rather than applying JWT or cookie advice mechanically.

### C. Authorization and tenant isolation

For every sensitive read/write action, verify server-side object ownership, tenant scope, and role/permission checks. Test safe ID substitutions in local tests. UI hiding is not authorization. Treat practical BOLA/IDOR or privilege escalation as release-blocking.

### D. Data and privacy

Map collection -> processing -> storage -> external sharing -> retention/deletion. Review logs, analytics, error tracking, AI prompts/traces, URLs, caches, browser storage, API response minimization, and deletion/export behavior. Do not claim legal compliance from a code audit.

### E. Input, output, and browser security

Review injection sinks, XSS contexts, unsafe HTML, SQL/NoSQL queries, shell/process calls, template evaluation, SSRF, path traversal, redirects, deserialization/parsing, CSP and relevant response headers.

### F. API and abuse controls

Review CORS, CSRF when cookie-based auth is used, rate limits, quotas, pagination/resource limits, expensive endpoints, signup/messaging/upload abuse, API inventory, and unsafe trust in third-party API data.

### G. Files and media

Validate content server-side, cap resource usage, avoid user-controlled filesystem paths, isolate untrusted active content, require authorization for access/deletion, and use safe download/content headers. Malware scanning is risk-dependent, not automatically mandatory.

### H. Payments, webhooks, and business logic

The server is authoritative for price, quantity, discounts, role-sensitive state, entitlements, refunds, and subscription state. Verify webhook authenticity as required by the provider, idempotency, replay/duplicate/out-of-order behavior, environment separation, and concurrency edge cases. Never perform real financial transactions during testing unless the user explicitly controls the sandbox and requests it.

### I. Dependencies, supply chain, CI/CD, infrastructure

Review lockfiles, vulnerable dependencies, SAST, secrets, containers/IaC, workflow permissions, untrusted PR access to secrets, artifact provenance where relevant, production debug/admin exposure, network/database protection, backup/rollback and security logging. See [tooling.md](./references/tooling.md).

### J. AI-enabled features

When the app uses LLMs or agents, review prompt injection, indirect injection from retrieved/web content, tool permissions, server-side authorization before tool actions, data leakage to model providers/traces, output validation, destructive-action confirmation, spend/rate limits, and untrusted model output reaching HTML, SQL, shell, URLs, or privileged tools.

## Phase 4 — Establish baseline and scan

Before editing, run the smallest safe baseline available, for example build/typecheck/lint/tests. Then use local or repository-approved scanner layers that match the project. Do not install arbitrary packages merely because a tool is mentioned in this skill.

The optional script [security-check.sh](./scripts/security-check.sh) detects common project types and runs only tools already installed. It is deliberately conservative and does not attack remote targets.

## Phase 5 — Report findings before broad changes

For each real finding, record:

- ID
- severity
- confidence
- status (`Open`, `Fixed`, `Risk accepted`, `Not verified`)
- affected file/route/component
- evidence without sensitive values
- exploit scenario at a defensive level
- impact
- recommended minimal fix
- verification method
- standards mapping when useful

Use [SECURITY_REPORT.md](./templates/SECURITY_REPORT.md) as the report shape.

## Phase 6 — Apply safe remediation

If the user requested fixes:

- fix Critical/High issues first
- prefer central authorization/validation helpers over duplicated checks
- add regression tests for meaningful flaws
- avoid unrelated refactors
- preserve public API compatibility where practical
- request explicit approval before destructive data migrations, credential rotation, changing identity providers, disabling features, or altering production infrastructure
- never fabricate secret values; use placeholders/documentation when configuration is missing

## Phase 7 — Verify each fix

For each changed finding:

1. reproduce or test the original vulnerable path safely
2. apply the fix
3. run focused regression tests
4. re-run the relevant scanner or static check when available
5. inspect the diff for accidental bypasses or leaked values
6. label as `Fixed` only when verification evidence exists

If runtime access, test data, credentials, or tooling are unavailable, label the result `Not verified` even if the code appears correct.

## Default release gates

Unless the project has a documented alternative risk policy, recommend blocking public release for observed issues such as:

- exposed live secrets or privileged service credentials
- practical authentication bypass/account takeover
- missing tenant/object authorization on sensitive data/actions
- server-side injection with meaningful compromise potential
- public unsafe admin/debug interfaces
- payment/webhook flaws that can grant value or entitlement
- reachable critical dependency vulnerability with no effective mitigation
- arbitrary code/command execution from untrusted input

Use the [severity model](./references/severity-model.md) rather than severity by scanner label alone.

## Required final response

Start with a concise verdict, e.g.:

`Security review: BLOCKED — 1 Critical, 2 High. Main risk: invoice API lacks tenant ownership checks.`

Then provide a compact findings table and finish with:

- **Fixes applied** — exact files changed
- **Verification run** — commands/tests/scans and results
- **Not verified** — inaccessible runtime, absent tooling, unavailable secrets/test accounts, etc.
- **Next 3 actions** — highest-value remaining work

Never say “secure,” “fully secure,” “all good,” or “passed” for areas that were not actually inspected or tested.
