{{
    config(
    materialized = 'table',
    enabled = True
        )


}}

select   
    customer_unique_id
    , customer_zip_code_prefix
    , customer_city
    , customer_state
from {{ref('dataset_olist_customers')}}
