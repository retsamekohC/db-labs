do $$
    DECLARE
        a integer;
        b integer;
        c integer;
        n integer;
        x integer := 2000;
        y integer := 2005;
    BEGIN
        a := (select count(*) from book);
        raise notice 'a: %', a;
        b := (select min(b.book_year) from book b);
        raise notice 'b: %', b;
        c := (select max(b.book_year) from book b);
        raise notice 'c: %', c;
        n := (select count(*) from book b where b.book_year between x and y);
        raise notice 'n: %', n;
        raise notice 'В таблице Book % книг, изданных с % по % годы', n, x, y;
    END
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------

do $$
    DECLARE
        a integer;
        b integer;
        c integer;
        n integer;
        x integer := 2000;
        y integer := 2005;
    BEGIN
        select count(*) into a from book;
        raise notice 'a: %', a;
        select min(b.book_year) into b from book b;
        raise notice 'b: %', b;
        select max(b.book_year) into c from book b;
        raise notice 'c: %', c;
        select count(*) into n from book b where b.book_year between x and y;
        raise notice 'n: %', n;
        raise notice 'В таблице Book % книг, изданных с % по % годы', n, x, y;
    END
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------

do $$
    DECLARE
        vBookYear integer;
        vBookRow book%rowtype;
    BEGIN
        for vBookYear in (select distinct book_year from book b order by book_year) loop
                for vBookRow in (select * from book b where b.book_year = vBookYear) loop
                        raise notice '%', vBookRow;
                    end loop;
            end loop;
    END
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------

do $$
    DECLARE
        vBookYear integer;
        vBookRow book%rowtype;
        vSkipYear integer := 2005;
    BEGIN
        for vBookYear in (select distinct book_year from book b order by book_year) loop
                if vBookYear = vSkipYear then
                    exit;
                end if;
                for vBookRow in (select * from book b where b.book_year = vBookYear) loop
                        raise notice '%', vBookRow;
                    end loop;
            end loop;
    END
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------

do $$
    DECLARE
        vBooksRow book%rowtype;
    BEGIN
        if (select exists (select * from pg_tables where tablename='books')) then
            drop table books;
        end if;
        create temp table books (
                                    book_id   integer,
                                    author    text,
                                    title     text not null,
                                    publisher text,
                                    book_year integer
        );
        insert into books
        select
            book_id,
            author,
            title,
            case coalesce(publisher, 'null')
                when 'Политехника' then publisher
                when 'null' then 'нет издательства'
                else 'издательство не Политехника'
                end as publisher,
            book_year
        from book b;
        for vBooksRow in (select * from Books) loop
                raise notice '%', vBooksRow;
            end loop;
        drop table books;
    END
$$ LANGUAGE plpgsql;

select * from books

------------------------------------------------------------------------------------------------------------------------