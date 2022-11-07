do $$
    DECLARE
        vBookRow book%rowtype;
    BEGIN
        if (select exists (select * from pg_tables where tablename='sharp_table')) then
            drop table sharp_table;
        end if;
        create temp table sharp_table (
            book_id   integer
              constraint sharp_table_primary
                  primary key,
            author    text,
            title     text not null,
            publisher text,
            book_year integer
              constraint sharp_table_by_check
                  check ((book_year >= 1000) AND ((book_year)::double precision <= date_part('year'::text, now()))),
            book_num integer
        );
        insert into sharp_table
        select *, null from book;
    END
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------

create or replace function lab16func(pBookId in integer) returns integer as $$
BEGIN
    return coalesce((select count(*) from book_in_lib bil where bil.lib_book_id = pBookId), 0);
END
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------

do $$
    declare
        vSharpTableId integer;
    begin
        for vSharpTableId in (select st.book_id from sharp_table st) loop
                update sharp_table set book_num = library.lab16func(vSharpTableId) where book_id = vSharpTableId;
            end loop;
    end;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------

do $$
    declare
        maxBookNum int;
    begin
        maxBookNum := (select max(book_num) from sharp_table);
        raise notice 'maxBookNum: %', maxBookNum;
    end;
$$ LANGUAGE plpgsql

------------------------------------------------------------------------------------------------------------------------

create or replace procedure lab16procedure (pStatusName in text, pResult out int, pExitCode out int) as $$
begin
    if pStatusName is null then
        pExitCode := -1;
    end if;
    if exists (select * from book_status bs where bs.status_name = pStatusName) then
        pResult := coalesce((select count(*)
                             from book_in_lib bil
                                      join book_status bs on bs.status_id = bil.status_id
                             where bs.status_name = pStatusName), 0);
        pExitCode := 0;
    else
        insert into book_status (status_id, status_name) values (nextval('book_status_status_id_seq'), pStatusName);
        pExitCode := 1;
    end if;
end;
$$ language plpgsql;

------------------------------------------------------------------------------------------------------------------------

create or replace function lab16TrgFunc() returns trigger as $$
declare
    row_count int;
    vetag_name text;
begin
    if (tg_op in ('DELETE', 'UPDATE')) then
        select count(*) from oldtbl into row_count;
    else
        select count(*) from newtbl into row_count;
    end if;
    if row_count > 5 then
        raise 'too_many_rows_affected';
    end if;
    return null;
end;
$$ language plpgsql;

create or replace trigger lab16Trg1
    after insert  on book_in_lib
    referencing NEW table as newtbl
    for each statement
execute function lab16TrgFunc();

create or replace trigger lab16Trg2
    after update on book_in_lib
    referencing OLD table as oldtbl
    for each statement
execute function lab16TrgFunc();

create or replace trigger lab16Trg3
    after delete on book_in_lib
    referencing OLD table as oldtbl
    for each statement
execute function lab16TrgFunc();

begin;
update book_in_lib set lib_book_id=1 where status_id = 4;
end;

select txid_current();

------------------------------------------------------------------------------------------------------------------------

create or replace function deny_modif_func () returns event_trigger as $$
begin
    raise exception 'command is disabled';
end;
$$ language plpgsql;

create event trigger deny_modif_update
    on ddl_command_start
    when tag in ('drop table', 'drop view', 'alter table', 'alter view')
execute function deny_modif_func();

create temp table temp_table as select * from book;

drop table temp_table;