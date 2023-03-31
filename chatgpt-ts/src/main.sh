#!/usr/bin/env bash

input_file=./data/BD_Temporary.txt
input_file=./data/keys.txt
log_dir=./logs/$(date +%Y%m%d_%H%M%S)
test -d $log_dir || mkdir -p $log_dir

main () {
    cat $input_file | cut -f 1 | head -3 |
    while read line
    do
        #key=$(echo $line | sed "s/&#x27;/'/g" | tr -d '"')
        key=$line
        output_file=$log_dir/$(echo $key | sed 's/ /_/g' | sed "s/'//g").txt
        echo "### $(date): Start: [$key]"
        echo "# Key:$key" | tee $output_file
        ts-node src/index.ts "'$key'" | tee -a $output_file
    done
}

main 