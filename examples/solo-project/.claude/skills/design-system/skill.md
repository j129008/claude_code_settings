---
name: design-system
description: Design system reference — color tokens, typography, spacing, component patterns. Use when building or reviewing UI.
user-invocable: false
---

# Design System Reference

> **Customize these tokens for your project's visual identity.**

## Color Tokens

| Token | Value | Usage |
|-------|-------|-------|
| `--bg-deep` | `#080810` | Deepest background (inputs, code) |
| `--bg-base` | `#0d0d18` | Page background |
| `--bg-raised` | `#12121f` | Cards, sidebar, header |
| `--bg-float` | `#18182a` | Floating elements |
| `--bg-overlay` | `#1e1e32` | Hover states, overlays |
| `--accent` | `#7c5cfc` | Primary action |
| `--accent-bright` | `#9b7cff` | Highlights, active states |
| `--accent-dim` | `rgba(124,92,252,0.18)` | Subtle accent backgrounds |
| `--danger` | `#f05050` | Destructive actions |
| `--text-primary` | `#f0f0f8` | Body text |
| `--text-secondary` | `#9090b0` | Labels, descriptions |
| `--text-tertiary` | `#60607a` | Hints, placeholders |
| `--border-subtle` | `rgba(255,255,255,0.06)` | Lightest border |
| `--border-muted` | `rgba(255,255,255,0.10)` | Default border |

## Typography
- System font stack + monospace fallback
- Base size: `14px`, antialiased
- Labels: `0.78rem`, uppercase, `letter-spacing: 0.07em`

## Spacing Scale
`6px`, `8px`, `12px`, `14px`, `20px`, `28px`

## Radius
- `--radius-sm: 6px` — buttons, inputs
- `--radius-md: 10px` — cards, accordions
- `--radius-lg: 14px` — panels, modals

## Interaction Conventions
- Hover: 0.15s transition, subtle bg shift
- Focus: accent border + 3px accent-dim ring
- Loading: spinner, 0.55s linear rotation
- Entry: opacity 0→1 + scale(0.96)→1 + translateY(12px)→0
