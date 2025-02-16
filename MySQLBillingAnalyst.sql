-- 1 -- All Transactions with Total Amount

select t.transactiondate, c.customername, c.address, p.productname, p.category, (p.unitprice*t.quantity) as total_transac from transactions t
join customer c on c.customerID = t.transactionID
join product p on p.productID = T.transactionID
order by total_transac desc;

-- 2 -- Total Sales by Each Product

select p.productname, t.quantity,  (p.unitprice*t.quantity) as total_sales  from product p
join transactions t on t.transactionid = p.productid;

-- 3 -- Customers with Pending Payments

select c.customername, c.contactnumber, t.paymentstatus from customer c
join transactions t on t.transactionid = c.customerid
where t.paymentstatus = "pending";

-- 4 -- Total Revenue

select sum(p.unitprice*t.quantity) as total_revenue from product p
join transactions t on t.transactionid = p.productid
where t.paymentstatus = "paid";

-- 5 -- Products with Low Stock (Threshold: 100 Units)

select productname, stock from product
where stock < 100;

-- 6 -- Count Transactions by Payment Status

select paymentstatus, count(*) from transactions
group by paymentstatus
order by paymentstatus desc;

-- 7 -- Top 5 Customers by Total Spending

select c.customername, c.address, sum(p.unitprice*t.quantity) as total_spent from customer c
join transactions t on t.transactionId = c.customerID
join product p on p.productid = t.transactionid
group by c.customername, c.address
order by total_spent desc
limit 5;


-- 8 -- Best-Selling Category

select p.category, sum(t.quantity) as total_units_sold from product p
join transactions t on t.transactionID =  p.productId
group by p.category
order by total_units_sold desc;

-- 9 -- Monthly Sales Trend
       -- (fixing date data type) --
          -- 1 -- alter table transactions add column New_Date date; --
          -- 2 -- update transactions set New_Date = str_to_date(transactiondate, '%d-%m-%Y'); -- case sensetive(d m Y) --
          -- 3 -- alter table transactions drop transactiondate; -- 
	      -- 4 -- desc transactions; -- For Discription -- 
          
              alter table transactions add column New_Date date;
              update transactions set New_date = str_to_date(transactiondate, '%d-%m-%Y');
              alter table transactions drop transactiondate;
   
select date_format(t.new_date, '%m') as months, sum(t.quantity*p.unitprice) as Monthly_sales from transactions t
join product p on p.productId = t.transactionid
group by months
order by Monthly_sales;

-- 10 -- Details of Customers Who Purchased Electronics -- 

select distinct c.customerid, c.customername, c.address, p.category from customer c
join product p  on p.productid = c.customerid
where category = "electronics";

-- 11 -- Products Never Sold -- 


select p.productname, p.category from product p
join transactions t on t.transactionid = p.productid
where p.productid is null;


-- 12 -- Customers with the Most Transactions

select c.customerid, c.customername, count(t.transactionid) as transactions from customer c
join transactions t on t.transactionid = c.customerid
group by c.customerid, c.customername
order by transactions desc;

-- 13 -- Average Order Value (AOV)

select round(avg(t.quantity*p.unitprice), 2) as avg_value from transactions t
join product p on p.productid = t.transactionid;

-- 14 --Total Units Sold by Category -- 

select p.category, sum(t.quantity) as total_qty_sold from product p
join transactions t on t.transactionid = p.productid
group by p.category
order by total_qty_sold desc;







select * from customer
select * from product 
select * from transactions, product