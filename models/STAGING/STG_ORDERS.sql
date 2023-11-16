{{
    config(
        materialized='table'
    )
}}
select 
    {{ dbt_utils.generate_surrogate_key( ['o.ORDERID', 'c.CUSTOMERID', 'p.PRODUCTID'] ) }} as ORDERKEY,
    o.ORDERID,
    o.ORDERDATE,
    o.SHIPDATE,
    o.SHIPMODE,
    o.ORDERSELLINGPRICE - o.ORDERCOSTPRICE AS ORDERPROFIt,
    {{ordersmarkup('o.ORDERSELLINGPRICE','o.ORDERCOSTPRICE')}} as ORDERSMARKUP,
    o.ORDERCOSTPRICE,
    o.ORDERSELLINGPRICE,
    c.CUSTOMERID,
    c.CUSTOMERNAME,
    c.SEGMENT AS CUSTOMERSEGMENT,
    c.COUNTRY AS CUSTOMERCOUNTRY,
    p.PRODUCTID,
    p.CATEGORY AS PRODUCTCATEGORY,
    p.PRODUCTNAME,
    p.SUBCATEGORY AS PRODUCTSUBCATEGORY,
    d.delivery_team AS delivery_team
 from {{ ref('RAW_ORDERS') }} o
 left join {{ ref('RAW_CUSTOMER') }} c
 on o.customerid = c.customerid
 left join {{ ref('RAW_PRODUCT') }} p
 on o.productid = p.productid
left join {{ ref('delivery_team') }} d
on o.SHIPMODE = d.SHIPMODE