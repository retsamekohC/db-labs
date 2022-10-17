begin;
INSERT INTO Book (Author, Title, Publisher, Book_Year)
VALUES ('Дейт К.', 'Введение в системы баз данных. 8-е издание', 'Издательский дом "Вильямс"', 2005);
insert into Book (author, title, publisher, book_year)
values ('Карпова Т.С.', 'Базы данных', 'Питер', 2001);

insert into book_status (status_name)
values ('в библиотеке');
insert into book_status (status_name)
values ('выдана');
insert into book_status (status_name)
values ('устарела');

insert into book_in_lib (lib_book_id, status_id)
values (1, 1), (1, 2), (1,3), (2,2), (2,3), (3,3);
commit;

insert into book