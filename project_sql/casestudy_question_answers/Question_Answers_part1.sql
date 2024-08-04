-- who is the most senior employee based on job title?

Select * from employee order by levels DESC limit 1

-- which country have the most invoices?

select customer.country, count(invoice.invoice_id) as invoice_count from customer
left join invoice on customer.customer_id=invoice.customer_id
group by customer.country
order by count(invoice.invoice_id) DESC
limit 1;

-- what are the top 3 values of total invoice?

select total from invoice 
order by total DESC 
limit 3

-- which city has the best customer?

select billing_city, sum(total) as invoice_totals 
from invoice 
group by billing_city
order by sum(total) DESC
limit 1

-- who is the best customer? (in terms of spending)

select 
customer.first_name,
customer.last_name,
sum(invoice.total) as invoice_totals  
from customer left join invoice 
on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by sum(invoice.total) DESC
limit 1;