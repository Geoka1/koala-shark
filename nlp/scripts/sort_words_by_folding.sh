#!/bin/bash
# tag: sort_words_by_folding
# set -e

IN=${IN:-$SUITE_DIR/inputs/pg}
OUT=${1:-$SUITE_DIR/outputs/3_2/}
ENTRIES=${ENTRIES:-1000}
mkdir -p "$OUT"

for input in $(ls ${IN} | head -n ${ENTRIES} | xargs -I arg1 basename arg1); do
    tr -c 'A-Za-z' '[\n*]' < "$IN/$input" | grep -v "^\s*$" | sort | uniq -c | sort -f > "${OUT}/${input}" &
done
wait

echo 'done';
# rm -rf ${OUT}
