#!/bin/bash
# tag: reverse_word_match
# set -e

IN=${IN:-$SUITE_DIR/inputs/pg}
OUT=${1:-$SUITE_DIR/outputs/8.3_2/}
ENTRIES=${ENTRIES:-1000}
mkdir -p "$OUT"

pure_func() {
    input=$1
    outfile=$2

    TEMPDIR=$(mktemp -d)

    # Save unique word types
    sort -u > "${TEMPDIR}/${input}.types"

    # Reverse the words
    rev < "${TEMPDIR}/${input}.types" > "${TEMPDIR}/${input}.types.rev"

    # Combine and find words that appear in original and reversed
    sort "${TEMPDIR}/${input}.types" "${TEMPDIR}/${input}.types.rev" |
        uniq -c | awk '$1 >= 2 {print $2}' > "$outfile"

    rm -rf "${TEMPDIR}"
}
export -f pure_func

for input in $(ls "$IN" | head -n "$ENTRIES"); do
    infile="$IN/$input"
    outfile="$OUT/${input}.out"

    tr -c 'A-Za-z' '[\n*]' < "$infile" |
        grep -v '^\s*$' |
        pure_func "$input" "$outfile" &
done

wait
echo 'done'
