#!/usr/bin/env bash

# requires
# bash (for associative arrays)
# ripgrep (rg)
# nvim (or replace it with vim)

# Settings
FILES_COMMAND="rg --files"
VERBOSE=1

# Strip away trailing / from our input
left_directory=${1%%/}
right_directory=${2%%/}

usage() {
    echo "$0 <left_directory> <right_directory>"
    echo "Also make sure the two directories exist"
}

if [ -z "$left_directory" ] || [ ! -d "$left_directory" ]; then
    usage
    exit 1
fi

if [ -z "$right_directory" ] || [ ! -d "$right_directory" ]; then
    usage
    exit 1
fi

left_files=$(eval "$FILES_COMMAND $left_directory")
right_files=$(eval "$FILES_COMMAND $right_directory")

declare -A in_left
declare -A in_right
declare -A pairs

for file in $left_files; do
    in_left["${file#*/}"]=1
done

for file in $right_files; do
    in_right["${file#*/}"]=1
done

if [ $VERBOSE = 1 ]; then
    echo "MISSING IN RIGHT DIRECTORY"
fi
for file in ${!in_left[@]}; do
    if [ ! ${in_right[$file]} ]; then
        echo "cp $left_directory/$file $right_directory/$file"
        eval "cp $left_directory/$file $right_directory/$file"
    else
        left_hash=$(md5sum $left_directory/$file)
        right_hash=$(md5sum $right_directory/$file)
        if [ ! "${left_hash% *}" = "${right_hash% *}" ]; then
            pairs["$left_directory/$file"]="$right_directory/$file"
        fi
    fi
done

if [ $VERBOSE = 1 ]; then
    echo "MISSING IN LEFT DIRECTORY"
fi
for file in ${!in_right[@]}; do
    if [ ! ${in_left[$file]} ]; then
        echo "cp $right_directory/$file $left_directory/$file"
        eval "cp $right_directory/$file $left_directory/$file"
    else
        left_hash=$(md5sum $left_directory/$file)
        right_hash=$(md5sum $right_directory/$file)
        if [ ! "${left_hash% *}" = "${right_hash% *}" ]; then
            pairs["$left_directory/$file"]="$right_directory/$file"
        fi
    fi
done

if [ $VERBOSE = 1 ]; then
    echo "DIFFERENT"
fi

for file in ${!pairs[@]}; do
    echo "nvim -d $file ${pairs[$file]}"
    eval "nvim -d $file ${pairs[$file]}"
done
