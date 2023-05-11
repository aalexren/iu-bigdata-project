#!/bin/bash

parentdir=`pwd`

hdfs dfs -rm -r /project/projectdb
hdfs dfs -mkdir /project/projectdb

printf "LOAD DATA TO HIVE\n"
hive -f "$parentdir"/sql/create_database.hql
hive -f "$parentdir"/sql/partition_tables.hql
printf "SUCCESS!\n\n\n"


printf "INSIGHTS\n"
rm -rf "$parentdir"/output/q1
rm -rf "$parentdir"/output/q1.csv
rm -rf "$parentdir"/output/q2
rm -rf "$parentdir"/output/q2.csv
rm -rf "$parentdir"/output/q3
rm -rf "$parentdir"/output/q3.csv
rm -rf "$parentdir"/output/q4
rm -rf "$parentdir"/output/q4.csv
rm -rf "$parentdir"/output/q5
rm -rf "$parentdir"/output/q5.csv
hive -f "$parentdir"/sql/insights.hql
printf "SUCCESS!\n\n\n"