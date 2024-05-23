{{
    config(
    materialized = 'table',
    enabled = True
        )


}}

select   
    customer_unique_id as customer_id
    , customer_zip_code_prefix
    , customer_city
    , customer_state
from {{ref('rfd_olist_customers')}}