{{
    config(
    materialized = 'table',
    enabled = true
        )
}}

select 
    *
from {{ref('dataset_olist_orders')}}
