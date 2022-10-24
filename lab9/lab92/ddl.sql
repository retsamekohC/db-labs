create schema lab9_2_schema;

set search_path to lab9_2_schema;

create table computer
(
    computer_id   integer     not null,
    computer_name varchar(50) null,
    proc_number   varchar(50) null,
    ram_size_gb   integer     null,
    proc_id       integer     null,
    comp_role_id  integer     null,
    ram_type_id   integer     null,
    user_id       integer     null
);

alter table computer
    add constraint xpkcomputer primary key (computer_id);

create table computer_role
(
    comp_role_id        integer     not null,
    comp_role_full_name varchar(50) null
);

alter table computer_role
    add constraint xpkcomputer_role primary key (comp_role_id);

create table hard_drive
(
    hdd_model_id        integer     not null,
    hdd_model_full_name varchar(50) null,
    hdd_vendor          varchar(50) null,
    hdd_size_gb         varchar(50) null,
    hdd_interface       varchar(50) null
);

alter table hard_drive
    add constraint xpkhard_drive primary key (hdd_model_id);

create table network_device
(
    net_device_id          integer     not null,
    net_device_name        varchar(50) null,
    net_device_type        varchar(50) null,
    net_device_model       varchar(50) null,
    net_device_vendor      varchar(50) null,
    net_device_port_number char(18)    null
);

alter table network_device
    add constraint xpknetwork_device primary key (net_device_id);

create table network_interface
(
    net_interface_id   char(18)    not null,
    net_interface_mac  varchar(50) null,
    net_interface_ip   varchar(50) null,
    net_interface_info char(18)    null,
    net_device_id      integer     null,
    computer_id        integer     not null
);

alter table network_interface
    add constraint xpknetwork_interface primary key (net_interface_id, computer_id);

create table os
(
    os_name   varchar(50) not null,
    os_type   varchar(50) null,
    os_vendor varchar(50) null,
    os_info   text        null
);

alter table os
    add constraint xpkos primary key (os_name);

create table processor
(
    proc_id        integer     not null,
    proc_full_name varchar(50) null,
    proc_vendor    varchar(50) null,
    proc_arch      varchar(50) null,
    proc_freq      float       null
);

alter table processor
    add constraint xpkprocessor primary key (proc_id);

create table ram_type
(
    ram_type_id        integer     not null,
    ram_type_full_name varchar(50) null
);

alter table ram_type
    add constraint xpkram_type primary key (ram_type_id);

create table computer_user
(
    user_id          integer     not null,
    user_login       varchar(50) null,
    user_first_name  varchar(50) null,
    user_second_name varchar(50) null,
    user_last_name   varchar(50) null
);

alter table computer_user
    add constraint xpkuser primary key (user_id);

create view компы(computer_name, user_login)
as
select computer.computer_name, computer_user.user_login
from computer,
     computer_user
where computer.user_id = computer_user.user_id;

alter table computer
    add constraint r_6 foreign key (proc_id) references processor (proc_id)
        on delete no action
        on update no action;

alter table computer
    add constraint r_7 foreign key (comp_role_id) references computer_role (comp_role_id)
        on delete set null
        on update no action;

alter table computer
    add constraint r_8 foreign key (ram_type_id) references ram_type (ram_type_id)
        on delete no action
        on update no action;

alter table network_interface
    add constraint r_11 foreign key (net_device_id) references network_device (net_device_id)
        on delete no action
        on update no action;

alter table network_interface
    add constraint r_12 foreign key (computer_id) references computer (computer_id)
        on delete no action
        on update no action;

create table comp_user_many_to_many
(
    computer_name text constraint comp_fk references computer(computer_name),
    user_name text constraint user_fk references computer_user(user_first_name)
);

create table comp_os_many_to_many(
    computer_name text constraint comp_fk references computer(computer_name),
    os_name text constraint os_fk references os
);

create table comp_hdd_many_to_many(
    computer_name text constraint comp_fk references computer(computer_name),
    hdd_name text constraint disk_fk references hard_drive(hdd_model_full_name)
);

alter table hard_drive
    add constraint hdd_unique unique (hdd_model_full_name);

alter table computer
    add constraint comp_name_unique unique (computer_name);

alter table computer_user
    add constraint user_name_unique unique (user_first_name);