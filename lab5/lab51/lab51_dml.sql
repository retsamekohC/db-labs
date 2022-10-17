insert into lab5.customer (customer_name, customer_address, customer_phone)
values ('Ivanov I.I.', 'Спб, ул. Политехническая, 29', '(812)111-11-11'),
       ('Petrov P.P', 'Спб, ул. Политехническая, 21', '(812)222-22-22');

insert into lab5.product (product_title, product_price)
values ('Рюкзак городской. Модель 1.', 2000.00),
       ('Накидка на рюкзак. Модель 2.', 400.00),
       ('Рюкзак туристический. Модель 2.', 4000.00);

insert into lab5.customer_order (order_id, order_customer_link)
values (1,1),
       (2,2),
       (3,2);

insert into lab5.details (details_order_id, details_product_id, amount)
values (1, 1, 1),
       (1, 2, 1),
       (2, 1, 2),
       (3, 3, 1);
commit;