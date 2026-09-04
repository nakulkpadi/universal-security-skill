#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
OUT="${2:-security-reports}"
mkdir -p "$OUT"

have() { command -v "$1" >/dev/null 2>&1; }
run() {
  local name="$1"; shift
  printf '\n== %s ==\n' "$name"
  set +e
  "$@" >"$OUT/${name}.txt" 2>&1
  local code=$?
  set -e
  echo "$name exit=$code report=$OUT/${name}.txt"
  return 0
}

printf 'Universal Security Skill - conservative local check\n'
printf 'Root: %s\nReports: %s\n' "$ROOT" "$OUT"

"$(dirname "$0")/detect-stack.sh" "$ROOT" | tee "$OUT/stack.txt"

cd "$ROOT"

if have gitleaks; then
  run gitleaks gitleaks detect --redact --no-banner --source .
else
  echo "skip gitleaks: not installed"
fi

if have osv-scanner; then
  run osv-scanner osv-scanner scan source -r .
else
  echo "skip osv-scanner: not installed"
fi

if have semgrep; then
  run semgrep semgrep scan --config auto .
else
  echo "skip semgrep: not installed"
fi

if have trivy; then
  run trivy trivy fs .
else
  echo "skip trivy: not installed"
fi

if [[ -f package.json ]]; then
  if [[ -f package-lock.json ]] && have npm; then
    run npm-audit npm audit --audit-level=high
  elif [[ -f pnpm-lock.yaml ]] && have pnpm; then
    run pnpm-audit pnpm audit --audit-level high
  elif [[ -f yarn.lock ]] && have yarn; then
    run yarn-audit yarn npm audit --severity high
  fi
fi

printf '\nDone. Scanner output is evidence to review, not an automatic security verdict.\n'
