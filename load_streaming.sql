CREATE DATABASE ingest_streaming_data;

USE DATABASE ingest_streaming_data;


CREATE OR REPLACE STAGE snowpipe_copy_example_stage url="s3://snowpipe-streaming/transactions";

LIST @snowpipe_copy_example_stage;

CREATE TABLE transactions
(
    Transaction_Date DATE,
    Customer_ID NUMBER,
    Transaction_ID NUMBER,
    Amount NUMBER
);

CREATE OR REPLACE PIPE transaction_pipe
auto_ingest = true
AS COPY INTO transactions FROM @snowpipe_copy_example_stage
file_format = (type = csv field_delimiter = '|' skip_header = 1);

-- es importante tomar el notificatino chanel, es el end point de la cola donde se envia el mensaje:
-- arn:aws:sqs:ap-southeast-2:190206571863:sf-snowpipe-AIDASYSJR6VLWDYZ7K6D3-wOlDSURAE9benvdtB8yI_w
show pipes;
