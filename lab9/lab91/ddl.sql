create database MyLib;
/
create schema library;
/
create table library.book
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
create table library.book_in_lib
(
    lib_id      serial
        constraint book_in_lib_primary
            primary key,
    lib_book_id integer,
    status_id   integer
);
/
create table library.book_status
(
    status_id   serial
        constraint book_status_primary
            primary key,
    status_name text
        unique
);
/
alter table library.book_in_lib
    add constraint book_in_lib_status_fk
        foreign key (status_id)
            references library.book_status (status_id);
/
alter table library.book_in_lib
    add constraint book_in_lib_book_fk
        foreign key (lib_book_id)
            references library.book (book_id);
/