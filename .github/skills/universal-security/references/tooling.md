# Tooling Guide

Use defense-in-depth. No scanner replaces manual authorization and business-logic review.

## Preferred layers

- **Secrets:** Gitleaks or equivalent local secret scanner.
- **Dependencies/SBOM:** OSV-Scanner and ecosystem-native audit tools where appropriate.
- **SAST:** CodeQL and/or Semgrep, with repository-specific rules where useful.
- **Containers/IaC/misconfiguration:** Trivy or another organization-approved scanner.
- **Dynamic web testing:** OWASP ZAP baseline against an explicitly authorized local or staging target.
- **Standards/reference:** OWASP ASVS, OWASP API Security Top 10, and framework/provider security documentation.

## Operating rules

- Prefer tooling already installed or pinned by the repository.
- Never upload private source, secrets, customer data, or proprietary artifacts to public scanning services without explicit approval.
- Never print raw secrets in a report. Redact values while keeping file/line/context evidence useful.
- Use lockfiles and deterministic CI installs.
- Treat scanner output as leads: validate reachability, context, and exploitability before assigning final severity.
- Do not auto-run active scanners against production or an arbitrary URL. Require explicit authorization.

## Example commands (only if already installed / approved)

```bash
# Secrets
gitleaks detect --redact --no-banner

# Dependencies
osv-scanner scan source -r .

# SAST
semgrep scan --config auto .

# Container / filesystem / IaC
trivy fs .

# ZAP example: only against an explicitly authorized local/staging target
# zap-baseline.py -t http://127.0.0.1:3000
```

Tool syntax changes over time; use the installed tool's help/version and project documentation when a command differs.
