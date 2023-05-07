SET mapreduce.map.output.compress = true;
SET mapreduce.map.output.compress.codec = org.apache.hadoop.io.compress.SnappyCodec;

SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.enforce.bucketing=true;

DROP DATABASE IF EXISTS projectdb CASCADE;

DROP TABLE IF EXISTS application_data_part;
DROP TABLE IF EXISTS previous_application_part;

CREATE DATABASE projectdb;
USE projectdb;

CREATE EXTERNAL TABLE application_data
STORED AS AVRO LOCATION '/project/projectdb/application_data'
TBLPROPERTIES ('avro.schema.url'='/project/avsc/application_data.avsc');

CREATE EXTERNAL TABLE previous_application
STORED AS AVRO LOCATION '/project/projectdb/previous_application'
TBLPROPERTIES ('avro.schema.url'='/project/avsc/previous_application.avsc');

CREATE EXTERNAL TABLE application_data_part (
    SK_ID_CURR BIGINT,
    CNT_CHILDREN BIGINT,
    AMT_INCOME_TOTAL DOUBLE,
    AMT_CREDIT DOUBLE,
    AMT_ANNUITY DOUBLE,
    AMT_GOODS_PRICE DOUBLE,
    NAME_TYPE_SUITE VARCHAR(65535),
    NAME_INCOME_TYPE VARCHAR(65535),
    NAME_EDUCATION_TYPE VARCHAR(65535),
    NAME_FAMILY_STATUS VARCHAR(65535),
    NAME_HOUSING_TYPE VARCHAR(65535),
    REGION_POPULATION_RELATIVE DOUBLE,
    DAYS_BIRTH BIGINT,
    DAYS_EMPLOYED BIGINT,
    DAYS_REGISTRATION DOUBLE,
    DAYS_ID_PUBLISH BIGINT,
    OWN_CAR_AGE DOUBLE,
    FLAG_MOBIL BIGINT,
    FLAG_EMP_PHONE BIGINT,
    FLAG_WORK_PHONE BIGINT,
    FLAG_CONT_MOBILE BIGINT,
    FLAG_PHONE BIGINT,
    FLAG_EMAIL BIGINT,
    OCCUPATION_TYPE VARCHAR(65535),
    CNT_FAM_MEMBERS DOUBLE,
    REGION_RATING_CLIENT BIGINT,
    REGION_RATING_CLIENT_W_CITY BIGINT,
    WEEKDAY_APPR_PROCESS_START VARCHAR(65535),
    HOUR_APPR_PROCESS_START BIGINT,
    REG_REGION_NOT_LIVE_REGION BIGINT,
    REG_REGION_NOT_WORK_REGION BIGINT,
    LIVE_REGION_NOT_WORK_REGION BIGINT,
    REG_CITY_NOT_LIVE_CITY BIGINT,
    REG_CITY_NOT_WORK_CITY BIGINT,
    LIVE_CITY_NOT_WORK_CITY BIGINT,
    ORGANIZATION_TYPE VARCHAR(65535),
    EXT_SOURCE_1 DOUBLE,
    EXT_SOURCE_2 DOUBLE,
    EXT_SOURCE_3 DOUBLE,
    APARTMENTS_AVG DOUBLE,
    BASEMENTAREA_AVG DOUBLE,
    YEARS_BEGINEXPLUATATION_AVG DOUBLE,
    YEARS_BUILD_AVG DOUBLE,
    COMMONAREA_AVG DOUBLE,
    ELEVATORS_AVG DOUBLE,
    ENTRANCES_AVG DOUBLE,
    FLOORSMAX_AVG DOUBLE,
    FLOORSMIN_AVG DOUBLE,
    LANDAREA_AVG DOUBLE,
    LIVINGAPARTMENTS_AVG DOUBLE,
    LIVINGAREA_AVG DOUBLE,
    NONLIVINGAPARTMENTS_AVG DOUBLE,
    NONLIVINGAREA_AVG DOUBLE,
    APARTMENTS_MODE DOUBLE,
    BASEMENTAREA_MODE DOUBLE,
    YEARS_BEGINEXPLUATATION_MODE DOUBLE,
    YEARS_BUILD_MODE DOUBLE,
    COMMONAREA_MODE DOUBLE,
    ELEVATORS_MODE DOUBLE,
    ENTRANCES_MODE DOUBLE,
    FLOORSMAX_MODE DOUBLE,
    FLOORSMIN_MODE DOUBLE,
    LANDAREA_MODE DOUBLE,
    LIVINGAPARTMENTS_MODE DOUBLE,
    LIVINGAREA_MODE DOUBLE,
    NONLIVINGAPARTMENTS_MODE DOUBLE,
    NONLIVINGAREA_MODE DOUBLE,
    APARTMENTS_MEDI DOUBLE,
    BASEMENTAREA_MEDI DOUBLE,
    YEARS_BEGINEXPLUATATION_MEDI DOUBLE,
    YEARS_BUILD_MEDI DOUBLE,
    COMMONAREA_MEDI DOUBLE,
    ELEVATORS_MEDI DOUBLE,
    ENTRANCES_MEDI DOUBLE,
    FLOORSMAX_MEDI DOUBLE,
    FLOORSMIN_MEDI DOUBLE,
    LANDAREA_MEDI DOUBLE,
    LIVINGAPARTMENTS_MEDI DOUBLE,
    LIVINGAREA_MEDI DOUBLE,
    NONLIVINGAPARTMENTS_MEDI DOUBLE,
    NONLIVINGAREA_MEDI DOUBLE,
    FONDKAPREMONT_MODE VARCHAR(65535),
    HOUSETYPE_MODE VARCHAR(65535),
    TOTALAREA_MODE DOUBLE,
    WALLSMATERIAL_MODE VARCHAR(65535),
    EMERGENCYSTATE_MODE VARCHAR(65535),
    OBS_30_CNT_SOCIAL_CIRCLE DOUBLE,
    DEF_30_CNT_SOCIAL_CIRCLE DOUBLE,
    OBS_60_CNT_SOCIAL_CIRCLE DOUBLE,
    DEF_60_CNT_SOCIAL_CIRCLE DOUBLE,
    DAYS_LAST_PHONE_CHANGE DOUBLE,
    FLAG_DOCUMENT_2 BIGINT,
    FLAG_DOCUMENT_3 BIGINT,
    FLAG_DOCUMENT_4 BIGINT,
    FLAG_DOCUMENT_5 BIGINT,
    FLAG_DOCUMENT_6 BIGINT,
    FLAG_DOCUMENT_7 BIGINT,
    FLAG_DOCUMENT_8 BIGINT,
    FLAG_DOCUMENT_9 BIGINT,
    FLAG_DOCUMENT_10 BIGINT,
    FLAG_DOCUMENT_11 BIGINT,
    FLAG_DOCUMENT_12 BIGINT,
    FLAG_DOCUMENT_13 BIGINT,
    FLAG_DOCUMENT_14 BIGINT,
    FLAG_DOCUMENT_15 BIGINT,
    FLAG_DOCUMENT_16 BIGINT,
    FLAG_DOCUMENT_17 BIGINT,
    FLAG_DOCUMENT_18 BIGINT,
    FLAG_DOCUMENT_19 BIGINT,
    FLAG_DOCUMENT_20 BIGINT,
    FLAG_DOCUMENT_21 BIGINT,
    AMT_REQ_CREDIT_BUREAU_HOUR DOUBLE,
    AMT_REQ_CREDIT_BUREAU_DAY DOUBLE,
    AMT_REQ_CREDIT_BUREAU_WEEK DOUBLE,
    AMT_REQ_CREDIT_BUREAU_MON DOUBLE,
    AMT_REQ_CREDIT_BUREAU_QRT DOUBLE,
    AMT_REQ_CREDIT_BUREAU_YEAR DOUBLE
) 
PARTITIONED BY (
    TARGET BIGINT,
    NAME_CONTRACT_TYPE VARCHAR(65535),
    CODE_GENDER VARCHAR(65535),
    FLAG_OWN_CAR VARCHAR(65535),
    FLAG_OWN_REALTY VARCHAR(65535)
)
CLUSTERED BY (TARGET) INTO 50 BUCKETS
STORED AS AVRO LOCATION '/project/projectdb/application_data_part'
TBLPROPERTIES ('AVRO.COMPRESS'='SNAPPY');

