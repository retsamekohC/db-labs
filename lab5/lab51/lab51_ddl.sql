create table customer
(
    customer_id      serial
        constraint customer_primary
            primary key,
    customer_name    varchar not null,
    customer_address varchar,
    customer_phone   varchar
);

create table product
(
    product_id    serial
        constraint product_primary
            primary key,
    product_title varchar not null,
    product_price float not null
);

create table customer_order
(
    order_id            serial
        constraint order_primary
            primary key,
    order_customer_link integer not null
        constraint customer_order_customer_fk
            references customer
);

create index customer_order_customer_link_idx on customer_order(order_customer_link);

create table details
(
    details_order_id   integer not null
        constraint order_details_order_fk
            references customer_order,
    details_product_id integer not null
        constraint details_product_fk
            references product,
    amount             integer not null
);

create index details_order_id_idx on details(details_order_id);

create index details_product_id_idx on details(details_product_id);