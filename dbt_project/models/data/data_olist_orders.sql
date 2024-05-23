{{
    config(
    materialized = 'table',
    enabled = True
        )
}}

with cte_table as (
select   
    *     
    , DATE_PART('day' , order_delivered_customer_date::timestamp - order_purchase_timestamp::timestamp) sla_total

    , DATE_PART('day' , order_approved_at::timestamp - order_purchase_timestamp::timestamp) as sla_aprovacao
    , case 
        when order_status = 'delivered' then  DATE_PART('day' , order_estimated_delivery_date::timestamp - order_purchase_timestamp::timestamp ) 
        else null
    end as dias_adiantado
from 
    {{ref('rfd_olist_orders')}}
)
select 
    *
    , case
       when sla_total is null then 'nao_entregue'
        when dias_adiantado > 0 then 'No prazo'
        else 'fora do prazo'
    end as entregas
from cte_table