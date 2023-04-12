#!/bin/bash

parent_dir=`pwd`
data_dir="$parent_dir/data/"

printf "PREPARE DATA FILES\n\n\n"

printf "INSTALL PYTHON REQUIREMENTS\n"
pip install -r requirements.txt
printf "SUCCESS!\n\n\n"

DIR="$parent_dir/data/application_data"
FILE="$DIR.csv"
if test -f "$FILE"; then
    printf "$FILE EXISTS!\n"
    printf "REMOVE $FILE!\n"
    rm -f $FILE
    printf "SUCCESS!\n"
fi
python "$parent_dir/scripts/data/load.py" $data_dir $DIR
printf "\n\n\n"

DIR="$parent_dir/data/application_data"
FILE="$DIR.csv"
if test -f "$FILE"; then
    printf "$FILE EXISTS!\n"
    printf "REMOVE $FILE!\n"
    rm -f $FILE
    printf "SUCCESS!\n"
fi
python "$parent_dir/scripts/data/load.py" $data_dir $DIR
printf "\n\n\n"

printf "REMOVE UNCONSTRAINED DATA\n"
python "$parent_dir/scripts/data/preprocess.py" $data_dir
printf "SUCCESS!\n"
printf "\n\n\n"