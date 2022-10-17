select distinct author
from book;
/
select *
from book
order by book.book_year, book.title;
/
select *
from book
order by book.book_year
limit 2;
/
select *
from book b
join book_in_lib bil on b.book_id = bil.lib_book_id;
/
select *
from book b
where b.book_year > 1999
  and (b.author like 'Г%' or b.publisher like '_а%')
order by b.title;
/
select distinct bs.status_id
from book_status bs
left join book_in_lib bil on bs.status_id = bil.status_id
where bil.lib_id is null;
/
select *
from book b
where b.author similar to 'А*' or b.book_year > 2000
    and not publisher similar to '[И,П]*';