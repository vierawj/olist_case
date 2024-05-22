{{
    config(
    materialized = 'table',
    enabled = true
        )
}}

select 
    *
from {{ref('dataset_product_category_name_translation')}}
