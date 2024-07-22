select count(distinct customer_id) 
from customers;

select
    concat(first_name, ' ', last_name) as seller,
    count(*) as operations,
    floor(sum(price * quantity)) as income
from sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by seller
order by income desc
limit 10;

select
    concat(first_name, ' ', last_name) as seller,
    floor(avg(price * quantity)) as average_income
from sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by seller
having
    floor(avg(price * quantity)) < (
        select floor(avg(price * quantity))
        from sales as s
        inner join products as p
            on s.product_id = p.product_id
    )
order by average_income;

select
    concat(first_name, ' ', last_name) as seller,
    to_char(sale_date, 'day') as day_of_week,
    floor(sum(price * quantity)) as income
from sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by seller, day_of_week, to_char(sale_date, 'id')
order by to_char(sale_date, 'id'), seller;

select
    case
        when age between 16 and 25 then '16-25'
        when age between 26 and 40 then '26-40'
        when age > 40 then '40+'
    end as age_category,
    COUNT(age) as age_count
from customers
group by 1
order by 1;

select
    to_char(sale_date, 'YYYY-MM') as selling_month,
    count(distinct c.customer_id) as total_customers,
    floor(sum(price * quantity)) as income
from sales as s
inner join customers as c
    on s.customer_id = c.customer_id
inner join products as p
    on s.product_id = p.product_id
group by 1
order by 1;

select distinct on (customer_id)
    concat(c.first_name, ' ', c.last_name) as customer,
    s.sale_date,
    concat(e.first_name, ' ', e.last_name)
from sales as s
inner join customers as c
    on s.customer_id = c.customer_id
inner join products as p
    on s.product_id = p.product_id
inner join employees as e
    on s.sales_person_id = e.employee_id
where price = 0
order by c.customer_id, s.sale_date;
