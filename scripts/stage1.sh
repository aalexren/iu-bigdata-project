#!/bin/bash

parentdir=`pwd`

FILE="$parentdir"/sql/drop_database.sql
printf "Drop database...\n\n\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"

FILE="$parentdir"/sql/create_database.sql
printf "Create database...\n\n\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"

FILE="$parentdir"/sql/create_tables.sql
printf "Create tables...\n\n\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "Success!\n\n\n"