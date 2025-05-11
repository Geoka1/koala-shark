#!/bin/bash
REPO_TOP=$(git rev-parse --show-toplevel)
eval_dir="${REPO_TOP}/vps-audit"
rm "${eval_dir}"/*report.txt || true
rm "${eval_dir}"/*processed.txt || true
