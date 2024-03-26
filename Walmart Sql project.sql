Create database if not exists salesdatawalmart;
-- create a database
Create Table if not exists sales(
invoice_id varchar(30) not null primary key,
branch varchar(5) not null,
city varchar(30) not null,
customer_type Varchar(30) not null,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_price Decimal(10,2) not null,
quantity Int not null,
VAT Float (6, 4) Not null,
total Decimal( 12, 4) not null,
date datetime not null,
time time not null,
payment_method varchar(15) not null,
cogs Decimal(10, 2) not null,
gross_margin_pct Float(11, 9) not null,
gross_income decimal (12, 4) not null,
rating Float (2,1)
);

-- ---------------------------------------------------- Feature engineering--------------
-- time of day
SELECT 
    time,
    CASE 
        WHEN time between '00:00:00' and '12:00:00' THEN 'Morning'
        WHEN time between '12:01:00' and '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END as time_of_date
FROM sales;

alter table sales drop column time_of_day; 

Alter table sales add column time_of_day Varchar(20);

update sales 
set time_of_day = (
Case 
      When time between "00:00:00" and "12:00:00" then "Morning"
      When time between "12:01:00" and "16:00:00" then "Afternoon"
      Else "Evening"
      End 
); 
-- ------ day name
Select
      date, dayname(date) as day_name
      from sales;

Alter table sales add column day_name varchar(10);

Update sales 
set day_name = dayname(date);
-- ------------------------ month_name
select 
date,
monthname(date)
from sales;

alter table sales add column  month_name  varchar(10);

Update sales 
set month_name = monthname(date);
-- ------------------------------------------------------------Generic------------------------
-- -------------------------------- exploratory data analysis
-- ------How many unique cities does the data have?
Select 
     distinct city
     from sales;
-- --- In which city is each branch?
Select 
     distinct branch
     from sales;     

Select
distinct city,
branch
from sales;
-- ---------- -----------------------------------------------------Product
-- ----------------------How many unique product lines does the data have?------------
Select 
count(distinct product_line)
from sales;
-- What is the most common payment method?
Select
payment_method,
     count(payment_method) as cnt
       From sales
       group by payment_method
       order by cnt desc;
-- -----------------What is the most selling product line?
Select
product_line,
     count(product_line) as cnt
       From sales
       group by product_line
       order by cnt desc;
-- What is the total revenue by month?
Select
month_name as month,
sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc;
-- What month had the largest cogs?
select 
    month_name as month,
    sum(cogs) as cogs
    from sales
    group by month_name
    order by cogs desc;
-- What product line has the largest revenue?
Select
product_line,
sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc; 
-- What is the city with the largest revenue?
Select
branch,
city,
sum(total) as total_revenue
from sales
group by city, branch
order by total_revenue desc; 
-- What product line had the largest VAT?
Select
product_line,
avg(VAT) as avg_tax
from sales
group by product_line
order by avg_tax desc;
-- Which brand sold more products than average product sold?
Select
branch,
sum(quantity) as qty
from sales 
group by branch
having sum(quantity) > (select avg (quantity) from sales);
-- what is the most common product line by gender?
Select
     gender,
     product_line,
     count(gender) as total_cnt
     from sales 
     group by gender, product_line
     order by total_cnt desc;
-- What is the average rating of each product line?
select
round(avg(rating), 2) as avg_rating,
product_line
from sales
group by product_line
order by avg_rating desc;
-- ==========================================================================================================================
-- ==============Sales===========================================
-- Number of sales made in each time of the day per weekday?
Select
time_of_day,
count(*) as total_sales
from sales
where day_name = "Monday" -- plug in a day of the week 
group by time_of_day
Order by total_sales desc;
-- Which of the customer types brings the most revenue?
Select 
customer_type,
sum(total) as total_rev
from sales
Group by customer_type
order by total_rev DESC;
-- Which city has the largest tax percent/VAT(value added Tax)?
Select
city,
avg(VAT) as VAT
from sales
group by city
Order by VAT desc; 
-- Which customer type pays the most in VAT?
Select
customer_type,
avg(VAT) as VAT
from sales
group by customer_type
Order by VAT desc; 
-- ==========================================================================
-- ----------------------- Customers-----------
-- How many unique customer types does the data have?
Select
distinct customer_type
from sales;
-- How many unique payment methods does the data have?
Select
distinct payment_method
from sales;
-- Which customer type buys the most?
Select
customer_type,
count(*) as cstm_cnt
from sales
group by customer_type
order by cstm_cnt desc;
-- What is the gender of most of the customers?
Select 
gender,
count(*) as gender_cnt
from sales 
group by gender
order by gender_cnt desc;
-- What is the gender distrubution per branch?
Select 
gender,
count(*) as gender_cnt
from sales 
where branch = "C"
group by gender
order by gender_cnt desc;
-- Which time of the day do customer give most ratings?
Select
time_of_day,
avg(rating) as avg_rating
from sales 
group by time_of_day
order by avg_rating desc;
-- Which time of the day do customers give mst ratings per branch?
Select
time_of_day,
avg(rating) as avg_rating
from sales 
where branch = "C"  -- input either a,b,c
group by time_of_day
order by avg_rating desc;
-- Which day of the week has the best avg ratings?
select
day_name,
avg(rating) as avg_rating
from sales
group by day_name
order by avg_rating desc;
-- Which day of the week has the best average ratings per branch?
select
day_name,
avg(rating) as avg_rating
from sales
where branch = "A" -- input either branch a,b,c 
group by day_name
order by avg_rating desc;
-- =============================================================================================
-- -----------------------Additional analysis(financial) ----------
Select * from sales;
-- What is the average unit price of each product_line?
select
product_line,
avg(unit_price) as unt_price
from sales
group by product_line
order by unt_price desc;
-- How does the pricing and quantity of a specific product or category within sales contribute to the Cost of Goods Sold (COGS)?
Select 
unit_price,
quantity,
unit_price * quantity as cogs
from sales;
-- How do pricing strategies influence Total Gross Sales and Gross Profit for a specific product or category within a given timeframe?
SELECT
    unit_price,
    quantity,
    unit_price * quantity AS cogs,
    0.05 * unit_price * quantity AS VAT,
    (unit_price * quantity) + (0.05 * unit_price * quantity) AS ttl_gs,
    ((unit_price * quantity) + (0.05 * unit_price * quantity)) - (unit_price * quantity) AS gross_profit
FROM
    sales;
-- How does the Gross Margin Percentage vary for a specific product or set of products, given the Unit Price and Quantity sold, taking into account the Cost of Goods Sold (COGS) and Value Added Tax (VAT)?
SELECT
    45.79 AS Unit_Price,
    7 AS Quantity,
    45.79 * 7 AS cog,
    0.05 * (45.79 * 7) AS VAT,
    (0.05 * (45.79 * 7)) + (45.79 * 7) AS Total_gross,
    ((0.05 * (45.79 * 7)) + (45.79 * 7)) - (45.79 * 7) AS Gross_pft,
    (((0.05 * (45.79 * 7)) + (45.79 * 7)) - (45.79 * 7)) / ((0.05 * (45.79 * 7)) + (45.79 * 7)) AS Gross_mg_pct;
