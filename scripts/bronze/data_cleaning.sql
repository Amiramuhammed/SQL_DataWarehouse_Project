-- Quality check
-- check for nulls or duplicates in primary key
select cst_id,count(*) from bronze.crm_cst_info
group by cst_id
having count(*)>1 or cst_id is null

select prd_id,count(*) from bronze.crm_prd_info
group by prd_id 
having count(*)>1 or prd_id is null

--check for unwanted spaces
select cst_lastname from bronze.crm_cst_info
where cst_lastname != TRIM(cst_lastname)

--Data Standrization & Consistency
select distinct prd_line 
from bronze.crm_prd_info

--check negative values or nulls
select prd_cost from bronze.crm_prd_info
where prd_cost<0 or prd_cost is null

select * from bronze.crm_prd_info
where prd_end_dt<prd_start_dt

-- check for invalid Dates
select 
NullIF(sls_order_dt,0)sls_order_dt
from bronze.crm_sales_details
where sls_order_dt<=0 or LEN(sls_order_dt)!=8 or sls_order_dt >20500101 or sls_order_dt<19000101

-- check for invalid date orders
select * from bronze.crm_sales_details
where sls_order_dt>sls_ship_dt or sls_order_dt >sls_due_dt

--check for sales data
select distinct
sls_sales as old_sales,sls_quantity,sls_price as old_price,
case when sls_sales is null or sls_sales <=0 or sls_sales !=sls_quantity * abs(sls_price)
then sls_quantity * abs(sls_price)
else sls_sales
end as sls_sales,
case when sls_price is null or sls_price<=0 then sls_sales/NULLIF(sls_quantity,0)
else sls_price
End as sls_price

from bronze.crm_sales_details
where sls_sales <=0 or sls_sales is Null or sls_sales!= sls_quantity * sls_price
or sls_price is null  or sls_quantity is null or sls_price <=0 or sls_quantity <=0