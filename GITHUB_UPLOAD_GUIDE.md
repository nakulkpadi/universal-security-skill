# Publish Universal Security Skill on GitHub

This guide assumes the repository folder already contains the files in this release.

## Recommended repository settings

**Repository name:** `universal-security-skill`

**Description:**

> Stack-aware security Agent Skill for VS Code, GitHub Copilot and coding agents. Audit, fix, verify and document web, API, SaaS and AI application security issues.

**Visibility:** Public, if you want the community to discover and contribute to it.

**Topics:**

`application-security`, `web-security`, `cybersecurity`, `secure-coding`, `devsecops`, `owasp`, `vscode`, `github-copilot`, `agent-skills`, `ai-security`, `security-audit`, `api-security`, `supabase-security`

## Option A — GitHub website upload

1. Sign in to GitHub and choose **New repository**.
2. Name it `universal-security-skill`.
3. Add the suggested description.
4. Choose **Public** if this is intended as an open-source project.
5. **Do not initialize with a README, `.gitignore`, or license** because those files already exist in this package.
6. Create the empty repository.
7. On the empty repository page choose **uploading an existing file**.
8. Upload the contents of this repository folder, preserving directories such as `.github/`.
9. Commit with a message such as `Initial public release v1.1.0`.
10. Open **Settings → General** and confirm Issues/Discussions features you want are enabled.
11. Open **Settings → Code security and analysis** and enable the security features appropriate to your account/repository.
12. Open the **Security** tab and enable private vulnerability reporting if available.
13. Add the recommended repository topics from the About section on the repository home page.
14. Create a release/tag named `v1.1.0` and attach the release ZIP if you want downloadable packaged releases.

GitHub's web uploader may not preserve executable permission bits reliably in every workflow. The command-line method below is recommended for shell scripts.

## Option B — Git command line (recommended)

Create an empty GitHub repository first, then in this folder run:

```bash
git init
git branch -M main
git add .
git commit -m "Initial public release v1.1.0"
git remote add origin https://github.com/YOUR-USERNAME/universal-security-skill.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your GitHub username or organization.

If Git asks you to authenticate, use GitHub's supported authentication flow, GitHub CLI, SSH key, or a personal access token rather than your account password.

## Option C — GitHub CLI

With GitHub CLI installed and authenticated:

```bash
git init
git branch -M main
git add .
git commit -m "Initial public release v1.1.0"
gh repo create universal-security-skill --public --source=. --remote=origin --push
```

## After the first push

Run through this checklist:

- README renders correctly on the repository homepage.
- `LICENSE` is detected by GitHub.
- `SECURITY.md`, `CONTRIBUTING.md`, and `CODE_OF_CONDUCT.md` appear in the community profile.
- GitHub Actions `Validate repository` passes.
- Issue templates appear when opening a new issue.
- Private vulnerability reporting is enabled if available.
- Branch protection/ruleset requires pull requests and passing validation for `main` once collaboration begins.
- Dependabot is enabled if desired.
- Add a repository social preview image later for stronger sharing/branding.
- Create the first release tag: `v1.1.0`.

## Suggested first release

**Tag:** `v1.1.0`

**Title:** `Universal Security Skill v1.1.0 — GitHub-ready release`

**Release notes:**

> First GitHub-ready public release of Universal Security Skill, Engineered by Nakul.Kapdi. Includes stack-aware security review instructions, evidence-based remediation and verification, local helper scripts, templates, CI validation, contribution/security policies, and application security coverage for web, API, SaaS, cloud and AI-enabled projects.

## Important security note

Never commit `.env` files, API keys, access tokens, database passwords or other live credentials. The included `.gitignore` blocks common environment-file patterns, but you should still review the staged diff before every push:

```bash
git status
git diff --cached
```
