#!/bin/bash
# Ship Pipeline Stop Hook — ensures /ship pipeline completes before stopping
#
# Mechanisms:
# 1. Marker file: /tmp/claude-ship-complete-${SESSION_ID} exists → allow
# 2. Transcript fallback: last message contains completion keywords → allow
# 3. Non-pipeline work → allow through
#
# Input: stdin receives JSON { "session_id": "...", "transcript": [...] }
# Output: JSON { "decision": "block", "reason": "..." } or exit 0 to allow

INPUT=$(cat)

# Get session ID
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty' 2>/dev/null)

# Mechanism 1: Marker file exists → pipeline completed, allow
if [ -n "$SESSION_ID" ] && [ -f "/tmp/claude-ship-complete-${SESSION_ID}" ]; then
  rm -f "/tmp/claude-ship-complete-${SESSION_ID}"
  exit 0
fi

# Get last assistant message
LAST_MSG=$(echo "$INPUT" | jq -r '.transcript[-1].message // empty' 2>/dev/null)

# Mechanism 2: Transcript contains completion markers → allow
# Customize these keywords for your language/workflow
if echo "$LAST_MSG" | grep -qiE "retrospective|retro complete|pipeline complete"; then
  exit 0
fi

# Check if we're in a pipeline (has pipeline keywords but not complete)
PIPELINE_KEYWORDS="Phase [1-5]|create PR|PR created|starting review|review.*passed|merge.*PR|notify|/ship"
if echo "$LAST_MSG" | grep -qiE "$PIPELINE_KEYWORDS"; then
  HAS_MERGE=$(echo "$LAST_MSG" | grep -ci "merged\|merge complete")
  HAS_NOTIFY=$(echo "$LAST_MSG" | grep -ci "notif\|sent to")
  HAS_RETRO=$(echo "$LAST_MSG" | grep -ci "retrospective\|retro\|Phase 6")

  if [ "$HAS_MERGE" -gt 0 ] && [ "$HAS_NOTIFY" -gt 0 ] && [ "$HAS_RETRO" -gt 0 ]; then
    exit 0
  else
    echo '{"decision": "block", "reason": "Ship pipeline not complete. Continue to next step (PR → review → merge → notify → /retro). If not running a pipeline, just respond to the user directly."}'
    exit 0
  fi
fi

# Non-pipeline stop → allow
exit 0
