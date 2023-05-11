#!/bin/bash

parentdir=`pwd`

hdfs dfs -rm -r /project/projectdb
hdfs dfs -mkdir /project/projectdb

printf "LOAD DATA TO HIVE\n"
hive -f "$parentdir"/sql/create_database.hql
hive -f "$parentdir"/sql/partition_tables.hql
printf "SUCCESS!\n\n\n"