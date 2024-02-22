SELECT * FROM walmart.w_sales;
Select time, (CASE 
when 'time' between "00:00:00" and "12:00:00" then "Morning"
when 'time' between "12:01:00" and "16:00:00" then "Afternoon"
else "evening"
end) AS time_of_date from walmart.w_sales;

------ # Time_of_Day

SELECT  date,  (Select CASE 
when 'time' between "00:00:00" and "12:00:00" then "Morning"
when 'time' between "12:01:00" and "16:00:00" then "Afternoon"
else "evening"
end  AS TIMEs FROM walmart.w_sales) FROM walmart.w_sales;


alter table walmart.w_sales add column time_of_day varchar(20);
SELECT * FROM walmart.w_sales;
UPDATE walmart.w_sales
SET  time_of_day = (CASE 
when 'time' between "00:00:00" and "12:00:00" then "Morning"
when 'time' between "12:01:00" and "16:00:00" then "Afternoon"
else "evening"
end);
#Day_name

select date, dayname(date) from walmart.w_sales;
Alter table  walmart.w_sales add column day_name varchar(10);
update walmart.w_sales SET day_name = dayname(date);

SELECT * FROM walmart.w_sales;

# Month_name

select date, monthname(date) from walmart.w_sales;
Alter table  walmart.w_sales add column month_name varchar(10);
update walmart.w_sales SET month_name = monthname(date);


----- Generic Questions
--- Q1. How many unique cities does the data have?


SELECT distinct City FROM walmart.w_sales;

---- Q2. In which city is each branch?
SELECT Distinct City, Branch FROM walmart.w_sales;

----- Product
----- 1. How many unique product lines does the data have?
Select COUNT(Distinct Product_line) From walmart.w_sales;

----- 2. What is the most common payment method?

Select  Payment, count(Payment) From walmart.w_sales
Group by Payment
Limit 1;

----- Q3. What is the most selling product line?

Select  Product_line, count(Product_line) As cnt_product_line From walmart.w_sales
Group by Product_line
order by cnt_product_line desc
Limit 1;

----- Q4. What is the total revenue by month?

Select month_name, Round(sum(Total), 2) As Total_Revenue From walmart.w_sales
Group by month_name 
order by Total_Revenue desc;

--- Q5. What month had the largest COGS? 
Select month_name, Round(sum(COGS),2) As Total_COGS From walmart.w_sales
Group by month_name 
order by Total_COGS desc
Limit 1;

----- Q6. What product line had the largest revenue?  

Select Product_line, Round(sum(Total), 2) As Total_Revenue_Product_line From walmart.w_sales
Group by Product_line 
order by Total_Revenue_Product_line  desc
Limit 1 ;

----- Q7. What is the city with the largest revenue?

Select City, Round(sum(Total), 2) As Total_Revenue From walmart.w_sales
Group by City 
order by Total_Revenue desc
Limit 1 ;

----- Q8. What product line had the largest VAT?

Select Product_line, Round(AVG(VAT), 2) As Avg_VAT From walmart.w_sales
Group by Product_line 
order by Avg_VAT   desc
Limit 1 ;

----- Q9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales 

SELECT * FROM walmart.w_sales;
Select Avg(Quantity) AS 'average sales' From walmart.w_sales;
Select Product_line,
(CASE
When Avg(Quantity) > 5.51 then "Good"
Else "Bad" 
End )As remarks From walmart.w_sales
Group By Product_line;


----- Q10. Which branch sold more products than average product sold? 

select Branch, SUM(Quantity) From walmart.w_sales
Group by Branch
Having SUM(Quantity)> (Select Avg(Quantity) From walmart.w_sales);

-------- Q11.What is the most common product line by gender? 

Select Gender,Product_line, SUM(Quantity) AS Total_Quantity From walmart.w_sales
Group by Gender,Product_line
Order By Total_Quantity desc;

--------- Q12.What is the average rating of each product line?

Select Product_line, Round(Avg(Rating), 2) AS Avg_Rating From walmart.w_sales
Group by Product_line
Order By Avg_Rating desc;
-----      #SALES#
-----  Q1. Number of sales made in each time of the day per weekday.
Select time_of_day, count(*) AS Total_Sales From walmart.w_sales
Where day_name = 'Monday'
group by time_of_day 
Order By Total_Sales desc;
SELECT * FROM walmart.w_sales;


----- Q2. Which of the customer types brings the most revenue? 

Select   customer_type, Round(SUM(Total), 2) AS Revenue From walmart.w_sales
Group By  customer_type
Order By  Revenue desc
Limit 1;

-----  Q3. Which city has the largest tax percent/ VAT (Value Added Tax)? 

Select City,  Round(Avg(VAT),2) AS Tax FROM walmart.w_sales
Group by City
Order By Tax desc
Limit 1 ;

-----  Q4.Which customer type pays the most in VAT?

Select Customer_type,  Round(Avg(VAT),2) AS Tax FROM walmart.w_sales
Group by Customer_type
Order By Tax desc
Limit 1 ;

-------------------------------# Customer#--------------------
----- Q1.How many unique customer types does the data have?

Select COUNT(Distinct Customer_type) FROM walmart.w_sales;

-------- Q2. How many unique payment methods does the data have? 

Select COUNT(distinct Payment) AS unique_payment_methods FROM walmart.w_sales;

----- Q3. What is the most common customer type?

SELECT Customer_type, count(Customer_type) AS most_Common FROM walmart.w_sales
Group By Customer_type
order By most_Common desc
Limit 1;

-----  Q4. Which customer type buys the most? 

Select   customer_type, Round(SUM(Total), 2) AS Revenue From walmart.w_sales
Group By  customer_type
Order By  Revenue desc
limit 1;

----- Q5.What is the gender of most of the customers?
SELECT * FROM walmart.w_sales;
Select Gender, COUNT(Customer_type) As Count_Customer FROM walmart.w_sales
Group By Gender
order By Count_Customer desc
limit 1;

-------- Q6 What is the gender distribution per branch?

Select  gender, Count(*) As T1 FROM walmart.w_sales
Where Branch = 'A'
Group by gender 
order by T1 desc;

Select  gender, Count(*) As T1 FROM walmart.w_sales
Where Branch = 'B'
Group by gender 
order by T1 desc;

Select  gender, Count(*) As T1 FROM walmart.w_sales
Where Branch = 'C'
Group by gender 
order by T1 desc;  


Q7. Which time of the day do customers give most ratings? 
SELECT time_of_day FROM walmart.w_sales;
Select   time_of_day, round(Avg(Rating),2) AS T2 From walmart.w_sales
Group By  time_of_day
Order By T2 desc;
limit 1;
---- Q8. Which time of the day do customers give most ratings per branch? 

Select   time_of_day, branch, round(Avg(Rating),2) AS T2 From walmart.w_sales
Group By  time_of_day, Branch
Order By branch ASC ;

---- Q9. Which day for the week has the best avg ratings? 
Select * from   walmart.w_sales;

Select day_name, Round(Avg(Rating),2) As   Mark_Rating from   walmart.w_sales
Group by day_name
order By Mark_Rating desc
;
---------  Q10.Which day of the week has the best average ratings per branch?
Select day_name, Branch, Round(Avg(Rating),2) As   Mark_Rating from   walmart.w_sales
Group by Branch, day_name
order By Mark_Rating desc;


Q10.Which day of the week has the best average ratings per branch?

Select day_name, Branch, COUNT(day_name) As   Mark_Rating from   walmart.w_sales
Group by Branch, day_name
order By Mark_Rating desc
Limit 5;



