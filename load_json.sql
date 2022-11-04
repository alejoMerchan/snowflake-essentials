CREATE DATABASE ingest_data;

use database ingest_data;

CREATE TABLE organizations_json_raw (
    json_data_raw VARIANT
);

-- Se crea una referencia al buket
CREATE OR REPLACE STAGE json_example_stage url='s3://snowflake-essentials/json_data';

-- se lista el contenido del stage
LIST @json_example_stage;

COPY INTO organizations_json_raw
    FROM @json_example_stage/example_json_file.json
    file_format = (type = json);
    
SELECT * FROM organizations_json_raw;

-- forma de acceder al json
SELECT
    json_data_raw:data_set,
    json_data_raw:extract_date
FROM organizations_json_raw;


-- funciones JSON en SF
SELECT
    value:name::String,
    value:state::String,
    value:org_code::String,
    json_data_raw:extract_date
FROM
    organizations_json_raw
    , lateral flatten(input => json_data_raw:organisations);


-- forma 1 de crear una tabla apartir de un json
CREATE OR REPLACE TABLE organisations_ctas AS
SELECT
    VALUE:name::String as org_name,
    VALUE:state::String as state,
    VALUE:org_code::String as org_code,
    json_data_raw:extract_date as extract_date
FROM
    organizations_json_raw
    , lateral flatten(input => json_data_raw:organisations);


select * from organisations_ctas;

-- forma 2 de crear una tabla con informacion de un json
CREATE TABLE organisations(
    org_name STRING,
    state STRING,
    org_code STRING,
    extract_date DATE
);

INSERT INTO organisations
SELECT
    VALUE:name::String AS org_name,
    VALUE:state::String AS state,
    VALUE:org_code::String AS org_code,
    json_data_raw:extract_date AS extract_date
FROM
    organizations_json_raw
    , lateral flatten(input => json_data_raw:organisations);
    
select * from organisations;




