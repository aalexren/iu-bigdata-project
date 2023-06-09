\c project;

CREATE TABLE IF NOT EXISTS application_data (
    SK_ID_CURR BIGINT PRIMARY KEY,
    TARGET BIGINT,
    NAME_CONTRACT_TYPE TEXT,
    CODE_GENDER TEXT,
    FLAG_OWN_CAR TEXT,
    FLAG_OWN_REALTY TEXT,
    CNT_CHILDREN BIGINT,
    AMT_INCOME_TOTAL DOUBLE PRECISION,
    AMT_CREDIT DOUBLE PRECISION,
    AMT_ANNUITY DOUBLE PRECISION,
    AMT_GOODS_PRICE DOUBLE PRECISION,
    NAME_TYPE_SUITE TEXT,
    NAME_INCOME_TYPE TEXT,
    NAME_EDUCATION_TYPE TEXT,
    NAME_FAMILY_STATUS TEXT,
    NAME_HOUSING_TYPE TEXT,
    REGION_POPULATION_RELATIVE DOUBLE PRECISION,
    DAYS_BIRTH BIGINT,
    DAYS_EMPLOYED BIGINT,
    DAYS_REGISTRATION DOUBLE PRECISION,
    DAYS_ID_PUBLISH BIGINT,
    OWN_CAR_AGE DOUBLE PRECISION,
    FLAG_MOBIL BIGINT,
    FLAG_EMP_PHONE BIGINT,
    FLAG_WORK_PHONE BIGINT,
    FLAG_CONT_MOBILE BIGINT,
    FLAG_PHONE BIGINT,
    FLAG_EMAIL BIGINT,
    OCCUPATION_TYPE TEXT,
    CNT_FAM_MEMBERS DOUBLE PRECISION,
    REGION_RATING_CLIENT BIGINT,
    REGION_RATING_CLIENT_W_CITY BIGINT,
    WEEKDAY_APPR_PROCESS_START TEXT,
    HOUR_APPR_PROCESS_START BIGINT,
    REG_REGION_NOT_LIVE_REGION BIGINT,
    REG_REGION_NOT_WORK_REGION BIGINT,
    LIVE_REGION_NOT_WORK_REGION BIGINT,
    REG_CITY_NOT_LIVE_CITY BIGINT,
    REG_CITY_NOT_WORK_CITY BIGINT,
    LIVE_CITY_NOT_WORK_CITY BIGINT,
    ORGANIZATION_TYPE TEXT,
    EXT_SOURCE_1 DOUBLE PRECISION,
    EXT_SOURCE_2 DOUBLE PRECISION,
    EXT_SOURCE_3 DOUBLE PRECISION,
    APARTMENTS_AVG DOUBLE PRECISION,
    BASEMENTAREA_AVG DOUBLE PRECISION,
    YEARS_BEGINEXPLUATATION_AVG DOUBLE PRECISION,
    YEARS_BUILD_AVG DOUBLE PRECISION,
    COMMONAREA_AVG DOUBLE PRECISION,
    ELEVATORS_AVG DOUBLE PRECISION,
    ENTRANCES_AVG DOUBLE PRECISION,
    FLOORSMAX_AVG DOUBLE PRECISION,
    FLOORSMIN_AVG DOUBLE PRECISION,
    LANDAREA_AVG DOUBLE PRECISION,
    LIVINGAPARTMENTS_AVG DOUBLE PRECISION,
    LIVINGAREA_AVG DOUBLE PRECISION,
    NONLIVINGAPARTMENTS_AVG DOUBLE PRECISION,
    NONLIVINGAREA_AVG DOUBLE PRECISION,
    APARTMENTS_MODE DOUBLE PRECISION,
    BASEMENTAREA_MODE DOUBLE PRECISION,
    YEARS_BEGINEXPLUATATION_MODE DOUBLE PRECISION,
    YEARS_BUILD_MODE DOUBLE PRECISION,
    COMMONAREA_MODE DOUBLE PRECISION,
    ELEVATORS_MODE DOUBLE PRECISION,
    ENTRANCES_MODE DOUBLE PRECISION,
    FLOORSMAX_MODE DOUBLE PRECISION,
    FLOORSMIN_MODE DOUBLE PRECISION,
    LANDAREA_MODE DOUBLE PRECISION,
    LIVINGAPARTMENTS_MODE DOUBLE PRECISION,
    LIVINGAREA_MODE DOUBLE PRECISION,
    NONLIVINGAPARTMENTS_MODE DOUBLE PRECISION,
    NONLIVINGAREA_MODE DOUBLE PRECISION,
    APARTMENTS_MEDI DOUBLE PRECISION,
    BASEMENTAREA_MEDI DOUBLE PRECISION,
    YEARS_BEGINEXPLUATATION_MEDI DOUBLE PRECISION,
    YEARS_BUILD_MEDI DOUBLE PRECISION,
    COMMONAREA_MEDI DOUBLE PRECISION,
    ELEVATORS_MEDI DOUBLE PRECISION,
    ENTRANCES_MEDI DOUBLE PRECISION,
    FLOORSMAX_MEDI DOUBLE PRECISION,
    FLOORSMIN_MEDI DOUBLE PRECISION,
    LANDAREA_MEDI DOUBLE PRECISION,
    LIVINGAPARTMENTS_MEDI DOUBLE PRECISION,
    LIVINGAREA_MEDI DOUBLE PRECISION,
    NONLIVINGAPARTMENTS_MEDI DOUBLE PRECISION,
    NONLIVINGAREA_MEDI DOUBLE PRECISION,
    FONDKAPREMONT_MODE TEXT,
    HOUSETYPE_MODE TEXT,
    TOTALAREA_MODE DOUBLE PRECISION,
    WALLSMATERIAL_MODE TEXT,
    EMERGENCYSTATE_MODE TEXT,
    OBS_30_CNT_SOCIAL_CIRCLE DOUBLE PRECISION,
    DEF_30_CNT_SOCIAL_CIRCLE DOUBLE PRECISION,
    OBS_60_CNT_SOCIAL_CIRCLE DOUBLE PRECISION,
    DEF_60_CNT_SOCIAL_CIRCLE DOUBLE PRECISION,
    DAYS_LAST_PHONE_CHANGE DOUBLE PRECISION,
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
    AMT_REQ_CREDIT_BUREAU_HOUR DOUBLE PRECISION,
    AMT_REQ_CREDIT_BUREAU_DAY DOUBLE PRECISION,
    AMT_REQ_CREDIT_BUREAU_WEEK DOUBLE PRECISION,
    AMT_REQ_CREDIT_BUREAU_MON DOUBLE PRECISION,
    AMT_REQ_CREDIT_BUREAU_QRT DOUBLE PRECISION,
    AMT_REQ_CREDIT_BUREAU_YEAR DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS previous_application (
    SK_ID_PREV BIGINT,
    SK_ID_CURR BIGINT,
    NAME_CONTRACT_TYPE TEXT,
    AMT_ANNUITY DOUBLE PRECISION,
    AMT_APPLICATION DOUBLE PRECISION,
    AMT_CREDIT DOUBLE PRECISION,
    AMT_DOWN_PAYMENT DOUBLE PRECISION,
    AMT_GOODS_PRICE DOUBLE PRECISION,
    WEEKDAY_APPR_PROCESS_START TEXT,
    HOUR_APPR_PROCESS_START BIGINT,
    FLAG_LAST_APPL_PER_CONTRACT TEXT,
    NFLAG_LAST_APPL_IN_DAY BIGINT,
    RATE_DOWN_PAYMENT DOUBLE PRECISION,
    RATE_INTEREST_PRIMARY DOUBLE PRECISION,
    RATE_INTEREST_PRIVILEGED DOUBLE PRECISION,
    NAME_CASH_LOAN_PURPOSE TEXT,
    NAME_CONTRACT_STATUS TEXT,
    DAYS_DECISION BIGINT,
    NAME_PAYMENT_TYPE TEXT,
    CODE_REJECT_REASON TEXT,
    NAME_TYPE_SUITE TEXT,
    NAME_CLIENT_TYPE TEXT,
    NAME_GOODS_CATEGORY TEXT,
    NAME_PORTFOLIO TEXT,
    NAME_PRODUCT_TYPE TEXT,
    CHANNEL_TYPE TEXT,
    SELLERPLACE_AREA BIGINT,
    NAME_SELLER_INDUSTRY TEXT,
    CNT_PAYMENT DOUBLE PRECISION,
    NAME_YIELD_GROUP TEXT,
    PRODUCT_COMBINATION TEXT,
    DAYS_FIRST_DRAWING DOUBLE PRECISION,
    DAYS_FIRST_DUE DOUBLE PRECISION,
    DAYS_LAST_DUE_1ST_VERSION DOUBLE PRECISION,
    DAYS_LAST_DUE DOUBLE PRECISION,
    DAYS_TERMINATION DOUBLE PRECISION,
    NFLAG_INSURED_ON_APPROVAL DOUBLE PRECISION
);

-- ALTER TABLE previous_application
-- ADD CONSTRAINT fk_prev_app_data
-- FOREIGN KEY (SK_ID_CURR) REFERENCES application_data (SK_ID_CURR);
