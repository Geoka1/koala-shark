#!/bin/bash
# tag: resize image 
# inputs: $1=absolute source directory path with images, $2=destination directory for output images

# mkdir -p $2

# pure_func () {
#      convert -resize 70% "-" "-"
# }
# export -f pure_func

# for i in $1/*;
# do 
#     out="$2/$(basename -- $i)"
#     cat $i | pure_func > $out
# done

mkdir -p "$2"

pure_func() {
    convert -resize 70% "$1" "$2"
}
export -f pure_func

for i in "$1"/*; do
    out="$2/$(basename -- "$i")"
    pure_func "$i" "$out" &
done
wait
