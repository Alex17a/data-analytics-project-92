select COUNT (distinct customer_id) 
from customers;


select concat(first_name, ' ', last_name) as seller,
COUNT(*) as operations,
FLOOR(SUM(price*quantity)) as income
from sales s
inner join employees e 
on e.employee_id = s.sales_person_id 
inner join products p 
on s.product_id = p.product_id
group by seller
order by income desc 
limit 10;



select concat(first_name, ' ', last_name) as seller,
FLOOR(AVG(price*quantity)) as average_income
from sales s
inner join employees e 
on e.employee_id = s.sales_person_id 
inner join products p 
on s.product_id = p.product_id
group by seller
having FLOOR(AVG(price*quantity))< (select
FLOOR(AVG(price*quantity))
from sales s
inner join products p 
on s.product_id = p.product_id)
order by average_income







select concat(first_name, ' ', last_name) as seller,
to_char (sale_date, 'day') day_of_week,
FLOOR(SUM(price*quantity)) as income
from sales s
inner join employees e 
on e.employee_id = s.sales_person_id 
inner join products p 
on s.product_id = p.product_id
group by seller, day_of_week, to_char(sale_date, 'id')
order by to_char(sale_date, 'id') , seller


select case 
when age between 16 and 25 then '16-25'
when age between 26 and 40 then '26-40'
when age > 40 then '40+' 
end age_category , COUNT(age) age_count 
from customers c 
group by 1
order by 1


select 
to_char (sale_date, 'YYYY-MM') selling_month,
COUNT (DISTINCT c.customer_id) total_customers,
FLOOR(SUM(price*quantity)) as income
from sales s
inner join customers c 
on c.customer_id = s.customer_id 
inner join products p 
on s.product_id = p.product_id
group by 1
order by 1 

select distinct on (customer_id) concat(c.first_name, ' ', c.last_name) customer,
sale_date, concat(e.first_name, ' ', e.last_name)
from sales s
inner join customers c 
on c.customer_id = s.customer_id 
inner join products p 
on s.product_id = p.product_id
inner join employees e 
on e.employee_id = s.sales_person_id 
where price = 0
order by c.customer_id, 2
