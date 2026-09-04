# Example Prompts

## Full pre-deploy review

> Run the universal security review for this repository. Detect the stack first. Review only relevant modules, establish a baseline, prioritize exploitable issues, and create a security report. Do not edit until you show me Critical/High findings.

## Safe remediation

> Fix the Critical and High findings from the security review. Keep changes minimal, add regression tests, rerun the relevant checks, and do not mark anything fixed without verification evidence.

## Changed-files review

> Review my current git diff for security regressions. Trace any changed auth, authorization, payment, upload, API, secret, or data-flow behavior into surrounding code. Do not perform a full-project audit unless the changed code requires it.

## Supabase

> Review this Supabase app for browser-exposed credentials, RLS coverage, cross-user/tenant access, storage policies, auth/session issues, and server-only use of privileged credentials. Use local tests where possible and redact secret values.

## Payments

> Review payment and webhook logic defensively. Verify server-authoritative pricing and entitlements, signature verification, idempotency, replay/duplicate behavior, environment separation, and authorization. Use test/sandbox paths only; do not create real charges.

## AI/agent application

> Review the AI features for indirect prompt injection, tool over-permission, missing server-side authorization before actions, data leakage, unsafe model output handling, and cost/abuse controls. Treat retrieved web/document content as untrusted.
