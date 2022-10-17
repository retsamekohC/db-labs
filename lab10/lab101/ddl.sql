create temp table book_tmp
(
    book_id   integer primary key,
    author    text,
    title     text not null,
    publisher text,
    book_year integer
);

create temp table book_status_tmp
(
    status_id   integer primary key,
    status_name varchar(50) not null unique
);

insert into book_tmp
select *
from library.book b
where b.book_year > 2000;

insert into book_status_tmp
select *
from library.book_status;

select *
from book_tmp;

select *
from book_status_tmp;

update book_tmp set book_year=book_year+2;

update book_status_tmp set status_name = 'обветшала' where status_name='устарела';

delete from book_status_tmp where status_name='обветшала';


