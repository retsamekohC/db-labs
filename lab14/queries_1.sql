update book_in_lib set lib_id = 10 where lib_id in (2,3);

update book_in_lib set lib_id = 10 where lib_id = 2;
update book_in_lib set lib_id = 10 where lib_id = 3;

update book_in_lib set lib_id = 2 where lib_id = 10;

begin transaction isolation level repeatable read ;
update book_in_lib set lib_id = 10 where lib_id = 2;
select * from book_in_lib;
savepoint check1;
insert into book_in_lib (lib_book_id, status_id) values (6,1);
select * from book_in_lib;
rollback to check1;

select txid_current();

select * from book_in_lib;

select * from pg_locks;