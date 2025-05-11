#!/bin/bash

# Adapted from: dspinellis/dgsh
# Source file example/word-properties.sh
#!/usr/bin/env sgsh
#
# SYNOPSIS Word properties
# DESCRIPTION
# Read text from the standard input and list words
# containing a two-letter palindrome, words containing
# four consonants, and words longer than 12 characters.
#
# Demonstrates the use of paste as a gather function
#
# Recommended inputs:
# ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/ibiblio/gutenberg/1/3/139/139.txt
# https://ocw.mit.edu/ans7870/6/6.006/s08/lecturenotes/files/t8.shakespeare.txt
#
#  Copyright 2013 Diomidis Spinellis
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

# Consitent sorting across machines

## Initialize the necessary temporary files
file1=$(mktemp)
file2=$(mktemp)
file3=$(mktemp)
file4=$(mktemp)
file5=$(mktemp)

cat $INPUT_FILE > $file1

# Stream input from file and split input one word per line
# Create list of unique words
tr -cs a-zA-Z '\n' < "$file1" |
sort -u > "$file2"

# List two-letter palindromes
sed 's/.*\(.\)\(.\)\2\1.*/p: \1\2-\2\1/;t;g' "$file2" > "$file3"

# List four consecutive consonants
sed -E 's/.*([^aeiouyAEIOUY]{4}).*/c: \1/;t;g' "$file2" > "$file4"

# List length of words longer than 12 characters
awk '{if (length($1) > 12) print "l:", length($1);
	else print ""}' "$file2" > "$file5"

# Paste the four streams side-by-side
# List only words satisfying one or more properties
paste "$file2" "$file3" "$file4" "$file5" | 
fgrep :
