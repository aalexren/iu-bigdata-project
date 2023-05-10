#!/bin/bash

parentdir=`pwd`

hdfs dfs -rm -r /project/projectdb
hdfs dfs -mkdir /project/projectdb

printf "LOAD DATA TO HIVE\n"
hive -f "$parentdir"/sql/projectdb.hql
printf "SUCCESS!\n\n\n"