select pr.product_id,
       pr.product_title,
       pr.product_price,
       d.details_order_id,
       d.amount,
       c.customer_id,
       c.customer_name,
       c.customer_address,
       c.customer_phone
from lab5.product pr
join lab5.details d on pr.product_id = d.details_product_id
join lab5.customer_order co on co.order_id = d.details_order_id
join lab5.customer c on co.order_customer_link = c.customer_id