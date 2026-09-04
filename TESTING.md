# Testing and Verification

## What has been tested for v1.1.0

The repository includes deterministic checks that can run without downloading third-party scanners:

- `bash -n` syntax validation for bundled shell scripts
- execution of `detect-stack.sh` against a synthetic Node/Next.js/Supabase/Stripe fixture
- execution of `security-check.sh` when optional scanners are missing
- validation that expected output files are created
- checks for required GitHub/community files
- checks that the Agent Skill entry file contains valid-looking YAML front matter with `name` and `description`

## What this does not prove

These tests do **not** prove that every compatible AI agent will interpret the skill identically, that every scanner integration works on every OS, or that the skill can find every real vulnerability. An Agent Skill is partly behavioral instructions consumed by an AI coding agent, so full end-to-end quality also requires evaluation across representative projects and agent environments.

Before calling a future release production-grade, maintainers should test it against intentionally vulnerable fixtures covering authorization/IDOR, XSS, injection, secret exposure, webhook validation, unsafe uploads, Supabase RLS, CI permissions and AI-tool authorization.
