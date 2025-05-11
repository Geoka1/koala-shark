#!/usr/bin/env bash
# tag: trigram_rec_parallel

IN=${IN:-$SUITE_DIR/inputs/pg}
OUT=${1:-$SUITE_DIR/outputs/6_1/}
ENTRIES=${ENTRIES:-1000}
mkdir -p "$OUT"

pure_func() {
    local input="$1"
    local pattern="$2"
    local out_file="$3"

    grep "$pattern" < "$IN/$input" |
    tr -sc 'A-Za-z' '\n*' |
    paste - - - |
    sort | uniq -c |
    sort -nr | sed -n '1,5p' > "$out_file"
}
export -f pure_func

find "$IN" -maxdepth 1 -type f | head -n "$ENTRIES" | while IFS= read -r filepath; do
    input=$(basename "$filepath")
    pure_func "$input" "the land of" "$OUT/${input}.0.out" &
    pure_func "$input" "And he said" "$OUT/${input}.1.out" &
done
wait