CREATE EXTERNAL TABLE previous_application_part (
    SK_ID_PREV BIGINT,
    SK_ID_CURR BIGINT,
    AMT_ANNUITY DOUBLE,
    AMT_APPLICATION DOUBLE,
    AMT_CREDIT DOUBLE,
    AMT_DOWN_PAYMENT DOUBLE,
    AMT_GOODS_PRICE DOUBLE,
    WEEKDAY_APPR_PROCESS_START VARCHAR(65535),
    HOUR_APPR_PROCESS_START BIGINT,
    FLAG_LAST_APPL_PER_CONTRACT VARCHAR(65535),
    NFLAG_LAST_APPL_IN_DAY BIGINT,
    RATE_DOWN_PAYMENT DOUBLE,
    RATE_INTEREST_PRIMARY DOUBLE,
    RATE_INTEREST_PRIVILEGED DOUBLE,
    NAME_CASH_LOAN_PURPOSE VARCHAR(65535),
    NAME_CONTRACT_STATUS VARCHAR(65535),
    DAYS_DECISION BIGINT,
    NAME_PAYMENT_TYPE VARCHAR(65535),
    CODE_REJECT_REASON VARCHAR(65535),
    NAME_TYPE_SUITE VARCHAR(65535),
    NAME_CLIENT_TYPE VARCHAR(65535),
    NAME_GOODS_CATEGORY VARCHAR(65535),
    NAME_PORTFOLIO VARCHAR(65535),
    NAME_PRODUCT_TYPE VARCHAR(65535),
    CHANNEL_TYPE VARCHAR(65535),
    SELLERPLACE_AREA BIGINT,
    NAME_SELLER_INDUSTRY VARCHAR(65535),
    CNT_PAYMENT DOUBLE,
    NAME_YIELD_GROUP VARCHAR(65535),
    PRODUCT_COMBINATION VARCHAR(65535),
    DAYS_FIRST_DRAWING DOUBLE,
    DAYS_FIRST_DUE DOUBLE,
    DAYS_LAST_DUE_1ST_VERSION DOUBLE,
    DAYS_LAST_DUE DOUBLE,
    DAYS_TERMINATION DOUBLE,
    NFLAG_INSURED_ON_APPROVAL DOUBLE
) 
PARTITIONED BY (
    NAME_CONTRACT_TYPE VARCHAR(65535)
)
CLUSTERED BY (SK_ID_PREV) INTO 50 BUCKETS
STORED AS AVRO LOCATION '/project/projectdb/previous_application_part'
TBLPROPERTIES ('AVRO.COMPRESS'='SNAPPY');

