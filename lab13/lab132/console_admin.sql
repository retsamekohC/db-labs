grant pg_read_all_data to lab13_user2;

revoke pg_read_all_data from lab13_user2;

create role lab13_roleUDI;

grant insert, update, delete on all tables in schema libr to lab13_roleUDI;

grant lab13_roleUDI to lab13_user2;

create or replace view new_books as select * from book where book."Year" > 2000 with check option;

grant insert, update, delete on public.new_books to lab13_roleUDI;