# E-Commerce Customer Analysis — SQL Case Study

## Project Overview
This project analyzes customer data from Olist, Brazil's largest e-commerce platform,
using SQL to extract business insights from 99,000+ customer records.

## Tools Used
- MySQL
- MySQL Workbench

## Dataset
- Source: [Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- Table used: customers (99,441 rows)
- Columns: customer_id, customer_unique_id, customer_city, customer_state

## Business Questions Answered

### Basic
1. How many total customers are in the dataset?
2. How many unique cities do customers come from?
3. How many unique states are there?
4. How many customers have missing city data?

### Intermediate
5. Top 5 states by number of customers
6. Top 10 cities by number of customers
7. States with less than 100 customers
8. Percentage of customers contributed by each state

### Advanced
9. Rank all states by customer count using window functions
10. Top city per state using RANK() OVER PARTITION BY

## Key Insights
- São Paulo (SP) dominates with the highest customer concentration
- Top 3 states account for over 60% of total customers
- 27 unique states covered across 4,119 unique cities
- No missing/null values found — dataset is clean and reliable

## Skills Demonstrated
- COUNT, DISTINCT, GROUP BY, ORDER BY
- HAVING clause for filtered aggregations
- Subqueries for percentage calculations
- Window functions — RANK(), ROW_NUMBER(), PARTITION BY

## Files
- `olist_customer_analysis.sql` — all 10 queries with comments