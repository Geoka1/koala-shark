#!/bin/bash

# Parallelized script for processing light patterns in input files using background jobs

IN=${IN:-"$SUITE_DIR/inputs/pg"}
OUT=${1:-"$SUITE_DIR/outputs/6_7/"}
ENTRIES=${ENTRIES:-1000}

mkdir -p "$OUT"

process_file() {
    local input="$1"
    local in_dir="$2"
    local out_dir="$3"

    grep -c 'light.*light' <"$in_dir/$input" >"$out_dir/${input}.out0"
    grep -c 'light.*light.*light' <"$in_dir/$input" >"$out_dir/${input}.out1"
    grep 'light.*light' <"$in_dir/$input" | grep -vc 'light.*light.*light' >"$out_dir/${input}.out2"
}

count=0
for input in $(ls "$IN" | head -n "$ENTRIES"); do
    {
        process_file "$input" "$IN" "$OUT" &
        count=$((count + 1))
    }
done

wait
