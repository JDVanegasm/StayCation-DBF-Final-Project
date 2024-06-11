/*Advance Extraction Queries for StayCation's DB, example queries*/

use staycation;

-- Extract properties with average rating based on reviews.
select 
    p.propertyId, 
    p.name as propertyName, 
    AVG(c.rating) as averageRating
from
    Property p
join 
    Comment c on p.propertyId = c.propertyId
group by
    p.propertyId, p.name;

-- Extract pending bills for a specific user.
select
    b.billId, 
    p.name as propertyName, 
    b.billStatus, 
    u.name as userName
from
    Bill b
join 
    Booking bk on b.bookingId = bk.bookingId
join 
    Property p on b.propertyId = p.propertyId
join 
    User u on b.userId = u.userId
where 
    b.billStatus = 'Pending' 
    and b.userId = '2e92d6e0-6dbe-11ec-90d6-0242ac120003';
    
-- Extract all properties with room availability greater than a specific number.
select 
    p.propertyId, 
    p.name as propertyName, 
    p.location, 
    p.availableRooms
from
    Property p
where 
    p.availableRooms > 3;

-- Extract the comments history for a specific property.
select 
    c.commentId, 
    c.content, 
    c.uploadDate, 
    c.rating, 
    u.name as userName
from
    Comment c
join 
    User u on c.userId = u.userId
where 
    c.propertyId = '1e92d6e0-6dbe-11ec-90d6-0242ac120003';

-- List the users with the most reservations.
select 
    u.userId, 
    u.name as userName, 
    COUNT(b.bookingId) as totalBookings
from
    User u
join 
    Booking b on u.userId = b.userId
group by
    u.userId, u.name
order by 
    totalBookings desc;

-- List all properties that are priced in a specific range.
select 
    p.propertyId, 
    p.name as propertyName, 
    p.price
from
    Property p
where 
    p.price between 100 and 200;
    
-- Extract the total number of comments per property.
select 
    p.propertyId, 
    p.name as propertyName, 
    COUNT(c.commentId) as totalComments
from 
    Property p
join 
    Comment c on p.propertyId = c.propertyId
group by 
    p.propertyId, p.name;

-- List all properties along with the number of reservations made.
select 
    p.propertyId, 
    p.name as propertyName, 
    COUNT(b.bookingId) as totalBookings
from 
    Property p
left join
    Booking b on p.propertyId = b.propertyId
group by
    p.propertyId, p.name;

   