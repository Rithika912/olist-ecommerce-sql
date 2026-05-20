CREATE DATABASE olist_ecommerce;
USE olist_ecommerce;

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);

select * from customers;



show variables like 'secure_file_priv'; 



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.5/Uploads/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


set global sql_mode = '';

drop table if exists customers;

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id VARCHAR(100),
    customer_unique_id VARCHAR(100),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.5/Uploads/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select* from customers limit 10;

select* from customers limit 5;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 9.5/Uploads/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


set global local_infile = 1;

show global variables like 'local_infile';

LOAD DATA LOCAL INFILE 'C:/Users/Rithika/Downloads/archive/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


USE olist_ecommerce;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp VARCHAR(50),
    order_approved_at VARCHAR(50),
    order_delivered_carrier_date VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
);

select* from customers;



#1 How many total customers are in the dataset?
select count(*) from customers;

#2 How many unique cities do customers come from?
select count(distinct customer_city ) as total_no_unique
from customers ;

#3 Which are the top 5 states by number of customers?
select customer_state , Count(customer_state) as  count_of_topcustomers 
from customers 
group by customer_state 
order by count_of_topcustomers desc
limit 5;

#4 Which city has the highest number of customers in each state?
SELECT customer_state, 
       customer_city, 
       COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state, customer_city
ORDER BY customer_state, total_customers DESC;

#5 States with less than 100 customers 

SELECT customer_state, 
       COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
HAVING total_customers < 100
ORDER BY total_customers ASC;

#6 Rank states by customer count
SELECT customer_state ,
       COUNT(*) AS total_customers,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS state_rank
FROM customers
GROUP BY customer_state;

#7 Percentage of customers per state
SELECT customer_state,
       COUNT(*) AS total_customers,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers), 2) AS percentage
FROM customers
GROUP BY customer_state
ORDER BY percentage DESC;

#8 States above national average
SELECT customer_state, 
       COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
HAVING total_customers > (
    SELECT AVG(state_count) 
    FROM (
        SELECT COUNT(*) AS state_count 
        FROM customers 
        GROUP BY customer_state
    ) avg_table
)
ORDER BY total_customers DESC; 

#9 Cities that appear in more than one state
SELECT customer_city, 
       COUNT(DISTINCT customer_state) AS state_count
FROM customers
GROUP BY customer_city
HAVING state_count > 1
ORDER BY state_count DESC;

#10 Top 3 cities per state
SELECT customer_state, customer_city, total_customers
FROM (
    SELECT customer_state, customer_city,
           COUNT(*) AS total_customers,
           ROW_NUMBER() OVER (PARTITION BY customer_state 
                              ORDER BY COUNT(*) DESC) AS rn
    FROM customers
    GROUP BY customer_state, customer_city
) ranked
WHERE rn <= 3
ORDER BY customer_state, total_customers DESC;
