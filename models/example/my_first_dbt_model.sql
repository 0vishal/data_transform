
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/
{{config(materialized='incremental')}}
with source_data as (
select     
    GET(RAW_COLUMN, '@id')::STRING as id,
    GET(XMLGET( RAW_COLUMN, 'author'), '$')::STRING as author,
     XMLGET( RAW_COLUMN, 'title' ):"$"::STRING AS title,
     XMLGET( RAW_COLUMN, 'genre' ):"$"::STRING AS genre,
     XMLGET( RAW_COLUMN, 'price' ):"$"::STRING AS price,
     XMLGET( RAW_COLUMN, 'publish_date' ):"$"::STRING AS publish_date,
     XMLGET( RAW_COLUMN, 'description' ):"$"::STRING AS description

from 
    {{source('singapore_stage','book_data')}} 
)

select * from source_data
/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
