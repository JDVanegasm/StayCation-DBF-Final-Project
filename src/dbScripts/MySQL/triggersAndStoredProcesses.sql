-- Create table for logging user operations
create table if not exists user_log (
    id_log int auto_increment primary key,
    operation varchar(30),
    user_id varchar(36),
    date_log timestamp default current_timestamp
);

-- Trigger to log new users
drop trigger if exists insert_user_log;
create trigger insert_user_log
after insert on user
for each row
insert into user_log(operation, user_id)
values ('NEW USER', new.userId);

-- Create table for logging property operations
create table if not exists property_log (
    id_log int auto_increment primary key,
    operation varchar(30),
    property_id varchar(36),
    date_log timestamp default current_timestamp
);

-- Trigger to log property updates
drop trigger if exists update_property_log;
create trigger update_property_log
after update on property
for each row
insert into property_log(operation, property_id)
values ('UPDATE PROPERTY', new.propertyId);

-- Create table for logging booking operations
create table if not exists booking_log (
    id_log int auto_increment primary key,
    operation varchar(30),
    booking_id varchar(36),
    date_log timestamp default current_timestamp
);

-- Trigger to log new bookings
drop trigger if exists insert_booking_log;
create trigger insert_booking_log
after insert on booking
for each row
insert into booking_log(operation, booking_id)
values ('NEW BOOKING', new.bookingId);

-- Procedure to report comments with specific keyword
delimiter //

create procedure report_comments(keyword varchar(50))
begin
    select c.content as comment_content, c.uploadDate as comment_date,
           u.name as user_name, u.email as user_email, 
           p.name as property_name, c.rating as comment_rating
    from comment as c
    join user as u on c.userId = u.userId
    join property as p on c.propertyId = p.propertyId
    where c.content like concat('%', keyword, '%');
end //

delimiter ;

-- Procedure to generate a report of available properties
delimiter //

create procedure available_properties_report()
begin
    select p.name as property_name, p.location, p.price,
           p.availableRooms, p.availableBeds, p.availableBaths,
           u.name as owner_name, u.email as owner_email
    from property as p
    join user as u on p.userId = u.userId
    where p.availableRooms > 0 and p.availableBeds > 0 and p.availableBaths > 0;
end //

delimiter ;

-- Enable the event scheduler
set global event_scheduler = on;

-- Event to execute the available properties report daily
create event if not exists daily_available_properties_report
on schedule every 1 day
starts current_timestamp + interval 1 day
do
call available_properties_report();
