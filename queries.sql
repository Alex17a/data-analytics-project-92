select count(distinct customer_id)
from customers;

select
    concat(e.first_name, ' ', e.last_name) as seller,
    count(*) as operations,
    floor(sum(p.price * s.quantity)) as income
from sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by seller
order by income desc
limit 10;

select
    concat(e.first_name, ' ', e.last_name) as seller,
    floor(avg(p.price * s.quantity)) as average_income
from sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by seller
having
    floor(avg(p.price * s.quantity)) < (
        select floor(avg(p.price * s.quantity))
        from sales as s
        inner join products as p
            on s.product_id = p.product_id
    )
order by average_income;

select
    concat(e.first_name, ' ', e.last_name) as seller,
    to_char(s.sale_date, 'day') as day_of_week,
    floor(sum(p.price * s.quantity)) as income
from sales as s
inner join employees as e
    on s.sales_person_id = e.employee_id
inner join products as p
    on s.product_id = p.product_id
group by seller, day_of_week, to_char(s.sale_date, 'id')
order by to_char(s.sale_date, 'id'), seller;

select
    case
        when age between 16 and 25 then '16-25'
        when age between 26 and 40 then '26-40'
        when age > 40 then '40+'
    end as age_category,
    count(age) as age_count
from customers
group by age_category
order by age_category;

select
    to_char(s.sale_date, 'YYYY-MM') as selling_month,
    count(distinct c.customer_id) as total_customers,
    floor(sum(p.price * s.quantity)) as income
from sales as s
inner join customers as c
    on s.customer_id = c.customer_id
inner join products as p
    on s.product_id = p.product_id
group by selling_month
order by selling_month;

select distinct on (s.customer_id)
    s.sale_date,
    concat(c.first_name, ' ', c.last_name) as customer
from sales as s
inner join customers as c
    on s.customer_id = c.customer_id
inner join products as p
    on s.product_id = p.product_id
inner join employees as e
    on s.sales_person_id = e.employee_id
where p.price = 0
order by c.customer_id, s.sale_date;
