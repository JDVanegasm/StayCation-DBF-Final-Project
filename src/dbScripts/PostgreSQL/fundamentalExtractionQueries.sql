/*Fundamental Extraction Queries for StayCation's DB, example queries*/

\c staycation;

-- Extract all users
select * from "User";

-- Extract all users with a specific role
select 
    "userId", 
    "name", 
    "email", 
    "phone" 
from 
    "User" 
where 
    "userRole" = '1';
   
-- Extract all properties with a specific type
select 
    p."propertyId",
    p."name" AS "propertyName",
    p."description" AS "propertyDescription",
    pt."name" AS "propertyType",
    p."price"
from
    "Property" p
join 
    "PropertyType" pt ON p."propertyTypeId" = pt."propertyTypeId"
where 
    pt."name" = 'House';

-- Extract all reservations starting on a specific date
select 
    "bookingId", 
    "propertyId", 
    "userId", 
    "startingDate", 
    "endingDate" 
from
    "Booking" 
where 
    DATE("startingDate") = '2024-06-01';
   
-- Extract every Property with details
select 
    p."propertyId",
    p."name" AS "propertyName",
    p."description" AS "propertyDescription",
    pt."name" AS "propertyType",
    pa."wifi",
    pa."kitchen",
    pa."parking",
    pa."staffService",
    pa."pool",
    pa."securityCameras",
    pa."laundry",
    pa."gym",
    p."location",
    p."guestsCapacity",
    p."availableRooms",
    p."availableBeds",
    p."availableBaths",
    p."media",
    p."price"
from 
    "Property" p
join 
    "PropertyType" pt ON p."propertyTypeId" = pt."propertyTypeId"
join 
    "PropertyAddon" pa ON p."propertyAddonId" = pa."propertyAddonId";

-- Extract every booking of a specific user
select 
    b."bookingId",
    b."propertyId",
    p."name" AS "propertyName",
    b."startingDate",
    b."endingDate"
from 
    "Booking" b
join 
    "Property" p ON b."propertyId" = p."propertyId"
where 
    b."userId" = '2e92d6e0-6dbe-11ec-90d6-0242ac120003';

-- Extract the bill of a specific booking
select 
    b."billId",
    b."bookingId",
    p."name" AS "propertyName",
    b."billStatus"
from 
    "Bill" b
join 
    "Property" p ON b."propertyId" = p."propertyId"
where 
    b."bookingId" = '1b92d6e0-6dbe-11ec-90d6-0242ac120003';
   
-- Extract all available properties with a specific number of beds and baths
select 
    p."propertyId",
    p."name" AS "propertyName",
    p."description" AS "propertyDescription",
    p."guestsCapacity",
    p."availableRooms",
    p."availableBeds",
    p."availableBaths",
    p."price"
from 
    "Property" p
where 
    p."availableBeds" >= 2 AND p."availableBaths" >= 1;

-- Extract the total balance of all a user's cards
select 
    u."name" AS "userName",
    SUM(c."balance") AS "totalBalance"
from
    "Card" c
join 
    "User" u ON c."userId" = u."userId"
where 
    c."userId" = '2e92d6e0-6dbe-11ec-90d6-0242ac120003'
group by 
    u."name";
   
-- Extract all credit cards for a user
select 
    "cardId", 
    "cardNumber", 
    "cardOwner", 
    "dueDate", 
    "balance" 
from
    "Card" 
where 
    "userId" = '2e92d6e0-6dbe-11ec-90d6-0242ac120003';


-- Extract the total number of properties by type
select 
    pt."name" AS "propertyType", 
    COUNT(p."propertyId") AS "totalProperties"
from
    "Property" p
join 
    "PropertyType" pt ON p."propertyTypeId" = pt."propertyTypeId"
group by
    pt."name";

-- Extract the GPA for a specific property
select 
    "propertyId", 
    AVG("rating") AS "averageRating" 
from
    "Comment" 
where 
    "propertyId" = '1e92d6e0-6dbe-11ec-90d6-0242ac120003'
group by 
    "propertyId";

-- Extract all pending bills
select 
    "billId", 
    "bookingId", 
    "propertyId", 
    "userId", 
    "billStatus" 
from
    "Bill" 
where 
    "billStatus" = 'Pending';

-- Extract all comments made by a specific user
select 
    c."commentId",
    c."content",
    c."uploadDate",
    c."rating",
    p."name" AS "propertyName"
from 
    "Comment" c
join 
    "Property" p ON c."propertyId" = p."propertyId"
where 
    c."userId" = '2e92d6e0-6dbe-11ec-90d6-0242ac120003';

-- Extract all reservations ending on a specific date
select 
    "bookingId", 
    "propertyId", 
    "userId", 
    "startingDate", 
    "endingDate" 
from
    "Booking" 
where 
    DATE("endingDate") = '2024-06-07';

-- Extract all users who have not made any reservations
select 
    u."userId", 
    u."name", 
    u."email" 
from
    "User" u
left join
    "Booking" b ON u."userId" = b."userId"
where
    b."userId" IS NULL;

-- Extract all properties that have a specific addon (i.e. pool)  
select 
    p."propertyId", 
    p."name" AS "propertyName", 
    p."description" AS "propertyDescription", 
    p."price"
from
    "Property" p
join 
    "PropertyAddon" pa ON p."propertyAddonId" = pa."propertyAddonId"
where 
    pa."pool" = true;
