use sales;
select * from sales2015;
select * from sales2016;
describe sales2015;
select sum(OrderQuantity) as sum_OrderQuantity from sales2015;
select avg(OrderQuantity) as avg_OrderQuantity from sales2016;
select * from sales2015;
select str_to_date(OrderDate, "%m-%d-%Y") from sales2015;
select * from sales2015;
select str_to_date(OrderDate, "%m-%d-%Y") from sales2016;
select * from sales2016;
SELECT 
    OrderDate,
    CASE
        WHEN STR_TO_DATE(OrderDate, '%m-%d-%Y') IS NOT NULL THEN STR_TO_DATE(OrderDate, '%m-%d-%Y')
        WHEN STR_TO_DATE(OrderDate, '%m/%d/%Y') IS NOT NULL THEN STR_TO_DATE(OrderDate, '%m/%d/%Y')
        ELSE NULL
    END AS formatted_date
FROM
    sales2016;
    
    set sql_safe_updates=0;
    update sales2015
    set OrderDate = CASE
        WHEN (OrderDate like "%-%-%") and STR_TO_DATE(OrderDate, '%m-%d-%Y') IS NOT NULL THEN STR_TO_DATE(OrderDate, '%m-%d-%Y')
        WHEN (OrderDate like "%/%/%") and STR_TO_DATE(OrderDate, '%m/%d/%Y') IS NOT NULL THEN STR_TO_DATE(OrderDate, '%m/%d/%Y')
        ELSE NULL
    END;
    
    select * from sales2016;
select str_to_date(StockDate, "%m/%d/%Y") from sales2016;
SELECT 
    StockDate,
    CASE
        WHEN STR_TO_DATE(StockDate, '%m-%d-%Y') IS NOT NULL THEN STR_TO_DATE(StockDate, '%m-%d-%Y')
        WHEN STR_TO_DATE(StockDate, '%m/%d/%Y') IS NOT NULL THEN STR_TO_DATE(StockDate, '%m/%d/%Y')
        ELSE NULL
    END AS formatted_date
FROM
    sales2016;
    
    UPDATE sales2016 
SET 
    StockDate = CASE
        WHEN
            (StockDate LIKE '%-%-%')
                AND STR_TO_DATE(StockDate, '%m-%d-%Y') IS NOT NULL
        THEN
            STR_TO_DATE(StockDate, '%m-%d-%Y')
        WHEN
            (StockDate LIKE '%/%/%')
                AND STR_TO_DATE(StockDate, '%m/%d/%Y') IS NOT NULL
        THEN
            STR_TO_DATE(StockDate, '%m/%d/%Y')
        ELSE NULL
    END;
 
 select * from sales2016;
select OrderDate, CustomerKey, ProductKey,
first_value(ProductKey) over(partition by CustomerKey order by OrderDate) as firstproductpurchased
from sales2016;


create view net_order_sales as (
select OrderNumber, sum(OrderQuantity * ProductPrice) as net_sales from sales2016
left join products
on sales2016.ProductKey = products.ProductKey
group by OrderNumber);

with avg_sub_cat_cost as
(
select ProductSubcategoryKey,
avg(ProductCost) as avg_cost from sales2016 as sales
left join products on sales.ProductKey = products.ProductKey
Group by ProductSubCategoryKey
)
 select * from products
 left join avg_sub_cat_cost
 on products.ProductSubCategoryKey = avg_sub_cat_cost.ProductSubCategoryKey;
 
 show indexes from sales2016;
 select * from  sales2016;
 CREATE INDEX idx_sales2016_customer_order ON sales2016 (CustomerKey);
  show indexes from sales2016;
 

    
    
    
    
    
    
    
    


















