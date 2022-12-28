-- Restaurant Owners
-- 5 Tables
-- 1x Fact, 4x Dimension
-- search google, how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery/ with


-- create fact table  
CREATE TABLE orders (
    order_id INT,
    order_date date,
    amount REAL,
    customer_id INT,
    outlet_id INT,
    channel_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    FOREIGN KEY (outlet_id) REFERENCES outlets(outlet_id)
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
    FOREIGN KEY (order_id) REFERENCES order_details(order_id)
);

INSERT INTO orders VALUES 
(1, '2022-08-01', 200, 859, 2, 3),
(2, '2022-08-02', 250, 746, 6, 2),
(3, '2022-06-03', 150, 165, 3, 1),
(4, '2022-01-06', 235, 298, 7, 1),
(5, '2022-06-04', 290, 487, 9, 4),
(6, '2022-03-31', 100, 366, 5, 3),
(7, '2022-05-21', 300, 590, 1, 4),
(8, '2022-02-22', 230, 621, 9, 2),
(9, '2022-05-11', 140, 973, 8, 3),
(10, '2022-04-09', 185, 842, 4, 2),
(11, '2022-02-04', 295, 708, 6, 1),
(12, '2022-07-25', 280, 664, 8, 4);

-- create dimension table1  
CREATE TABLE customers (
    customer_id INT,
    firstname VARCHAR,
    lastname VARCHAR,
    gender VARCHAR,
    dob DATE
);

INSERT INTO customers VALUES 
(859, 'Adam', 'Smith', 'Male', '1978-05-29'),
(746, 'Babara', 'Wilson', 'Female', '1973-02-28'),
(165, 'Catherine', 'Utah', 'Female', '1998-09-01'),
(298, 'David', 'Musk', 'Male', '1989-03-07'),
(487, 'Evan', 'Dowsy', 'Male', '2001-07-16'),
(366, 'Frank', 'Diamond', 'Male', '1999-10-26'),
(590, 'Gene', 'Austin', 'Female', '2000-09-30'),
(621, 'Helene', 'Kimton', 'Female', '1954-08-29'),
(973, 'Irene', 'Blackwood', 'Female', '1995-04-13'),
(842, 'Jackson', 'Wang', 'Male', '1993-07-06'),
(708, 'Kevin', 'Clain', 'Male', '1960-11-04'),
(664, 'Laura', 'Jones', 'Female', '1984-12-31');

-- create dimension table2  
CREATE TABLE outlets (
    outlet_id INT,
    outlet_name varchar,
    province varchar
);

INSERT INTO outlets VALUES 
(1, 'iconsiam', 'Bangkok'),
(2, 'maya', 'Chiangmai'),
(3, 'central phuket', 'Phuket'),  
(4, 'centralworld', 'Bangkok'),
(5, 'central pattaya', 'Chonburi'),
(6, 'central korat', 'Nakornratchasima'),
(7, 'central kornkaen', 'Khonkaen'),
(8, 'emquartiar', 'Bangkok'),
(9, 'silom complex', 'Bangkok');

-- create dimension table3 
CREATE TABLE channels (
    channel_id INT,
    channel_name varchar,
    mdr_rate real
);

INSERT INTO channels VALUES 
(1, 'cash', 0),
(2, 'credit card', 0.03),
(3, 'e-wallet', 0.01),  
(4, 'bank account', 0.005);

-- create dimension table4 
CREATE TABLE order_details (
    order_id INT,
    menu varchar,
    sub_menu varchar
);

INSERT INTO order_details VALUES 
(1, 'spagetthi', 'carbonara'),
(2, 'fried rice', 'seafood'),
(3, 'pokebowl', 'vegan'),
(4, 'kimbab', 'salmon'),
(5, 'noodles', 'wagyu'),
(6, 'spagetthi', 'garlic and spice'),
(7, 'kimbab', 'hotate'),
(8, 'pokebowl', 'salmon'),
(9, 'fried rice', 'pork'),
(10, 'noodles', 'seafood'),
(11, 'noodles', 'lobster'),
(12, 'kimbab', 'unagi');

-- sqlite command
.mode markdown
.header on

-- finance report by region
with
cost as
(
  select 
    o.order_id              as order_id,
    o.amount                as amount,
    ch.mdr_rate * o.amount  as mdr,
    o.amount * 0.7          as operation_cost     
  from      orders   as o
  left join channels as ch on o.channel_id = ch.channel_id
)

select 
  case  
    when  ol.province in ('Bangkok')                       then 'Central'
    when  ol.province in ('Chiangmai')                     then 'North'
    when  ol.province in ('Phuket')                        then 'South'
    when  ol.province in ('Chonburi')                      then 'East'
    when  ol.province in ('Nakornratchasima', 'Khonkaen')  then 'North-East'
  end as region,
  count(o.order_id)                               as count_order,
  sum(o.amount)                                   as income,
  sum(o.amount - c.mdr - c.operation_cost)  as profit 
from       orders   as o
left join  outlets  as ol  on o.outlet_id = ol.outlet_id
left join  cost     as c   on c.order_id  = o.order_id
group by region; 

-- average income by age
with
age as
(
  select
  cu.customer_id                     as customer_id,
  2022 - strftime('%Y', dob)         as age
  from customers as cu
)

select 
  case
    when a.age < 25              then 'teens'
    when a.age between 25 and 40 then 'adult_1'
    when a.age between 41 and 60 then 'adult_2'
    else 'senior'
  end as age_group,
  avg(o.amount)     as average_spending
from       orders   as o
left join  age      as a on a.customer_id = o.customer_id
group by age_group
order by average_spending desc;

-- bestseller menu in Bangkok
select 
  od.menu               as menu,
  avg(o.amount)         as avg_price,
  count(o.order_id)     as count_menu
from      orders        as o
left join order_details as od on o.order_id = od.order_id
left join outlets       as ol on ol.outlet_id = o.outlet_id
where ol.province = 'Bangkok'
group by menu 
order by count_menu desc;
