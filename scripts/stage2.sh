#!/bin/bash

parentdir=`pwd`

printf "LOAD DATA TO HIVE\n"
hive -f "$parentdir"/sql/projectdb.hql
printf "SUCCESS!\n\n\n"