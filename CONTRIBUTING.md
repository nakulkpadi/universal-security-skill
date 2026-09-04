# Contributing to Universal Security Skill

Thank you for contributing to **Universal Security Skill — Engineered by Nakul.Kapdi**.

## Development principles

A good security check must document:

1. **Applicability** — when the check should run and when it should be skipped.
2. **Evidence** — what code/config/runtime observation demonstrates the problem.
3. **Impact** — what security property is affected.
4. **Remediation** — a minimal, framework-appropriate fix pattern.
5. **Verification** — a test or scanner step that proves the path is closed.
6. **False positives** — common cases where the pattern is safe or not reachable.

Do not add instructions for unauthorized exploitation. Do not use real credentials or personal data in fixtures.

## Pull request checklist

Before opening a PR:

```bash
bash tests/test-scripts.sh
```

When available locally, also run:

```bash
shellcheck .github/skills/universal-security/scripts/*.sh tests/*.sh
```

For skill-content changes, add or update a regression fixture/example where practical. Keep `SKILL.md` focused; move deep reference material to `references/` and link it from the main skill.

## Documentation rules

- Distinguish observed facts from assumptions.
- Avoid claiming compliance or complete security.
- Prefer framework-specific, testable advice over universal magic settings.
- Link to stable upstream documentation instead of copying large sections.
- Preserve third-party attribution and licenses.

## Security reports

Do not report suspected vulnerabilities through a public issue. Follow [`SECURITY.md`](SECURITY.md).
