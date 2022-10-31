create schema newsch;

select * from information_schema.schemata;

create or replace view newsch.vAuthors as select b.author from book b;

select * from newsch.vAuthors;

create or replace view newsch.vAuthors  as select distinct b.author from library.book b;

select count(*) from information_schema.views v where v.table_schema = 'newsch'