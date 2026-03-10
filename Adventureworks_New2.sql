use project_adventureswork;
select * from fact_internet_sales_new;
select sum(unitprice) as totalsales	from fact_internet_sales_new;
select sum(ProductStandardCost) as TotalCOst	from fact_internet_sales_new;
select sum(unitprice)- sum(ProductStandardCost) as TotalProfits	from fact_internet_sales_new;


INSERT INTO  fact_internet_sales_new SELECT * FROM factinternetsales;
SELECT COUNT(*) FROM act_internet_sales_new;

DESCRIBE fact_internet_sales_new;
SHOW CREATE TABLE fact_internet_sales_new;
----------------------------------------------------------------------------------------------------------------------------------------
//___Yearwisesales___//

ALTER TABLE DimCustomer
ADD CONSTRAINT PK_DimCustomer PRIMARY KEY (CustomerKey);
ALTER TABLE fact_internet_sales_new
ADD CONSTRAINT FK_Fact_Customer_NEW
FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey);

SELECT 
    d.CalendarYear,
    round(SUM(f.OrderQuantity * f.UnitPrice), 2) AS TotalSales
FROM fact_internet_sales_new f
INNER JOIN DimDate d 
    ON f.OrderDateKey = d.DateKey
WHERE d.CalendarYear IS NOT NULL
GROUP BY d.CalendarYear
ORDER BY d.CalendarYear;
------------------------------------------------------

---------------Top 10 customers----------------------------------------------------

ALTER TABLE dimsalesterritory
ADD CONSTRAINT PK_DimsalestCustomer PRIMARY KEY (SalesTerritoryKey);

ALTER TABLE fact_internet_sales_new
ADD CONSTRAINT FK_Fact_Customer_NEW FOREIGN KEY (SalesTerritoryKey) REFERENCES FK_Fact_Customer_NEW (SalesTerritoryKey);

SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
   round(SUM(f.OrderQuantity * f.UnitPrice), 2) AS TotalSales
FROM fact_internet_sales_new f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSales DESC
LIMIT 10;
