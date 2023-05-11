DROP DATABASE IF EXISTS projectdb CASCADE;

CREATE DATABASE projectdb;
USE projectdb;

SET hive.exec.compress.output=true;
SET mapreduce.map.output.compress = true;
SET mapreduce.map.output.compress.codec = org.apache.hadoop.io.compress.SnappyCodec;

DROP TABLE IF EXISTS application_data;
DROP TABLE IF EXISTS previous_application;

-- LOAD TABLES TO HIVE
CREATE EXTERNAL TABLE application_data
STORED AS AVRO LOCATION '/project/application_data'
TBLPROPERTIES ('avro.schema.url'='/project/avsc/application_data.avsc');

CREATE EXTERNAL TABLE previous_application
STORED AS AVRO LOCATION '/project/previous_application'
TBLPROPERTIES ('avro.schema.url'='/project/avsc/previous_application.avsc');

-- CHECK EVERYTHING IS LOADED CORRECTLY
SELECT COUNT(1) FROM application_data;
SELECT COUNT(1) FROM previous_application;