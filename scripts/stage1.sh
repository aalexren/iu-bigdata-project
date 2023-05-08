#!/bin/bash

parentdir=`pwd`

FILE="$parentdir"/sql/drop_database.sql
printf "DROP DATABASE\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "SUCCESS!\n\n\n"

FILE="$parentdir"/sql/create_database.sql
printf "CREATE DATABASE...\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "SUCCESS!\n\n\n"

FILE="$parentdir"/sql/drop_tables.sql
printf "DROP TABLES\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "SUCCESS!\n\n\n"

FILE="$parentdir"/sql/create_tables.sql
printf "CREATE TABLES\n"
PGPASSWORD=proven psql -U postgres < $FILE
printf "SUCCESS!\n\n\n"

printf "LOAD DATA FROM CSV FILES\n"
printf "SET DATETIME FORMAT\n"
PGPASSWORD=proven psql -U postgres \
    -d project \
    -c "SET datestyle TO iso, ymd;"
printf "LOAD application_data.csv\n"
PGPASSWORD=proven psql -U postgres \
    -d project \
    -c "\COPY application_data FROM "$parentdir/output/application_data.csv" DELIMITER ',' CSV HEADER;"
printf "LOAD previous_application.csv\n"
PGPASSWORD=proven psql -U postgres \
    -d project \
    -c "\COPY previous_application FROM "$parentdir/output/previous_application.csv" DELIMITER ',' CSV HEADER;"
printf "SUCCESS!\n\n\n"

printf "LOAD DATA TO HDFS BY SQOOP\n"
sqoop import-all-tables \
    -Dmapreduce.job.user.classpath.first=true \
    --connect jdbc:postgresql://localhost/project \
    --username postgres \
    --password proven \
    --warehouse-dir /project \
    --as-avrodatafile \
    --compression-codec=snappy \
    --outdir ./output/avsc \
    --m 1
hdfs dfs -put ./output/avsc /project/avsc
printf "SUCCESS!\n\n\n"