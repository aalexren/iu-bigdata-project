#!/bin/bash

parentdir=`pwd`

FILE="$parentdir"/sql/drop_database.sql
printf "Drop database...\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"

FILE="$parentdir"/sql/create_database.sql
printf "Create database...\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"

FILE="$parentdir"/sql/drop_tables.sql
printf "Drop tables...\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"

FILE="$parentdir"/sql/create_tables.sql
printf "Create tables...\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"

printf "Load data from csv files...\n"
printf "Set datetime format...\n"
PGPASSWORD=proven psql -U postgres \
    -d project \
    -c "SET datestyle TO iso, ymd;"
printf "Load application_data.csv...\n"
PGPASSWORD=proven psql -U postgres \
    -d project \
    -c "\COPY application_data FROM "$parentdir"/data/application_data.csv DELIMITER ',' CSV HEADER;"
printf "Load previous_application.csv...\n"
PGPASSWORD=proven psql -U postgres \
    -d project \
    -c "\COPY previous_application FROM "$parentdir"/data/previous_application.csv DELIMITER ',' CSV HEADER;"
printf "Success!\n\n\n"