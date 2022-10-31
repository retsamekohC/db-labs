begin transaction isolation level repeatable read ;
select * from library.book_in_lib;
commit ;

select txid_current();
