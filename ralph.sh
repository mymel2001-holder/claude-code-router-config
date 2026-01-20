#!/bin/bash

# Determine max iterations
if [[ -z "$1" ]]; then
  max_iterations=0   # 0 means infinite loop
else
  max_iterations="$1"
fi

i=1
while :; do
  # Stop if we reached max iterations (when max_iterations > 0)
  if [[ "$max_iterations" -gt 0 && "$i" -gt "$max_iterations" ]]; then
    echo "Reached max iterations ($max_iterations)"
    exit 1
  fi

  echo "Iteration $i"
  echo "--------------------------------"

  result=$(npx @anthropic-ai/sandbox-runtime \
    ccr code --dangerously-skip-permissions \
    -p "$(cat global-ralph-prompt.md)" \
    --output-format text 2>&1) || true

  echo "$result"

  if [[ "$result" == *"<promise>COMPLETE</promise>"* ]]; then
    echo "All tasks complete after $i iterations."
    exit 0
  fi

  echo ""
  echo "--- End of iteration $i ---"
  echo ""

  ((i++))
done
