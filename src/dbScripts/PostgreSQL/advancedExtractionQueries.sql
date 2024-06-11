-- Advance Extraction Queries for StayCation's DB, example queries

-- Extract properties with average rating based on reviews.
SELECT 
    p."propertyId", 
    p."name" AS "propertyName", 
    AVG(c.rating) AS "averageRating"
FROM
    "Property" p
JOIN 
    "Comment" c ON p."propertyId" = c."propertyId"
GROUP BY
    p."propertyId", p."name";

-- Extract pending bills for a specific user.
SELECT
    b."billId", 
    p."name" AS "propertyName", 
    b."billStatus", 
    u."name" AS "userName"
FROM
    "Bill" b
JOIN 
    "Booking" bk ON b."bookingId" = bk."bookingId"
JOIN 
    "Property" p ON b."propertyId" = p."propertyId"
JOIN 
    "User" u ON b."userId" = u."userId"
WHERE 
    b."billStatus" = 'Pending' 
    AND b."userId" = '2e92d6e0-6dbe-11ec-90d6-0242ac120003';

-- Extract all properties with room availability greater than a specific number.
SELECT 
    p."propertyId", 
    p."name" AS "propertyName", 
    p.location, 
    p."availableRooms"
FROM
    "Property" p
WHERE 
    p."availableRooms" > 3;

-- Extract the comments history for a specific property.
SELECT 
    c."commentId", 
    c.content, 
    c."uploadDate", 
    c.rating, 
    u."name" AS "userName"
FROM
    "Comment" c
JOIN 
    "User" u ON c."userId" = u."userId"
WHERE 
    c."propertyId" = '1e92d6e0-6dbe-11ec-90d6-0242ac120003';

-- List the users with the most reservations.
SELECT 
    u."userId", 
    u."name" AS "userName", 
    COUNT(b."bookingId") AS "totalBookings"
FROM
    "User" u
JOIN 
    "Booking" b ON u."userId" = b."userId"
GROUP BY
    u."userId", u."name"
ORDER BY 
    "totalBookings" DESC;

-- List all properties that are priced in a specific range.
SELECT 
    p."propertyId", 
    p."name" AS "propertyName", 
    p.price
FROM
    "Property" p
WHERE 
    p.price BETWEEN 100 AND 200;

-- Extract the total number of comments per property.
SELECT 
    p."propertyId", 
    p."name" AS "propertyName", 
    COUNT(c."commentId") AS "totalComments"
FROM 
    "Property" p
JOIN 
    "Comment" c ON p."propertyId" = c."propertyId"
GROUP BY 
    p."propertyId", p."name";

-- List all properties along with the number of reservations made.
SELECT 
    p."propertyId", 
    p."name" AS "propertyName", 
    COUNT(b."bookingId") AS "totalBookings"
FROM 
    "Property" p
LEFT JOIN
    "Booking" b ON p."propertyId" = b."propertyId"
GROUP BY
    p."propertyId", p."name";
