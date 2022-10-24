select *
from library.book b
where b.book_year > 1999
  and (b.author like 'Г%' or publisher like '%а')
order by b.title desc;

select *
from library.book b
where b.title like '_#_%' escape '#';

select distinct b.publisher
from library.book b
         join library.book_in_lib bil on b.book_id = bil.lib_book_id
where bil.status_id in (2);

select publisher
from library.book b
         left join library.book_in_lib bil on b.book_id = bil.lib_book_id
group by publisher
having max(status_id) = 2 or max(status_id) is null;

select b.publisher, b1.publisher
from book b
cross join book b1
where b.book_id <> b1.book_id