#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"
cd "$root"

echo "== Project stack hints =="
[[ -f package.json ]] && echo "node-js: package.json"
[[ -f pnpm-lock.yaml ]] && echo "package-manager: pnpm"
[[ -f yarn.lock ]] && echo "package-manager: yarn"
[[ -f package-lock.json ]] && echo "package-manager: npm"
[[ -f bun.lockb || -f bun.lock ]] && echo "package-manager: bun"
[[ -f pyproject.toml ]] && echo "python: pyproject.toml"
[[ -f requirements.txt ]] && echo "python: requirements.txt"
[[ -f Pipfile ]] && echo "python: Pipfile"
[[ -f composer.json ]] && echo "php: composer.json"
[[ -f Gemfile ]] && echo "ruby: Gemfile"
[[ -f go.mod ]] && echo "go: go.mod"
[[ -f Cargo.toml ]] && echo "rust: Cargo.toml"
[[ -f Dockerfile ]] && echo "container: Dockerfile"
find . -maxdepth 2 -name 'docker-compose*.yml' -o -name 'docker-compose*.yaml' 2>/dev/null | sed 's#^#compose: #' || true
[[ -d .github/workflows ]] && echo "ci: .github/workflows"
[[ -f next.config.js || -f next.config.mjs || -f next.config.ts ]] && echo "framework: nextjs"
[[ -f vite.config.js || -f vite.config.ts ]] && echo "framework: vite"
[[ -f manage.py ]] && echo "framework-hint: django"
[[ -f artisan ]] && echo "framework-hint: laravel"

if [[ -f package.json ]] && command -v node >/dev/null 2>&1; then
  node - <<'NODE' 2>/dev/null || true
const p=require('./package.json'); const d={...(p.dependencies||{}),...(p.devDependencies||{})};
for (const [k,label] of [['next','nextjs'],['express','express'],['@supabase/supabase-js','supabase'],['firebase','firebase'],['stripe','stripe'],['@auth/core','authjs'],['next-auth','next-auth']]) if(d[k]) console.log(`dependency-hint: ${label}`)
NODE
fi