INSERT INTO application_data_part 
PARTITION (
    NAME_CONTRACT_TYPE,
    CODE_GENDER,
    FLAG_OWN_CAR,
    FLAG_OWN_REALTY
) 
SELECT 
    NAME_CONTRACT_TYPE,
    CODE_GENDER,
    FLAG_OWN_CAR,
    FLAG_OWN_REALTY,
    SK_ID_CURR,
    TARGET,
    CNT_CHILDREN,
    AMT_INCOME_TOTAL,
    AMT_CREDIT,
    AMT_ANNUITY,
    AMT_GOODS_PRICE,
    NAME_TYPE_SUITE,
    NAME_INCOME_TYPE,
    NAME_EDUCATION_TYPE,
    NAME_FAMILY_STATUS,
    NAME_HOUSING_TYPE,
    REGION_POPULATION_RELATIVE,
    DAYS_BIRTH,
    DAYS_EMPLOYED,
    DAYS_REGISTRATION,
    DAYS_ID_PUBLISH,
    OWN_CAR_AGE,
    FLAG_MOBIL,
    FLAG_EMP_PHONE,
    FLAG_WORK_PHONE,
    FLAG_CONT_MOBILE,
    FLAG_PHONE,
    FLAG_EMAIL,
    OCCUPATION_TYPE,
    CNT_FAM_MEMBERS,
    REGION_RATING_CLIENT,
    REGION_RATING_CLIENT_W_CITY,
    WEEKDAY_APPR_PROCESS_START,
    HOUR_APPR_PROCESS_START,
    REG_REGION_NOT_LIVE_REGION,
    REG_REGION_NOT_WORK_REGION,
    LIVE_REGION_NOT_WORK_REGION,
    REG_CITY_NOT_LIVE_CITY,
    REG_CITY_NOT_WORK_CITY,
    LIVE_CITY_NOT_WORK_CITY,
    ORGANIZATION_TYPE,
    EXT_SOURCE_1,
    EXT_SOURCE_2,
    EXT_SOURCE_3,
    APARTMENTS_AVG,
    BASEMENTAREA_AVG,
    YEARS_BEGINEXPLUATATION_AVG,
    YEARS_BUILD_AVG,
    COMMONAREA_AVG,
    ELEVATORS_AVG,
    ENTRANCES_AVG,
    FLOORSMAX_AVG,
    FLOORSMIN_AVG,
    LANDAREA_AVG,
    LIVINGAPARTMENTS_AVG,
    LIVINGAREA_AVG,
    NONLIVINGAPARTMENTS_AVG,
    NONLIVINGAREA_AVG,
    APARTMENTS_MODE,
    BASEMENTAREA_MODE,
    YEARS_BEGINEXPLUATATION_MODE,
    YEARS_BUILD_MODE,
    COMMONAREA_MODE,
    ELEVATORS_MODE,
    ENTRANCES_MODE,
    FLOORSMAX_MODE,
    FLOORSMIN_MODE,
    LANDAREA_MODE,
    LIVINGAPARTMENTS_MODE,
    LIVINGAREA_MODE,
    NONLIVINGAPARTMENTS_MODE,
    NONLIVINGAREA_MODE,
    APARTMENTS_MEDI,
    BASEMENTAREA_MEDI,
    YEARS_BEGINEXPLUATATION_MEDI,
    YEARS_BUILD_MEDI,
    COMMONAREA_MEDI,
    ELEVATORS_MEDI,
    ENTRANCES_MEDI,
    FLOORSMAX_MEDI,
    FLOORSMIN_MEDI,
    LANDAREA_MEDI,
    LIVINGAPARTMENTS_MEDI,
    LIVINGAREA_MEDI,
    NONLIVINGAPARTMENTS_MEDI,
    NONLIVINGAREA_MEDI,
    FONDKAPREMONT_MODE,
    HOUSETYPE_MODE,
    TOTALAREA_MODE,
    WALLSMATERIAL_MODE,
    EMERGENCYSTATE_MODE,
    OBS_30_CNT_SOCIAL_CIRCLE,
    DEF_30_CNT_SOCIAL_CIRCLE,
    OBS_60_CNT_SOCIAL_CIRCLE,
    DEF_60_CNT_SOCIAL_CIRCLE,
    DAYS_LAST_PHONE_CHANGE,
    FLAG_DOCUMENT_2,
    FLAG_DOCUMENT_3,
    FLAG_DOCUMENT_4,
    FLAG_DOCUMENT_5,
    FLAG_DOCUMENT_6,
    FLAG_DOCUMENT_7,
    FLAG_DOCUMENT_8,
    FLAG_DOCUMENT_9,
    FLAG_DOCUMENT_10,
    FLAG_DOCUMENT_11,
    FLAG_DOCUMENT_12,
    FLAG_DOCUMENT_13,
    FLAG_DOCUMENT_14,
    FLAG_DOCUMENT_15,
    FLAG_DOCUMENT_16,
    FLAG_DOCUMENT_17,
    FLAG_DOCUMENT_18,
    FLAG_DOCUMENT_19,
    FLAG_DOCUMENT_20,
    FLAG_DOCUMENT_21,
    AMT_REQ_CREDIT_BUREAU_HOUR,
    AMT_REQ_CREDIT_BUREAU_DAY,
    AMT_REQ_CREDIT_BUREAU_WEEK,
    AMT_REQ_CREDIT_BUREAU_MON,
    AMT_REQ_CREDIT_BUREAU_QRT,
    AMT_REQ_CREDIT_BUREAU_YEAR
