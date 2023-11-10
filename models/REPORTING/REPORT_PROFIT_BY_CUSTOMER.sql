select 
    customerid,
    customername,
    customersegment,
    customercountry,
    sum(orderprofit) as profit
from {{ ref('STG_ORDERS') }}
GROUP BY
    customerid,
    customername,
    customersegment,
    customercountry
