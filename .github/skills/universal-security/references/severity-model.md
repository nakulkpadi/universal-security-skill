# Severity Model

Severity combines **impact**, **exploitability**, **exposure**, and **confidence**. Scanner-provided severity is evidence, not the final decision.

## Critical

Likely or demonstrated compromise of highly sensitive data, production credentials, privileged control, arbitrary code execution, cross-tenant access at scale, or financial entitlement with little attacker friction.

Examples: live service-role key exposed to clients; unauthenticated admin action; practical RCE; broad cross-tenant data access.

## High

Serious confidentiality, integrity, authorization, or account security failure that is realistically exploitable but has more constraints than Critical.

Examples: IDOR on sensitive resources; account takeover path requiring a victim action; forged webhook granting paid access; stored XSS in privileged context.

## Medium

Meaningful weakness with limited impact, prerequisites, compensating controls, or narrower reach.

Examples: missing abuse limits on a moderately costly endpoint; weak security header policy with no demonstrated exploit chain; limited information disclosure.

## Low

Hardening gap or low-impact issue with limited realistic abuse.

## Informational

Observation, hygiene recommendation, or unverified concern that is not currently established as a vulnerability.

## Confidence

Use `High`, `Medium`, or `Low` confidence separately from severity. A severe hypothetical with weak evidence should not be presented as an observed Critical finding.
