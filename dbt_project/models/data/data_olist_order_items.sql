{{
    config(
    materialized = 'table',
    enabled = true
        )
}}

select 
     order_id
    , order_item_id
    , product_id
    , seller_id
    , shipping_limit_date
    , price
    , freight_value
    , (price +  freight_value) as total_value_pedido
from {{ref('rfd_olist_order_items')}}