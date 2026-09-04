# Security Review Matrix

Use this matrix as a coverage map, not a demand to run every check on every project.

| Area | Key questions | Typical evidence | Release-blocking examples |
|---|---|---|---|
| Secrets | Are privileged keys committed, logged, bundled, or exposed? | git history, env/config, frontend build vars | live admin/service secret exposed |
| Authentication | Can accounts be bypassed, hijacked, enumerated, or reset unsafely? | auth handlers, sessions, reset flows, tests | practical auth bypass/account takeover |
| Authorization | Does every sensitive action enforce ownership/tenant/role server-side? | routes, policies, middleware, RLS, tests | BOLA/IDOR, privilege escalation |
| Data/privacy | Is sensitive data minimized, protected, and kept out of logs/URLs/AI traces? | models, logging, analytics, API responses | broad sensitive-data exposure |
| Input/output | Can untrusted input reach SQL, shell, HTML, filesystem, URLs, templates? | sinks, validators, renderers | RCE, high-impact injection |
| API/abuse | Are CORS/CSRF/rate/resource limits appropriate? | middleware, gateway config | unauthenticated destructive abuse |
| Uploads | Can files escape storage boundaries or execute/render unsafely? | upload handlers, storage, CDN | executable active-content takeover |
| Payments | Is value/entitlement decided server-side and webhooks authenticated/idempotent? | checkout/webhooks/state machine | forged payment grants access/value |
| Dependencies | Are reachable critical known vulnerabilities present? | lockfile, scanner report | reachable critical exploit |
| CI/CD | Can untrusted code obtain secrets or production permissions? | workflow YAML, permissions | PR-to-production credential path |
| Infrastructure | Are debug/admin/data services exposed or weakly protected? | IaC, Docker, proxy/deploy config | public admin/database exposure |
| AI/agents | Can untrusted text cause privileged tool actions or leak data? | prompts, tool policy, retrieval, handlers | prompt-to-privileged action without auth |

## Stack-sensitive checks

### Supabase/Postgres-backed apps

- RLS/policies on tables reachable from untrusted clients
- service-role/admin credential server-only
- policy behavior for cross-user and cross-tenant IDs
- storage bucket policies and signed URL behavior

### Firebase

- Firestore/Realtime Database/Storage rules
- privileged Admin SDK server-only
- App Check as defense-in-depth where appropriate
- callable/API authorization separately from UI state

### Next.js/React

- public environment-variable prefixes do not contain secrets
- server/client boundary and server actions/routes
- unsafe HTML rendering and CSP
- caching of personalized/sensitive responses

### Node/Express

- centralized authz, validation, error handling
- proxy awareness for secure cookies/rate limiting
- Helmet/header policy tailored to the app
- safe subprocess and filesystem usage

### Python/Django/FastAPI/Flask

- framework security settings and trusted hosts/origins
- ORM/raw query handling
- serializer/response field control
- debug mode and exception exposure

### PHP/Laravel/WordPress-like projects

- authorization policies/capability checks
- CSRF and output escaping
- upload/plugin/theme risk
- environment/debug exposure
- dependency and extension update posture

### Multi-tenant SaaS

- tenant context derived from trusted server-side identity
- every database query scoped by tenant/ownership
- background jobs, exports, search, caches, files and analytics tenant-isolated
- admin/support impersonation audited and constrained
