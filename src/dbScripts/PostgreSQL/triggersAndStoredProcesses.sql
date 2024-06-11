-- Create table for logging user operations
create table if not exists user_log (
    id_log serial primary key,
    operation varchar(30),
    user_id uuid,
    date_log timestamp default current_timestamp
);

-- Trigger to log new users
drop trigger if exists insert_user_log on "user";
drop function if exists log_new_user;

create or replace function log_new_user()
returns trigger as $$
begin
    insert into user_log(operation, user_id)
    values ('NEW USER', new.user_id);
    return new;
end;
$$ language plpgsql;

create trigger insert_user_log
after insert on "user"
for each row
execute function log_new_user();

-- Create table for logging property operations
create table if not exists property_log (
    id_log serial primary key,
    operation varchar(30),
    property_id uuid,
    date_log timestamp default current_timestamp
);

-- Trigger to log property updates
drop trigger if exists update_property_log on property;
drop function if exists log_update_property;

create or replace function log_update_property()
returns trigger as $$
begin
    insert into property_log(operation, property_id)
    values ('UPDATE PROPERTY', new.property_id);
    return new;
end;
$$ language plpgsql;

create trigger update_property_log
after update on property
for each row
execute function log_update_property();

-- Create table for logging booking operations
create table if not exists booking_log (
    id_log serial primary key,
    operation varchar(30),
    booking_id uuid,
    date_log timestamp default current_timestamp
);

-- Trigger to log new bookings
drop trigger if exists insert_booking_log on booking;
drop function if exists log_new_booking;

create or replace function log_new_booking()
returns trigger as $$
begin
    insert into booking_log(operation, booking_id)
    values ('NEW BOOKING', new.booking_id);
    return new;
end;
$$ language plpgsql;

create trigger insert_booking_log
after insert on booking
for each row
execute function log_new_booking();

-- Procedure to report comments with a specific keyword
create or replace function report_comments(keyword varchar)
returns table (
    comment_content text,
    comment_date timestamp,
    user_name varchar,
    user_email varchar,
    property_name varchar,
    comment_rating int
) as $$
begin
    return query
    select c.content, c.upload_date, u.name, u.email, p.name, c.rating
    from comment c
    join "user" u on c.user_id = u.user_id
    join property p on c.property_id = p.property_id
    where c.content like '%' || keyword || '%';
end;
$$ language plpgsql;

-- Procedure to generate a report of available properties
create or replace function available_properties_report()
returns table (
    property_name varchar,
    location varchar,
    price numeric,
    available_rooms int,
    available_beds int,
    available_baths int,
    owner_name varchar,
    owner_email varchar
) as $$
begin
    return query
    select p.name, p.location, p.price, p.available_rooms, p.available_beds, p.available_baths, u.name, u.email
    from property p
    join "user" u on p.user_id = u.user_id
    where p.available_rooms > 0 and p.available_beds > 0 and p.available_baths > 0;
end;
$$ language plpgsql;

-- Create event to execute the available properties report daily
create or replace function daily_available_properties_report()
returns void as $$
begin
    perform available_properties_report();
end;
$$ language plpgsql;

drop event if exists daily_available_properties_report;

create event daily_available_properties_report
on schedule at current_timestamp + interval '1 day'
every interval '1 day'
execute procedure daily_available_properties_report();
