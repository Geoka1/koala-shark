#!/bin/bash
# tag: compare_exodus_genesis.sh
# set -e

IN=${IN:-$SUITE_DIR/inputs/pg}
INPUT2=${INPUT2:-$SUITE_DIR/inputs/exodus}
OUT=${1:-$SUITE_DIR/outputs/8.3_3/}
ENTRIES=${ENTRIES:-1000}
mkdir -p "$OUT"

pure_func() {
    input=$1
    input2=$2
    infile=$3
    outfile=$4

    TEMPDIR=$(mktemp -d)

    cat > "${TEMPDIR}/${input}1.types"

    tr -sc '[A-Z][a-z]' '[\012*]' < "$input2" | sort -u > "${TEMPDIR}/${input}2.types"

    sort "${TEMPDIR}/${input}1.types" \
         "${TEMPDIR}/${input}2.types" \
         "${TEMPDIR}/${input}2.types" |
         uniq -c | head > "$outfile"

    rm -rf "${TEMPDIR}"
}
export -f pure_func

for input in $(ls "$IN" | head -n "$ENTRIES"); do
    infile="$IN/$input"
    outfile="$OUT/${input}.out"

    tr -c 'A-Za-z' '[\n*]' < "$infile" |
        grep -v '^\s*$' |
        sort -u |
        pure_func "$input" "$INPUT2" "$infile" "$outfile" &
done

wait
echo 'done'
