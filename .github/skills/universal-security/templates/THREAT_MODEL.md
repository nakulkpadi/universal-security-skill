# Lightweight Threat Model

## Assets
- Accounts/identities:
- Sensitive data:
- Money/entitlements:
- Admin/operator capability:
- Secrets/credentials:

## Actors and Roles
- Anonymous:
- User:
- Privileged roles:
- Third-party systems:

## Trust Boundaries
- Browser -> server:
- Server -> database/storage:
- External webhook -> server:
- CI -> deployment:
- AI model/retrieval -> tools/actions:

## Critical Abuse Cases
1. Cross-user/tenant data access
2. Privilege escalation
3. Account takeover
4. Injection or unsafe execution
5. Payment/entitlement manipulation
6. Secret or sensitive-data disclosure
7. Abuse/resource exhaustion
8. AI prompt/tool manipulation (if applicable)

## Mitigations and Tests
- Add project-specific controls and regression tests here.
