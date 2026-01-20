#!/bin/bash

ccr start
sleep 5

max_iterations=${1:-0}

i=1
while :; do
  if [[ "$max_iterations" -gt 0 && "$i" -gt "$max_iterations" ]]; then
    echo "Reached max iterations ($max_iterations)"
    exit 1
  fi

  echo "Iteration $i"
  echo "--------------------------------"

  # We use 'ccr code' with the essential --non-interactive flag.
  # This forces the router to execute tool calls and return the final text output.
  result=$(ccr code \
    --dangerously-skip-permissions \
    --non-interactive \
    -p "$(cat global-ralph-prompt.md)" 2>&1) || true

  echo "$result"

  # Check for the completion tag in the returned text
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
