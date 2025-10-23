CREATE TABLE users
(
    id NUMERIC,
    firstname TEXT,
    lastname TEXT,
    email TEXT,
    username TEXT,
    city TEXT,
    street TEXT,
    zipcode TEXT,
    lat TEXT,
    long TEXT
);

CREATE TABLE products
(
    id NUMERIC,
    price NUMERIC,
    category TEXT
);

CREATE TABLE carts
(
    id NUMERIC,
    user_id NUMERIC,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE cart_items
(
    cart_id NUMERIC,
    product_id NUMERIC,
    quantity NUMERIC,
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Cria view do dashboard
drop view if exists dashboard;

create view dashboard as
select
		u.id as user_id,
		(select count(c.id) from carts c where c.user_id = u.id) as total_carts,
		count(distinct p.id) as total_products,
		(select avg(qty) from ( select ci.cart_id, count(*) qty from carts c join cart_items ci on c.id = ci.cart_id where c.user_id = u.id group by ci.cart_id ) ) as avg_products_per_cart,
		count(distinct p.category) as distinct_categories,
		max(p.price) as most_expensive_product,
		sum(p.price) as total_value,
		sum(p.price * ci.quantity) as total_value_with_qty -- adicionei esse campo multiplicando o valor pela quantidade de itens. Para ficar mais realista
from users u
left join carts c on u.id = c.user_id
left join cart_items ci on c.id = ci.cart_id
left join products p on ci.product_id = p.id
group by u.id