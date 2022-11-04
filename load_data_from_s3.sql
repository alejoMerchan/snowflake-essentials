create or replace stage my_s3_stage url='s3://snowflake-essentials/';

copy into OUR_FIRST_TABLE from s3://snowflake-essentials/our_first_table_data.csv
file_format = (type = csv field_delimiter = '|' skip_header = 1);

select * from our_first_table;