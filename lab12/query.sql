select distinct c.computer_id
from computer c
where c.proc_number <> 2;

select distinct c.computer_id
from computer c
join comp_os_many_to_many co on c.computer_id = co.computer_id
group by c.computer_id
having count(*) > 1;

select c.computer_id
from computer c
join comp_hdd_many_to_many chhd on c.computer_id = chhd.computer_id
join hard_drive hd on chhd.hdd_id = hd.hdd_model_id
join comp_os_many_to_many comtm on c.computer_id = comtm.computer_id and comtm.os_id = 'windows 7'
group by c.computer_id
having sum(hd.hdd_size_gb) > 500;

select * from comp_user_many_to_many;

select distinct cu.user_id
from comp_user_many_to_many cu
group by cu.user_id
having count(*) = 1;

select distinct cu.user_id, count(*)
from comp_user_many_to_many cu
group by cu.user_id
having count(*) = (select count(*) from computer);

select distinct nd.net_device_id, nd.net_device_name
from network_device nd
where not exists(select *
                 from network_interface ni
                 join computer c on c.computer_id = ni.computer_id
                 where ni.net_device_id = nd.net_device_id and c.computer_name='comp1');

select *
from computer
where computer_name like '%#_%' escape '#'