FROM application_data;

INSERT INTO previous_application_part 
PARTITION (
    NAME_CONTRACT_TYPE
)
SELECT
    NAME_CONTRACT_TYPE,
    SK_ID_PREV,
    SK_ID_CURR,
    AMT_ANNUITY,
    AMT_APPLICATION,
    AMT_CREDIT,
    AMT_DOWN_PAYMENT,
    AMT_GOODS_PRICE,
    WEEKDAY_APPR_PROCESS_START,
    HOUR_APPR_PROCESS_START,
    FLAG_LAST_APPL_PER_CONTRACT,
    NFLAG_LAST_APPL_IN_DAY,
    RATE_DOWN_PAYMENT,
    RATE_INTEREST_PRIMARY,
    RATE_INTEREST_PRIVILEGED,
    NAME_CASH_LOAN_PURPOSE,
    NAME_CONTRACT_STATUS,
    DAYS_DECISION,
    NAME_PAYMENT_TYPE,
    CODE_REJECT_REASON,
    NAME_TYPE_SUITE,
    NAME_CLIENT_TYPE,
    NAME_GOODS_CATEGORY,
    NAME_PORTFOLIO,
    NAME_PRODUCT_TYPE,
    CHANNEL_TYPE,
    SELLERPLACE_AREA,
    NAME_SELLER_INDUSTRY,
    CNT_PAYMENT,
    NAME_YIELD_GROUP,
    PRODUCT_COMBINATION,
    DAYS_FIRST_DRAWING,
    DAYS_FIRST_DUE,
    DAYS_LAST_DUE_1ST_VERSION,
    DAYS_LAST_DUE,
    DAYS_TERMINATION,
    NFLAG_INSURED_ON_APPROVAL
 FROM previous_application;