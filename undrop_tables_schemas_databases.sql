CREATE DATABASE PROD;
CREATE SCHEMA CRM;

USE SCHEMA CRM;
CREATE TABLE CUSTOMER AS
SELECT * FROM SFSALESSHARED_SFC_SAMPLES_AWSEUNORTH1_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER
LIMIT 1000;

USE SCHEMA PUBLIC;
CREATE TABLE DATE_DIM AS
SELECT * FROM SFSALESSHARED_SFC_SAMPLES_AWSEUNORTH1_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM;

USE SCHEMA CRM;
DROP TABLE CUSTOMER;

USE SCHEMA CRM;
SELECT * FROM CUSTOMER;


USE SCHEMA CRM;
UNDROP TABLE CUSTOMER;

USE SCHEMA CRM;
SELECT * FROM CUSTOMER;


DROP SCHEMA CRM;
SELECT * FROM TIME_TRAVEL_2.CRM.CUSTOMER;

UNDROP SCHEMA CRM;
SELECT * FROM TIME_TRAVEL_2.CRM.CUSTOMER;

