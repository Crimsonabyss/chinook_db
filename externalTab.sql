select count(*) from dbo.preference
where uuid = 'd9b2ec080b5f3d0fd84a4a2a4e1e2d3a';


SELECT SERVERPROPERTY ('IsPolyBaseInstalled') AS IsPolyBaseInstalled;

-- drop MASTER KEY
CREATE MASTER KEY ENCRYPTION BY PASSWORD ='0q61Cb%Z1j08';

CREATE EXTERNAL FILE FORMAT ParquetFileFormat WITH(FORMAT_TYPE = PARQUET);

-- drop DATABASE SCOPED CREDENTIAL AccessAzureInvoices
-- https://digitalecosystem.blob.core.windows.net/prod-snowflake-unload/CONTACT_LIST/CONTACT_LIST_initial.parquet
-- sp=r&st=2022-11-25T03:48:41Z&se=2022-11-25T11:48:41Z&spr=https&sv=2021-06-08&sr=b&sig=yPHWboVC91gWfuIyPzK7yAVUaCV%2Fk6tVnHgFv7qfodI%3D
-- https://digitalecosystem.blob.core.windows.net/prod-snowflake-unload/CONTACT_LIST/CONTACT_LIST_initial.parquet?sp=r&st=2022-11-25T03:48:41Z&se=2022-11-25T11:48:41Z&spr=https&sv=2021-06-08&sr=b&sig=yPHWboVC91gWfuIyPzK7yAVUaCV%2Fk6tVnHgFv7qfodI%3D
CREATE DATABASE SCOPED CREDENTIAL AccessAzureInvoices
WITH
  IDENTITY = 'SHARED ACCESS SIGNATURE',
  SECRET = 'sp=r&st=2022-11-25T03:48:41Z&se=2022-11-25T11:48:41Z&spr=https&sv=2021-06-08&sr=b&sig=yPHWboVC91gWfuIyPzK7yAVUaCV%2Fk6tVnHgFv7qfodI%3D' ;

-- drop EXTERNAL DATA SOURCE prod_snowflake_unload
CREATE EXTERNAL DATA SOURCE prod_snowflake_unload
WITH
  ( LOCATION = 'https://digitalecosystem.blob.core.windows.net/prod-snowflake-unload/',
    CREDENTIAL = AccessAzureInvoices ,
    TYPE = BLOB_STORAGE
  )
;

/*
create external table dbo.ext_tab (
    uuid varchar(500),
    is_subscribed VARCHAR(500),
    contact_value varchar(500),
    contact_type VARCHAR(500)
)
WITH (
    LOCATION = '/CONTACT_LIST/CONTACT_LIST_initial.parquet',
    DATA_SOURCE = prod_snowflake_unload,
    FILE_FORMAT = PARQUET
);

create table dbo.ext_tab (
    uuid varchar(500),
    is_subscribed VARCHAR(500),
    contact_value varchar(500),
    contact_type VARCHAR(500)
);
*/

select * from [preference] p where uuid = '0f84d9562990b85ad3f6d1c7a3928c5e';
select * from preference where reference_value = 'kath@oneconnectglobal.com.au';

select JSON_VALUE(p.preferences, '$.surveys')
from [preference] p where uuid = '0f84d9562990b85ad3f6d1c7a3928c5e';

update [preference]  set preferences = JSON_MODIFY(preferences, '$.surveys', cast(0 as bit)) where uuid = '0f84d9562990b85ad3f6d1c7a3928c5e';
update [preference]  set preferences = JSON_MODIFY(preferences, '$.surveys', cast(0 as bit)) where reference_value = 'gordan.opacic@bgeeng.com';

select cast(1 as bit)


