#!/bin/bash

inputDir=$1
outputDir=$2

declare -A dirs
declare -A files

i=0
while IFS= read -r dir; do 
    dirs[$i]=$dir
    ((i++))
done < <(find $inputDir -type d)

i=0
for dir in "${dirs[@]}"; do
    while IFS= read -r file; do 
        files[$i]=$file
        ((i++))
    done < <(find $dir -maxdepth 1 -type f)
done

for file in "${files[@]}"; do
    filename=$(basename $file)
    filefull=$outputDir/$filename
    
    i=1
    while [ -f $filefull ]; do
        filefull=$outputDir/"($i)"$filename
        ((i++))
    done

    cp $file $filefull
done
