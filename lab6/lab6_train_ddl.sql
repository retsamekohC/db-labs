create table hard_drive
(
    model_id      integer not null
        constraint hard_drive_model_fk
            references lab6.model,
    serial_number integer not null,
    purchase_date date    not null,
    break_date    date default null,
    user_comments text
);
/
create table model
(
    model_id      serial
        constraint model_primary
            primary key,
    volume        float   not null,
    turning_speed integer,
    interface     integer
        constraint model_interface_fk
            references lab6.interface,
    manufacturer  integer not null
        constraint model_manufacturer_fk
            references lab6.manufacturer
);
/
create table manufacturer
(
    manufacturer_id serial
        constraint manufacturer_primary
            primary key,
    web_site        varchar
);
/
create table interface
(
    interface_id serial
        constraint interface_primary
            primary key
)