---
name: ui-review
description: UI/UX review checklist for evaluating frontend changes. Use when reviewing new or modified UI.
user-invocable: false
---

# UI/UX Review Checklist

## Before Reviewing
1. Read ALL changed frontend files
2. Load the `design-system` skill for token reference
3. Understand the feature's purpose

## Review Dimensions

### Visual Consistency
- Uses existing CSS custom properties?
- No hardcoded colors, font sizes, or radius values?
- Follows established component patterns?

### Information Architecture
- Controls in the right section/accordion?
- Progressive disclosure for advanced options?
- Proper label hierarchy?

### Interaction Quality
- Focus states with accent ring (not browser default)?
- Hover transitions (0.15s)?
- Loading states with clear feedback?
- Keyboard operable?
- Minimum 32px touch targets?

### Responsive
- Works at tablet breakpoint (~860px)?
- Works at mobile breakpoint (~480px)?
- No horizontal overflow?

### Dark Theme
- Sufficient text contrast?
- No pure white (#fff) backgrounds?
- Borders in the subtle range?

## Output
- **APPROVED** — Ship it
- **NEEDS WORK** — List issues with file:line references
- **REJECTED** — Fundamental problems, explain why
