#!/bin/bash
# tag: sort_words_by_num_of_syllables
# set -e

IN=${IN:-$SUITE_DIR/inputs/pg}
OUT=${1:-$SUITE_DIR/outputs/8.1/}
ENTRIES=${ENTRIES:-1000}
mkdir -p "$OUT"

pure_func() {
    input=$1
    infile=$2
    outfile=$3

    TEMPDIR=$(mktemp -d)

    cat > "${TEMPDIR}/${input}.words"

    # Approximate syllables by counting vowels
    tr -sc '[AEIOUaeiou\012]' ' ' < "${TEMPDIR}/${input}.words" |
        awk '{print NF}' > "${TEMPDIR}/${input}.syl"

    paste "${TEMPDIR}/${input}.syl" "${TEMPDIR}/${input}.words" |
        sort -nr | sed 5q > "$outfile"

    rm -rf "${TEMPDIR}"
}
export -f pure_func

for input in $(ls "$IN" | head -n "$ENTRIES"); do
    infile="$IN/$input"
    outfile="$OUT/${input}.out"

    tr -c 'A-Za-z' '[\n*]' < "$infile" |
        grep -v '^\s*$' |
        sort -u |
        pure_func "$input" "$infile" "$outfile" &
done

wait
echo 'done'
