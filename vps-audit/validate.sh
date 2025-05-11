#!/bin/bash
REPO_TOP=$(git rev-parse --show-toplevel)
GENERATE=false

for arg in "$@"; do
    if [[ "$arg" == "--generate" ]]; then
        GENERATE=true
        break
    fi
done

if [[ "$GENERATE" == true ]]; then
    python3 validate.py --generate
    exit 0
else
    python3 validate.py
    # echo "vps-audit $?"
    #check if vps-audit-negate-processed.txt and vps-audit-processed.txt exist and not empty
    if [[ -s "${REPO_TOP}/vps-audit/vps-audit-negate-processed.txt" && -s "${REPO_TOP}/vps-audit/vps-audit-processed.txt" ]]; then
        echo "vps-audit $?"
    else
        echo "vps-audit 1"
    fi
fi
