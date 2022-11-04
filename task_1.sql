CREATE TABLE CUSTOMERS(
    ID STRING,
    NAME STRING,
    ADDRESS STRING,
    CITY STRING,
    POSTCODE NUMBER,
    STATE STRING,
    COMPANY STRING,
    CONTACT STRING
)

create or replace stage my_s3_stage url='s3://snowflake-essentials/';

copy into CUSTOMERS from s3://snowflake-essentials/customer.csv
file_format = (type = csv field_delimiter = '|' skip_header = 1);

select count(*) from CUSTOMERS;