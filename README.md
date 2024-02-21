# -Walmart-Data-analysis-SQL
Database Description
The Walmart Sales Database is designed to store and analyze sales data from Walmart, one of the world's largest retail chains. The database captures detailed information about each sale, providing insights into product performance, customer behavior, and financial aspects.

Database Name: `salesdatawalmart`

Table: `sales`

- Columns:
  1. `invoice_id` (varchar(30), not null, primary key): Unique identifier for each invoice.
  2. `branch` (varchar(5), not null): Branch code.
  3. `city` (varchar(30), not null): City where the sale occurred.
  4. `customer_type` (varchar(30), not null): Type of customer (e.g., Member, Normal).
  5. `gender` (varchar(10), not null): Gender of the customer.
  6. `product_line` (varchar(100), not null): Type or category of the product.
  7. `unit_price` (Decimal(10,2), not null): Price per unit of the product.
  8. `quantity` (Int, not null): Quantity of products sold.
  9. `VAT` (Float(6, 4), not null): Value Added Tax.
  10. `total` (Decimal(12, 4), not null): Total sales amount.
  11. `date` (datetime, not null): Date of the sale.
  12. `time` (time, not null): Time of the sale.
  13. `payment_method` (varchar(15), not null): Payment method used.
  14. `cogs` (Decimal(10, 2), not null): Cost of Goods Sold.
  15. `gross_margin_pct` (Float(11, 9), not null): Gross Margin Percentage.
  16. `gross_income` (Decimal(12, 4), not null): Gross Income.
  17. `rating` (Float(2,1)): Customer rating.

Feature Engineering

Time of Day
- Added `time_of_day` column indicating Morning, Afternoon, or Evening based on the time.

Day Name
- Added `day_name` column indicating the day of the week based on the date.

Month Name
- Added `month_name` column indicating the month based on the date.

Exploratory Data Analysis

Generic
- Count of unique cities and branches.
- Most common payment method.
- Most selling product line.
- Total revenue by month.
- Month with the largest COGS.
- Product line with the largest revenue.
- City with the largest revenue.
- Product line with the largest VAT.
- Branch with more products sold than average.

Sales
- Number of sales per time of day per weekday.
- Customer type bringing the most revenue.
- City with the largest VAT.
- Customer type paying the most in VAT.

Customers
- Number of unique customer types and payment methods.
- Customer type buying the most.
- Gender distribution of customers.
- Gender distribution per branch.
- Time of day with the most ratings.
- Time of day with the most ratings per branch.
- Day of the week with the best average ratings.
- Day of the week with the best average ratings per branch.

Additional Analysis (Financial)
- Average unit price of each product line.
- Relationship between unit price, quantity, COGS, VAT, total gross sales, and gross profit.
- Variation of Gross Margin Percentage for a specific product.

Note
- Replace placeholders (e.g., `"Monday"`, `"A"`, `"45.79"`) with actual values or parameters as needed.

Readme

Please refer to the following instructions for proper use of the database and understanding of the provided SQL queries:

1. Database Creation:
   - Execute the script to create the `salesdatawalmart` database and the `sales` table.

2. Feature Engineering:
   - Three additional columns (`time_of_day`, `day_name`, `month_name`) are added for further analysis.

3. Exploratory Data Analysis:
   - Queries to explore generic, sales, and customer-related insights.

4. Additional Analysis (Financial):
   - Financial analysis related to unit price, quantity, COGS, VAT, total gross sales, and gross profit.

5. Note:
   - Update placeholders in queries with actual values or parameters before execution.

6. Caution:
   - Ensure the data is accurate and relevant before executing queries in a production environment.

