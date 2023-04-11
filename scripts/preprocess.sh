#!/bin/bash

parentdir=`pwd`

printf "Downloading data files...\n\n\n"

FILE="$parentdir"/data/application_data.csv
if test -f "$FILE"; then
    printf "$FILE exists.\n"
    printf "Remove $FILE.\n"
    rm $FILE
    printf "Done.\n"
fi
printf "$FILE is downloading...\n"
wget application_data.csv -P "$parentdir"/data/ https://media.githubusercontent.com/media/aalexren/iu-bigdata-project/master/data/application_data.csv
printf "Done.\n\n"

FILE="$parentdir"/data/previous_application.csv
if test -f "$FILE"; then
    printf "$FILE exists.\n"
    printf "Remove $FILE.\n"
    rm $FILE
    printf "Done.\n"
fi
printf "$FILE is downloading...\n"
wget previous_application.csv -P "$parentdir"/data/ https://media.githubusercontent.com/media/aalexren/iu-bigdata-project/master/data/previous_application.csv
printf "Done.\n\n"

printf "Downloading complete!\n\n\n"