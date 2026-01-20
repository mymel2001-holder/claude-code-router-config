#!/bin/bash

# Suppress the DeprecationWarning logs
export NODE_OPTIONS='--no-deprecation'

max_iterations=${1:-0}

i=1
while :; do
  if [[ "$max_iterations" -gt 0 && "$i" -gt "$max_iterations" ]]; then
    echo "Reached max iterations ($max_iterations)"
    exit 1
  fi

  echo "Iteration $i"
  echo "--------------------------------"

  # Switch to -m (message) and ensure output-format is text
  # We remove --non-interactive since it's not supported here
  result=$(ccr code --dangerously-skip-permissions \
    --output-format text \
    -m "$(cat global-ralph-prompt.md)" 2>&1) || true

  echo "$result"

  if [[ "$result" == *"<promise>COMPLETE</promise>"* ]]; then
    echo "--------------------------------"
    echo "✅ All tasks complete after $i iterations."
    exit 0
  fi

  echo ""
  echo "--- End of iteration $i ---"
  echo ""

  ((i++))
done
