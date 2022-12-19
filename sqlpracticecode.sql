-- 1. For each order, list the order number and order date 
-- along with the number and name of the customer that placed the order.

Select Order_num, Order_date, orders.customer_num, customer.customer_name
From Orders, Customer
Where orders.customer_num = customer.customer_num




-- 4. Use the IN operator to find the number and name of each customer 
-- that placed an order on October 15, 2015.

Select customer.CUSTOMER_NUM, CUSTOMER_NAME
From CUSTOMER
WHERE CUSTOMER.CUSTOMER_NUM IN
(Select ORDERS.CUSTOMER_NUM 
From ORDERS
WHERE ORDER_DATE = '2015-10-15'
)

Select *
From Orders



-- 7. For each order, list the order number, order date, 
-- item number, description, and category for each item that makes up the order.

### ORDERS -->  ORDER LINE --> ITEM

Select ORDERS.ORDER_NUM, ORDERS.ORDER_DATE, ITEM.ITEM_NUM, DESCRIPTION, CATEGORY
From intro2sql.ORDERS, intro2sql.ITEM
WHERE 
EXISTS
(Select *
From intro2sql.ORDER_LINE
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND
EXISTS
	(Select *
	From intro2sql.ITEM
	WHERE ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
	)
)



-- 11. Find the number and name of each customer 
-- that currently has an order on file for a Rocking Horse.

# ITEM.ITEM_NUM --> ORDER_LINE.ITEM_NUM | ORDER_LINE.ORDER_NUM, CUSTOMER_NUM --> CUSTOMER.ORDER_NUM

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE CUSTOMER_NUM IN
	(SELECT CUSTOMER_NUM
	FROM ORDERS
	WHERE ORDER_NUM IN
		(SELECT ORDER_NUM
		FROM ORDER_LINE
		WHERE ITEM_NUM IN
			(SELECT ITEM_NUM
			FROM ITEM
			WHERE DESCRIPTION = "ROCKING HORSE"
			)
		)
	)


-- 12. List the item number, description, and category 
-- for each pair of items that are in the same category. 
-- -- (For example, one such pair would be item CD33 and item DL51, 
-- -- because the category for both items is TOY.)

#JOINING A TABLE TO ITSELF PG 143 (163)
# F = first ; S = second

SELECT F.ITEM_NUM, F.DESCRIPTION, F.CATEGORY, S.ITEM_NUM, S.DESCRIPTION, S.CATEGORY
FROM ITEM F, ITEM S
WHERE F.CATEGORY = S.CATEGORY
AND F.ITEM_NUM < S.ITEM_NUM
ORDER BY F.CATEGORY


