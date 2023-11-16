{{
    config(
        materialized='table'
    )
}}
select 
    o.ORDERID,
    o.ORDERDATE,
    o.SHIPDATE,
    o.SHIPMODE,
    o.ORDERSELLINGPRICE - o.ORDERCOSTPRICE AS ORDERPROFIt,
    o.ORDERCOSTPRICE,
    o.ORDERSELLINGPRICE,
    c.CUSTOMERID,
    c.CUSTOMERNAME,
    c.SEGMENT AS CUSTOMERSEGMENT,
    c.COUNTRY AS CUSTOMERCOUNTRY,
    p.PRODUCTID,
    p.CATEGORY AS PRODUCTCATEGORY,
    p.PRODUCTNAME,
    p.SUBCATEGORY AS PRODUCTSUBCATEGORY
 from {{ ref('RAW_ORDERS') }} o
 left join {{ ref('RAW_CUSTOMER') }} c
 on o.customerid = c.customerid
 left join {{ ref('RAW_PRODUCT') }} p
 on o.productid = p.productid
