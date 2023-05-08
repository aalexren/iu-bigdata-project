#!/bin/bash

parent_dir=`pwd` # root of project
data_dir="$parent_dir/data/"
out_dir="$parent_dir/output/"

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

DIR="$parent_dir/data/previous_application"
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

printf "MOVE FILES TO OUTPUT FOLDER\n"
mv "$data_dir/application_data.csv" "$out_dir/application_data.csv"
mv "$data_dir/previous_application.csv" "$out_dir/previous_application.csv"
printf "SUCCESS!\n"
printf "\n\n\n"

printf "PUT FILES TO HDFS\n"
printf "REMOVE project FOLDER\n"
hdfs dfs -rm -r /project
printf "CREATE project FOLDER\n"
hdfs dfs -mkdir /project
printf "REMOVE csv FOLDER\n"
hdfs dfs -mkdir /project/csv
printf "PUT FILES TO csv FOLDER\n"
hdfs dfs -put "$parent_dir"/output/application_data.csv /project/csv/
hdfs dfs -put "$parent_dir/output/previous_application.csv /project/csv/
printf "SUCCESS!\n"
printf "\n\n\n"