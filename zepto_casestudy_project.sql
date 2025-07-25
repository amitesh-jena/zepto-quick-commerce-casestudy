drop table if exists zepto;
create table zepto(
sku_id serial primary key,
category varchar(120),
name  varchar(150) not null,
mrp numeric(8,2),
discountPercent numeric(5,2),
availableQuantity integer,
discountSellingPrice numeric(8,2),
weightInGms integer,
outOfStock boolean,
quantity integer
);

-- data exploration
-- count the no of rows

select count(*) from zepto;

-- sample data
select * from zepto
limit 10;

-- null values
select * from zepto
where name is null
or
category is null
or
discountPercent is null
or
availableQuantity is null
or
quantity is null
or
outOfStock is null
or
weightInGms is null
or
discountSellingPrice is null;


-- different product category
select distinct category
from zepto
order by category;

-- products in stock vs out of stock
select outOfStock , count(sku_id)
from zepto
group by outOfStock;

-- product name present multiple times
select name , count(sku_id)as "Number of SKUs"
from zepto
group by name
having count(sku_id) > 1
order by count (sku_id)desc;

-- data cleaning
-- products with price ==0
select * from zepto
where mrp = 0 or discountSellingPrice = 0;
select * from zepto
where mrp = 0;

-- converting paise to rupees
update zepto
set mrp = mrp/100.0,
discountSellingPrice = discountSellingPrice / 100.0;

select mrp, discountSellingPrice from zepto;

-- find the top 10 most discounted producs
select distinct name , mrp , discountPercent
from zepto
order by discountPercent desc
limit 10;
-- what are the products with high mrp but out of stock
select distinct name , mrp
from zepto
where outOfStock = true and mrp >300
order by mrp desc;
-- calculate revenue for each categories
select category,
sum(discountSellingPrice * availableQuantity)as total_revenue
from zepto
group by category
order by total_revenue;
-- find all product where mrp is greater than 500 and discount is less than 10%
select distinct name , mrp,discountPercent
from zepto
where mrp > 500 and discountPercent <10
order by mrp desc, discountPercent desc;
-- identify the top 5 categores offering the highest , average discout percentage
select category,
round(avg(discountPercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;
-- find the price per gram for products above 100g and sorted by the bet value
select distinct name , weightInGms , discountSellingPrice,
round(discountSellingPrice/weightInGms,2) as price_per_gram
from zepto
where weightInGms >=100
order by price_per_gram;
-- group the product into categories like low, medium,bulk
select distinct name, weightInGms,
case when weightInGms < 1000 then 'low'
     when weightInGms < 5000 then 'medium'
	 else 'bulk'
	 end as weight_category
from zepto;	 
-- what is the total inventory weight per category
select category,
sum(weightInGms * availableQuantity)as total_weight
from zepto
group by category
order by total_weight;