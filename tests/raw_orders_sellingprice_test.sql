select sum(ORDERSELLINGPRICE) AS TOTAL,orderid
from {{ ref('RAW_ORDERS') }}
GROUP BY orderid
HAVING TOTAL < 0