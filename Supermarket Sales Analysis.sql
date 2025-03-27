select * from Supermarket_Sales;

-- 1)Basic Data Exploration

-- Count Total Records
SELECT COUNT(*) AS Total_Records FROM Supermarket_Sales;

-- Check Data Range
SELECT MIN(Date) AS Start_Date, MAX(Date) AS End_Date FROM Supermarket_Sales;

-- Descriptive Statistics
SELECT SUM(Total) AS Total_Revenue,
	   AVG(Total) AS Avg_Sale,
       MAX(Total) AS Max_Sale,
	   MIN(Total) AS Min_Sale
FROM Supermarket_Sales;

-- 1)Sales Analysis
-- Sales Analysis by Branch and City
SELECT Branch, City, COUNT(*) AS Transaction_count,
	   SUM(Total) AS Total_Revenue,
	   AVG(Total) AS Avg_Revenue
FROM Supermarket_Sales
GROUP BY Branch, City
ORDER BY Total_Revenue DESC;

-- Monthly Sales by Branch
SELECT 
    Branch,
    DATEPART(MONTH, Date) AS Month,
    SUM(Total) AS MonthlyRevenue
FROM Supermarket_Sales
GROUP BY Branch, DATEPART(MONTH, Date)
ORDER BY Branch, Month;

-- 3)Product Analysis
-- Top selling product lines
SELECT 
    Product_line,
    SUM(Quantity) AS TotalQuantitySold,
    SUM(Total) AS TotalRevenue,
    AVG(Unit_price) AS AvgUnitPrice
FROM Supermarket_Sales
GROUP BY Product_line
ORDER BY TotalRevenue DESC;

-- Product performance by gender
SELECT 
    Product_line,
    Gender,
    COUNT(*) AS TransactionCount,
    SUM(Total) AS TotalRevenue
FROM Supermarket_Sales
GROUP BY Product_line, Gender
ORDER BY Product_line, TotalRevenue DESC;

-- 4)Customer Analysis
-- Customer type behavior
SELECT 
    Customer_type,
    COUNT(*) AS TransactionCount,
    SUM(Total) AS TotalSpend,
    AVG(Total) AS AvgSpend,
    AVG(Rating) AS AvgRating
FROM Supermarket_Sales
GROUP BY Customer_type;

-- Gender analysis
SELECT 
    Gender,
    COUNT(*) AS TransactionCount,
    SUM(Total) AS TotalSpend,
    AVG(Total) AS AvgSpend,
    AVG(Rating) AS AvgRating
FROM Supermarket_Sales
GROUP BY Gender;

-- 5)Payment Method Analysis
-- Payment method preferences
SELECT 
    Payment,
    COUNT(*) AS TransactionCount,
    SUM(Total) AS TotalAmount,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Supermarket_Sales) AS Percentage
FROM Supermarket_Sales
GROUP BY Payment
ORDER BY TransactionCount DESC;

-- 6)Time Based Analysis
-- Hourly sales pattern
SELECT 
    DATEPART(HOUR, Time) AS HourOfDay,
    COUNT(*) AS TransactionCount,
    SUM(Total) AS TotalRevenue
FROM Supermarket_Sales
GROUP BY DATEPART(HOUR, Time)
ORDER BY HourOfDay;

-- Weekday vs Weekend sales
SELECT 
    CASE WHEN DATEPART(WEEKDAY, Date) IN (1, 7) 
         THEN 'Weekend' ELSE 'Weekday' END AS DayType,
    COUNT(*) AS TransactionCount,
    SUM(Total) AS TotalRevenue,
    AVG(Total) AS AvgTransactionValue
FROM Supermarket_Sales
GROUP BY CASE WHEN DATEPART(WEEKDAY, Date) IN (1, 7) 
              THEN 'Weekend' ELSE 'Weekday' END;

--7)Customer Rating Analysis
-- Rating distribution
SELECT 
    Rating,
    COUNT(*) AS Count
FROM Supermarket_Sales
GROUP BY Rating
ORDER BY Rating;

-- Correlation between transaction value and rating
SELECT 
    CASE 
        WHEN Total < 100 THEN 'Under 100'
        WHEN Total BETWEEN 100 AND 300 THEN '100-300'
        WHEN Total BETWEEN 300 AND 500 THEN '300-500'
        ELSE 'Over 500' 
    END AS TransactionRange,
    AVG(Rating) AS AvgRating,
    COUNT(*) AS TransactionCount
FROM Supermarket_Sales
GROUP BY CASE 
            WHEN Total < 100 THEN 'Under 100'
            WHEN Total BETWEEN 100 AND 300 THEN '100-300'
            WHEN Total BETWEEN 300 AND 500 THEN '300-500'
            ELSE 'Over 500' 
         END
ORDER BY TransactionRange;
  
-- 8)Profitablity Analysis
-- Gross income by product line
SELECT 
    Product_line,
    SUM(gross_income) AS TotalGrossIncome,
    SUM(cogs) AS TotalCOGS,
    (SUM(gross_income) / SUM(cogs)) * 100 AS GrossMarginPercentage
FROM Supermarket_Sales
GROUP BY Product_line
ORDER BY TotalGrossIncome DESC;

-- Gross income by branch
SELECT 
    Branch,
    SUM(gross_income) AS TotalGrossIncome,
    SUM(cogs) AS TotalCOGS,
    AVG(gross_margin_percentage) AS AvgGrossMarginPercentage
FROM Supermarket_Sales
GROUP BY Branch
ORDER BY TotalGrossIncome DESC;

