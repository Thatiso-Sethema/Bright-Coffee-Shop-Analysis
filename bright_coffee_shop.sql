--------------------------------------------------------------------------------------------------------
-- EXPLORATORY ANALYSIS

-- Revenue per transaction 
SELECT transaction_id,
       SUM(transaction_qty*unit_price) AS revenue
FROM case.study.coffee
GROUP BY transaction_id;

-- Total number of sales/transactions made
SELECT COUNT(transaction_id) AS number_of_transactions
FROM case.study.coffee;

--COUNT the number of different shops we have in this data 
SELECT COUNT(DISTINCT store_id) AS number_of_shops
FROM case.study.coffee;

-- To show us the name of the different store locations which is actually 3 different shops
SELECT DISTINCT store_location, store_id
FROM case.study.coffee;

--Revenue by store location 
SELECT store_location,
       SUM(transaction_qty*unit_price) AS revenue
FROM case.study.coffee
GROUP BY store_location;

--What is the earliest time of operation
SELECT MIN(transaction_time) opening_time
FROM case.study.coffee;

-- What is the latest time of operation
SELECT MAX(transaction_time) closing_time
FROM case.study.coffee;

SELECT DAYNAME(transaction_date) AS day_name
FROM case.study.coffee;
-------------------------------------------------------------------------------------------------------------------

SELECT transaction_date,
       DAYNAME(transaction_date) AS day_name,
       CASE 
            WHEN day_name IN ('Sat', 'Sun') THEN 'Weekend'
            ELSE 'Weekday'
       END AS day_classification,
       MONTHNAME(transaction_date) AS month_name,
       transaction_time,
       CASE
            WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
            WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Aftenoon'
            WHEN transaction_time >= '17:00:00' THEN 'Evening'
       END AS time_bucket,
       store_location,
       product_category,
       transaction_qty,
       product_type,
       SUM(unit_price*transaction_qty) AS revenue,
FROM case.study.coffee
GROUP BY product_category,
         product_type,
         transaction_qty,
         store_location,
         transaction_date,
         time_bucket,
         transaction_time;
