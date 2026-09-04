#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="$REPO/.github/skills/universal-security"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

pass() { printf 'PASS: %s\n' "$1"; }
fail() { printf 'FAIL: %s\n' "$1" >&2; exit 1; }

bash -n "$SKILL/scripts/detect-stack.sh" || fail "detect-stack syntax"
bash -n "$SKILL/scripts/security-check.sh" || fail "security-check syntax"
pass "shell syntax"

mkdir -p "$TMP/app"
cat > "$TMP/app/package.json" <<'JSON'
{"dependencies":{"next":"15.0.0","@supabase/supabase-js":"2.0.0","stripe":"17.0.0"}}
JSON
touch "$TMP/app/package-lock.json" "$TMP/app/next.config.js"
output="$("$SKILL/scripts/detect-stack.sh" "$TMP/app")"
grep -q 'node-js: package.json' <<<"$output" || fail "node detection"
grep -q 'framework: nextjs' <<<"$output" || fail "Next.js detection"
grep -q 'dependency-hint: supabase' <<<"$output" || fail "Supabase detection"
grep -q 'dependency-hint: stripe' <<<"$output" || fail "Stripe detection"
pass "stack detection fixture"

mkdir -p "$TMP/reports"
"$SKILL/scripts/security-check.sh" "$TMP/app" "$TMP/reports" >"$TMP/security-check-output.txt"
[[ -f "$TMP/reports/stack.txt" ]] || fail "stack report creation"
grep -q 'Scanner output is evidence to review' "$TMP/security-check-output.txt" || fail "completion message"
pass "conservative security-check execution"

for f in README.md LICENSE SECURITY.md CONTRIBUTING.md CODE_OF_CONDUCT.md SUPPORT.md NOTICE.md CHANGELOG.md CITATION.cff VERSION; do
  [[ -s "$REPO/$f" ]] || fail "missing required repository file: $f"
done
pass "repository community files"

head -n 1 "$SKILL/SKILL.md" | grep -qx -- '---' || fail "SKILL front matter start"
grep -q '^name: universal-security$' "$SKILL/SKILL.md" || fail "SKILL name"
grep -q '^description:' "$SKILL/SKILL.md" || fail "SKILL description"
pass "Agent Skill metadata"

printf '\nAll repository tests passed.\n'
