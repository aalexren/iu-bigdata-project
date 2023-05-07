#!/bin/bash

parentdir=`pwd`

printf "LOAD DATA TO HIVE\n"
hive -f "$paretndir"/sql/projectdb.hql
printf "SUCCESS!\n\n\n"