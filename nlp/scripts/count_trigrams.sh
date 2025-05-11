#!/bin/bash
# tag: count_trigrams.sh
# set -e

IN=${IN:-$SUITE_DIR/inputs/pg}
OUT=${1:-$SUITE_DIR/outputs/4_3b/}
ENTRIES=${ENTRIES:-1000}
mkdir -p "$OUT"

pure_func() {
    input=$1
    infile=$2
    outfile=$3

    TEMPDIR=$(mktemp -d)

    tr -c 'A-Za-z' '[\n*]' < "$infile" | grep -v '^\s*$' > "${TEMPDIR}/${input}.words"

    tail +2 "${TEMPDIR}/${input}.words" > "${TEMPDIR}/${input}.nextwords"
    tail +2 "${TEMPDIR}/${input}.words" > "${TEMPDIR}/${input}.nextwords2"

    paste "${TEMPDIR}/${input}.words" \
          "${TEMPDIR}/${input}.nextwords" \
          "${TEMPDIR}/${input}.nextwords2" |
        sort | uniq -c > "$outfile"

    rm -rf "${TEMPDIR}"
}
export -f pure_func

for input in $(ls "$IN" | head -n "$ENTRIES"); do
    infile="$IN/$input"
    outfile="$OUT/${input}.trigrams"
    pure_func "$input" "$infile" "$outfile" &
done

wait
