#!/bin/bash

export PYTHONIOENCODING=utf8;

spark-submit --jars /usr/hdp/current/hive-client/lib/hive-metastore-1.2.1000.2.6.5.0-292.jar,/usr/hdp/current/hive-client/lib/hive-exec-1.2.1000.2.6.5.0-292.jar --packages org.apache.spark:spark-avro_2.12:3.0.3 scripts/model.py

cat output/lr_scores/* >> output/lr_scores.csv
cat output/dt_scores/* >> output/dt_scores.csv