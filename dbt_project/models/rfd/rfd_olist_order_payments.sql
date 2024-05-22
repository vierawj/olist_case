{{
    config(
    materialized = 'table',
    enabled = true
        )
}}

select 
    *
from {{ref('dataset_olist_order_payments')}}
