/*StayCation DB; first Population with realistic Data*/

use staycation;	

insert into User (userid, userrole, name, email, hashedpassword, phone) values
('1e92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'Carlos Perez', 'carlos.perez@example.com', sha2('securepassword1', 256), '3201234567'),
('2e92d6e0-6dbe-11ec-90d6-0242ac120003', '2', 'Maria Lopez', 'maria.lopez@example.com', sha2('securepassword2', 256), '3107654321'),
('3e92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'Juan Martinez', 'juan.martinez@example.com', sha2('securepassword3', 256), '3009876543'),
('4e92d6e0-6dbe-11ec-90d6-0242ac120003', '2', 'Luisa Gomez', 'luisa.gomez@example.com', sha2('securepassword4', 256), '3156781234'),
('5e92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'David Fernandez', 'david.fernandez@example.com', sha2('securepassword5', 256), '3204567890'),
('6e92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'Ana Torres', 'ana.torres@example.com', sha2('securepassword6', 256), '3211234567'),
('7e92d6e0-6dbe-11ec-90d6-0242ac120003', '2', 'Jose Ramirez', 'jose.ramirez@example.com', sha2('securepassword7', 256), '3117654321'),
('8e92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'Laura Mendoza', 'laura.mendoza@example.com', sha2('securepassword8', 256), '3019876543'),
('9e92d6e0-6dbe-11ec-90d6-0242ac120003', '2', 'Pedro Rojas', 'pedro.rojas@example.com', sha2('securepassword9', 256), '3166781234'),
('ae92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'Sofia Blanco', 'sofia.blanco@example.com', sha2('securepassword10', 256), '3224567890');

insert into propertyType (name, description) values
('Apartment', 'A modern and comfortable apartment in the city center.'),
('House', 'A spacious house with a garden and pool.'),
('Cottage', 'A cozy cottage in the forest.'),
('Village', 'A luxury villa with sea views.'),
('Studio', 'A compact and well-equipped studio.'),
('Penthouse', 'A luxurious penthouse with city views.'),
('Bungalow', 'A small house with a garden.'),
('Cabin', 'A rustic cabin in the mountains.');

insert into propertyAddon (wifi, kitchen, parking, staffservice, pool, securitycameras, laundry, gym) values
(true, true, true, true, true, true, true, true),
(true, true, false, false, true, false, true, true),
(true, true, true, false, false, true, true, false),
(false, true, true, true, true, false, false, true),
(true, false, true, true, false, true, true, false),
(true, false, true, false, true, false, true, true),
(false, true, true, true, false, true, false, false),
(true, true, false, true, true, true, true, false);

insert into property (propertyid, userid, propertytypeid, propertyaddonid, location, guestscapacity, availablerooms, availablebeds, availablebaths, media, name, description, price) values
('1e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', 1, 1, '123 Street, City A', 4, 2, 2, 1, 'http://example.com/media1.jpg', 'Central Apartment', 'A modern and comfortable apartment in the city center.', 100.00),
('2e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', 2, 2, '456 Avenue, City B', 6, 3, 3, 2, 'http://example.com/media2.jpg', 'House with Garden', 'A spacious house with a garden and pool.', 200.00),
('3e92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', 3, 3, '789 Road, City C', 2, 1, 1, 1, 'http://example.com/media3.jpg', 'Forest Cottage', 'A cozy cottage in the forest.', 150.00),
('4e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', 4, 4, '101 Beach, City D', 8, 4, 4, 3, 'http://example.com/media4.jpg', 'Luxury Villa', 'A luxury villa with sea views.', 500.00),
('5e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', 5, 5, '202 Street, City E', 2, 1, 1, 1, 'http://example.com/media5.jpg', 'Modern Studio', 'A compact and well-equipped studio.', 80.00),
('6e92d6e0-6dbe-11ec-90d6-0242ac120003', '6e92d6e0-6dbe-11ec-90d6-0242ac120003', 6, 6, '303 Street, City F', 4, 2, 2, 2, 'http://example.com/media6.jpg', 'City Penthouse', 'A luxurious penthouse with city views.', 300.00),
('7e92d6e0-6dbe-11ec-90d6-0242ac120003', '8e92d6e0-6dbe-11ec-90d6-0242ac120003', 7, 7, '404 Avenue, City G', 5, 3, 3, 2, 'http://example.com/media7.jpg', 'Garden Bungalow', 'A small house with a garden.', 180.00),
('8e92d6e0-6dbe-11ec-90d6-0242ac120003', '7e92d6e0-6dbe-11ec-90d6-0242ac120003', 8, 8, '505 Road, City H', 3, 2, 2, 1, 'http://example.com/media8.jpg', 'Mountain Cabin', 'A rustic cabin in the mountains.', 120.00);

insert into card (cardid, userid, cardnumber, cardowner, duedate, cvv, balance) values
('1c92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '1234567812345678', 'Maria Lopez', '12/26', '123', 5000),
('2c92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '2345678923456789', 'Luisa Gomez', '11/25', '456', 3000),
('3c92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '3456789034567890', 'Juan Martinez', '10/24', '789', 7000),
('4c92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '4567890145678901', 'Carlos Perez', '09/23', '012', 6000),
('5c92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '5678901256789012', 'David Fernandez', '08/22', '345', 8000),
('6c92d6e0-6dbe-11ec-90d6-0242ac120003', '6e92d6e0-6dbe-11ec-90d6-0242ac120003', '6789012367890123', 'Ana Torres', '07/25', '678', 9000),
('7c92d6e0-6dbe-11ec-90d6-0242ac120003', '7e92d6e0-6dbe-11ec-90d6-0242ac120003', '7890123478901234', 'Jose Ramirez', '06/24', '890', 4000),
('8c92d6e0-6dbe-11ec-90d6-0242ac120003', '8e92d6e0-6dbe-11ec-90d6-0242ac120003', '8901234589012345', 'Laura Mendoza', '05/23', '234', 10000);

insert into booking (bookingid, propertyid, userid, startingdate, endingdate) values
('1b92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-06-01 14:00:00', '2024-06-07 12:00:00'),
('2b92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-07-01 14:00:00', '2024-07-05 12:00:00'),
('3b92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-08-01 14:00:00', '2024-08-03 12:00:00'),
('4b92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-09-01 14:00:00', '2024-09-10 12:00:00'),
('5b92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-10-01 14:00:00', '2024-10-04 12:00:00'),
('6b92d6e0-6dbe-11ec-90d6-0242ac120003', '6e92d6e0-6dbe-11ec-90d6-0242ac120003', '6e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-11-01 14:00:00', '2024-11-07 12:00:00'),
('7b92d6e0-6dbe-11ec-90d6-0242ac120003', '7e92d6e0-6dbe-11ec-90d6-0242ac120003', '7e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-12-01 14:00:00', '2024-12-05 12:00:00'),
('8b92d6e0-6dbe-11ec-90d6-0242ac120003', '8e92d6e0-6dbe-11ec-90d6-0242ac120003', '8e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-11-10 14:00:00', '2024-11-14 12:00:00');

insert into comment (bookingid, propertyid, userid, content, uploaddate, rating) values
('1b92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Excellent stay, highly recommended!', '2024-06-08 10:00:00', 5),
('2b92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', 'The house is very comfortable and well located.', '2024-07-06 12:00:00', 4),
('3b92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', 'The cottage is perfect for a retreat in nature.', '2024-08-04 09:00:00', 5),
('4b92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', 'A luxury experience, highly recommended.', '2024-09-11 11:00:00', 5),
('5b92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', 'A very well-located and comfortable studio.', '2024-10-05 08:00:00', 4),
('6b92d6e0-6dbe-11ec-90d6-0242ac120003', '6e92d6e0-6dbe-11ec-90d6-0242ac120003', '6e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Amazing penthouse with incredible views.', '2024-11-08 10:00:00', 5),
('7b92d6e0-6dbe-11ec-90d6-0242ac120003', '7e92d6e0-6dbe-11ec-90d6-0242ac120003', '7e92d6e0-6dbe-11ec-90d6-0242ac120003', 'A cozy and well-located bungalow.', '2024-12-06 12:00:00', 4),
('8b92d6e0-6dbe-11ec-90d6-0242ac120003', '8e92d6e0-6dbe-11ec-90d6-0242ac120003', '8e92d6e0-6dbe-11ec-90d6-0242ac120003', 'The perfect cabin for a mountain getaway.', '2024-11-15 09:00:00', 5);

insert into bill (bookingid, propertyid, userid, billstatus) values
('1b92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Paid'),
('2b92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Pending'),
('3b92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Paid'),
('4b92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Pending'),
('5b92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Paid'),
('6b92d6e0-6dbe-11ec-90d6-0242ac120003', '6e92d6e0-6dbe-11ec-90d6-0242ac120003', '6e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Paid'),
('7b92d6e0-6dbe-11ec-90d6-0242ac120003', '7e92d6e0-6dbe-11ec-90d6-0242ac120003', '7e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Pending'),
('8b92d6e0-6dbe-11ec-90d6-0242ac120003', '8e92d6e0-6dbe-11ec-90d6-0242ac120003', '8e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Paid');