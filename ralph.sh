#!/bin/bash

# Suppress Node warnings
export NODE_OPTIONS='--no-deprecation'

# Ensure Ctrl+C kills the whole loop
trap "exit" INT

max_iterations=${1:-0}
i=1

while :; do
  if [[ "$max_iterations" -gt 0 && "$i" -gt "$max_iterations" ]]; then
    echo "Reached max iterations ($max_iterations)"
    exit 1
  fi

  echo "Iteration $i"
  echo "--------------------------------"

  ccr code --dangerously-skip-permissions --output-format text --print "$(cat ~/global-ralph-prompt.md)" || true > .iterations.log 2>&1  

  cat ".iterations.log"

  # Logic check for the promise
  if [[ "$(cat .iterations.log)" == *"<promise>COMPLETE</promise>"* ]]; then
    echo "--------------------------------"
    echo "✅ All tasks complete after $i iterations."
    exit 0
  fi

  echo ""
  echo "--- End of iteration $i ---"
  echo ""

  ((i++))
done
