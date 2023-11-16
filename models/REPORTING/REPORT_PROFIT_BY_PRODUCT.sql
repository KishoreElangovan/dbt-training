select
    productid,
    productname,
    productcategory,
    productsubcategory,
    sum(orderprofit) as profit
from {{ ref('STG_ORDERS') }}
GROUP BY 
    productid,
    productname,
    productcategory,
    productsubcategory