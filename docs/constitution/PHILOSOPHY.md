# Project Philosophy

**Status**: Template — customize for your project
**Date**: {{DATE}}

---

## Core Mission

<!-- Define what your project is fundamentally trying to achieve -->
{{PROJECT_DESCRIPTION}}

---

## Principles (In Priority Order)

### 1. Survive (Stability First)
<!-- What must never break? What are the non-negotiable constraints? -->
- System must remain stable under all conditions
- No change should compromise existing functionality
- Recovery from failures must be automatic where possible

### 2. Quality (Get It Right)
<!-- What does "correct" mean for your project? -->
- Every feature must be tested before release
- Code review catches issues before they reach production
- Technical debt is tracked and addressed systematically

### 3. Velocity (Move Fast)
<!-- How do you balance speed with quality? -->
- Small, frequent releases over large batches
- Automation reduces manual overhead
- Config-driven changes are preferred over code changes

### 4. Optimize (Make It Better)
<!-- What are nice-to-haves vs must-haves? -->
- Performance optimization after correctness
- UX improvements based on actual usage patterns
- Process improvements from retrospective learnings

---

## Decision Framework

When evaluating any change, ask:
1. **Does it break existing stability?** → If yes, reconsider
2. **Is it tested and reviewed?** → If no, add tests first
3. **Does it follow our ADRs?** → If no, propose ADR change or find alternative
4. **Is it the simplest approach?** → If no, simplify

---

## What We DON'T Optimize

<!-- Be explicit about anti-goals -->
- Not pursuing 100% test coverage (diminishing returns beyond ~80%)
- Not optimizing for maximum feature velocity (quality over speed)
- Not chasing every new technology (stability over novelty)

---

**Review Schedule**: Every 5th sprint retro
