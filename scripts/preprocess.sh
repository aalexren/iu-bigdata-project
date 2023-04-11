#!/bin/bash

parentdir=`pwd`

printf "Downloading data files...\n\n\n"

FILE="$parentdir"/data/application_data.csv
if test -f "$FILE"; then
    printf "$FILE exists.\n"
    printf "Remove $FILE.\n"
    rm $FILE
    printf "Success!\n"
fi
printf "$FILE is downloading...\n"
wget application_data.csv -P "$parentdir"/data/ https://media.githubusercontent.com/media/aalexren/iu-bigdata-project/master/data/application_data.csv
printf "Success!\n\n"

FILE="$parentdir"/data/previous_application.csv
if test -f "$FILE"; then
    printf "$FILE exists.\n"
    printf "Remove $FILE.\n"
    rm $FILE
    printf "Success!\n"
fi
printf "$FILE is downloading...\n"
wget previous_application.csv -P "$parentdir"/data/ https://media.githubusercontent.com/media/aalexren/iu-bigdata-project/master/data/previous_application.csv
printf "Success!\n\n"

printf "Downloading complete!\n\n\n"

printf "Installing requirements...\n\n\n"
pip install -r requirements.txt
printf "Success!\n\n\n"

FILE="$parentdir"/sql/drop_database.sql
printf "Drop database...\n\n\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"

FILE="$parentdir"/sql/create_database.sql
printf "Create database...\n\n\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"
