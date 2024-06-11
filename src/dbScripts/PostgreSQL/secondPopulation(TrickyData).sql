-- StayCation DB; second Population with tricky data

\c staycation;

-- Additional inserts for User
INSERT INTO "User" (userid, userrole, name, email, hashedpassword, phone) VALUES
('6e92d6e0-6dbe-11ec-90d6-0242ac130003', '1', 'Ana Torres', 'ana.torres@example.com', digest('securepassword6', 'sha256'), '3201122334'),
('7e92d6e0-6dbe-11ec-90d6-0242ac130003', '2', 'Luis Alvarez', 'luis.alvarez@example.com', digest('securepassword7', 'sha256'), '3107766554');

-- Additional inserts for Property
INSERT INTO "Property" (propertyid, userid, propertytypeid, propertyaddonid, location, guestscapacity, availablerooms, availablebeds, availablebaths, media, name, description, price) VALUES
('6e92d6e0-6dbe-11ec-90d6-0242ac130003', '6e92d6e0-6dbe-11ec-90d6-0242ac130003', 1, 1, '123 Mountain Road, City F', 0, 2, 2, 1, 'http://example.com/media6.jpg', 'Mountain Retreat', 'A peaceful retreat in the mountains.', 120.00),
('7e92d6e0-6dbe-11ec-90d6-0242ac130003', '7e92d6e0-6dbe-11ec-90d6-0242ac130003', 2, 2, '456 River Lane, City G', 5, 0, 3, 2, 'http://example.com/media7.jpg', 'River House', 'A beautiful house by the river.', 180.00);

-- Additional inserts for Card (balance 0 and expired cards)
INSERT INTO "Card" (cardid, userid, cardnumber, cardowner, duedate, cvv, balance) VALUES
('6c92d6e0-6dbe-11ec-90d6-0242ac130003', '6e92d6e0-6dbe-11ec-90d6-0242ac130003', '6789012367890123', 'Ana Torres', '2021-01-01', '567', 0),
('7c92d6e0-6dbe-11ec-90d6-0242ac130003', '7e92d6e0-6dbe-11ec-90d6-0242ac130003', '7890123478901234', 'Luis Alvarez', '2019-12-01', '890', 0);

-- Additional inserts for Booking (property with guest capacity 0 and past booking date)
INSERT INTO "Booking" (bookingid, propertyid, userid, startingdate, endingdate) VALUES
('6b92d6e0-6dbe-11ec-90d6-0242ac130003', '6e92d6e0-6dbe-11ec-90d6-0242ac130003', '6e92d6e0-6dbe-11ec-90d6-0242ac130003', '2022-01-01 14:00:00', '2022-01-07 12:00:00'),
('7b92d6e0-6dbe-11ec-90d6-0242ac130003', '7e92d6e0-6dbe-11ec-90d6-0242ac130003', '7e92d6e0-6dbe-11ec-90d6-0242ac130003', '2023-12-01 14:00:00', '2023-12-05 12:00:00');

-- Additional inserts for Comment (bad comments with low ratings)
INSERT INTO "Comment" (bookingid, propertyid, userid, content, uploaddate, rating) VALUES
('6b92d6e0-6dbe-11ec-90d6-0242ac130003', '6e92d6e0-6dbe-11ec-90d6-0242ac130003', '6e92d6e0-6dbe-11ec-90d6-0242ac130003', 'Terrible experience, the place was dirty and the service was awful.', '2022-01-08 10:00:00', 1),
('7b92d6e0-6dbe-11ec-90d6-0242ac130003', '7e92d6e0-6dbe-11ec-90d6-0242ac130003', '7e92d6e0-6dbe-11ec-90d6-0242ac130003', 'Not worth the price, very disappointing.', '2023-12-06 12:00:00', 2);

-- Additional inserts for Bill (pending and paid bills)
INSERT INTO "Bill" (bookingid, propertyid, userid, billstatus) VALUES
('6b92d6e0-6dbe-11ec-90d6-0242ac130003', '6e92d6e0-6dbe-11ec-90d6-0242ac130003', '6e92d6e0-6dbe-11ec-90d6-0242ac130003', 'Pending'),
('7b92d6e0-6dbe-11ec-90d6-0242ac130003', '7e92d6e0-6dbe-11ec-90d6-0242ac130003', '7e92d6e0-6dbe-11ec-90d6-0242ac130003', 'Paid');
