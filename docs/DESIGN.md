# Design Notes

## Goals

- portable Agent Skill rather than a single giant prompt
- usable by beginners without pretending to replace a security engineer
- stack-aware to avoid irrelevant or harmful advice
- evidence-based so findings are traceable
- remediation-aware but conservative with automatic changes
- verification-first so “fixed” has a concrete meaning

## Non-goals

- autonomous penetration testing of arbitrary internet targets
- compliance certification
- automatic production credential rotation
- automatic package installation or uploading private source to external scanners
- guaranteeing that a project is vulnerability-free

## Why one primary skill

The v1 release keeps one main `universal-security` skill with linked reference modules. This makes installation simple and lets the agent load detailed material only when needed. Future versions can split highly specialized workflows into separate skills if real usage shows that improves reliability.
