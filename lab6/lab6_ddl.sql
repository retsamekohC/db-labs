create table element
(
    elem_id   serial
        constraint element_primary
            primary key,
    elem_name varchar(50) not null
);
/
create table elements
(
    elements_id serial
        constraint elements_primary
            primary key,
    elem_id     integer
        constraint elements_elem_id_fk
            references lab6.element
);
/
create table book
(
    book_id   serial not null
        constraint book_primary
            primary key,
    author    text,
    title     text   not null,
    publisher text,
    book_year integer
        constraint book_book_year_check
            check (book_year between 1000 and date_part('year', now()))
);
/
create table book_in_lib
(
    lib_id      serial
        constraint book_in_lib_primary
            primary key,
    lib_book_id integer
        constraint book_in_lib_book_fk
            references book,
    status_id   integer
        constraint book_in_lib_book_status_fk
            references book_status
);
/
create table book_status
(
    status_id serial
        constraint book_status_primary
            primary key ,
    status_name text
);
/
alter table element
add column info varchar(200);
/
alter table element
add constraint un_info unique (info);
/
alter table element
drop column info;
/
alter table element
drop constraint un_info;
/
alter table book_status
add column comment varchar(200) not null default '';
/
select b.author
into auth
from book b;
/
drop table auth;
/
