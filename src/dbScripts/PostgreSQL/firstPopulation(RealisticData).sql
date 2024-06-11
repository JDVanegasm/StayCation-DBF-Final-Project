-- StayCation DB; first Population with realistic Data

\c staycation;

INSERT INTO "User" (userid, userrole, name, email, hashedpassword, phone) VALUES
('1e92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'Carlos Perez', 'carlos.perez@example.com', crypt('securepassword1', gen_salt('bf')), '3201234567'),
('2e92d6e0-6dbe-11ec-90d6-0242ac120003', '2', 'Maria Lopez', 'maria.lopez@example.com', crypt('securepassword2', gen_salt('bf')), '3107654321'),
('3e92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'Juan Martinez', 'juan.martinez@example.com', crypt('securepassword3', gen_salt('bf')), '3009876543'),
('4e92d6e0-6dbe-11ec-90d6-0242ac120003', '2', 'Luisa Gomez', 'luisa.gomez@example.com', crypt('securepassword4', gen_salt('bf')), '3156781234'),
('5e92d6e0-6dbe-11ec-90d6-0242ac120003', '1', 'David Fernandez', 'david.fernandez@example.com', crypt('securepassword5', gen_salt('bf')), '3204567890');

INSERT INTO propertyType (name, description) VALUES
('Apartment', 'A modern and comfortable apartment in the city center.'),
('House', 'A spacious house with a garden and pool.'),
('Cottage', 'A cozy cottage in the forest.'),
('Village', 'A luxury villa with sea views.'),
('Studio', 'A compact and well-equipped studio.');

INSERT INTO propertyAddon (wifi, kitchen, parking, staffservice, pool, securitycameras, laundry, gym) VALUES
(true, true, true, true, true, true, true, true),
(true, true, false, false, true, false, true, true),
(true, true, true, false, false, true, true, false),
(false, true, true, true, true, false, false, true),
(true, false, true, true, false, true, true, false);

INSERT INTO property (propertyid, userid, propertytypeid, propertyaddonid, location, guestscapacity, availablerooms, availablebeds, availablebaths, media, name, description, price) VALUES
('1e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', 1, 1, '123 Street, City A', 4, 2, 2, 1, 'http://example.com/media1.jpg', 'Central Apartment', 'A modern and comfortable apartment in the city center.', 100.00),
('2e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', 2, 2, '456 Avenue, City B', 6, 3, 3, 2, 'http://example.com/media2.jpg', 'House with Garden', 'A spacious house with a garden and pool.', 200.00),
('3e92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', 3, 3, '789 Road, City C', 2, 1, 1, 1, 'http://example.com/media3.jpg', 'Forest Cottage', 'A cozy cottage in the forest.', 150.00),
('4e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', 4, 4, '101 Beach, City D', 8, 4, 4, 3, 'http://example.com/media4.jpg', 'Luxury Villa', 'A luxury villa with sea views.', 500.00),
('5e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', 5, 5, '202 Street, City E', 2, 1, 1, 1, 'http://example.com/media5.jpg', 'Modern Studio', 'A compact and well-equipped studio.', 80.00);

INSERT INTO card (cardid, userid, cardnumber, cardowner, duedate, cvv, balance) VALUES
('1c92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '1234567812345678', 'Maria Lopez', '2026-12', '123', 5000),
('2c92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '2345678923456789', 'Luisa Gomez', '2025-11', '456', 3000),
('3c92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '3456789034567890', 'Juan Martinez', '2024-10', '789', 7000),
('4c92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '4567890145678901', 'Carlos Perez', '2023-09', '012', 6000),
('5c92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '5678901256789012', 'David Fernandez', '2022-08', '345', 8000);

INSERT INTO booking (bookingid, propertyid, userid, startingdate, endingdate) VALUES
('1b92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-06-01 14:00:00', '2024-06-07 12:00:00'),
('2b92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-07-01 14:00:00', '2024-07-05 12:00:00'),
('3b92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-08-01 14:00:00', '2024-08-03 12:00:00'),
('4b92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-09-01 14:00:00', '2024-09-10 12:00:00'),
('5b92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '2024-10-01 14:00:00', '2024-10-04 12:00:00');

INSERT INTO comment (bookingid, propertyid, userid, content, uploaddate, rating) VALUES
('1b92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Excellent stay, highly recommended!', '2024-06-08 10:00:00', 5),
('2b92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', 'The house is very comfortable and well located.', '2024-07-06 12:00:00', 4),
('3b92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', 'The cottage is perfect for a retreat in nature.', '2024-08-04 09:00:00', 5),
('4b92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', 'A luxury experience, highly recommended.', '2024-09-11 11:00:00', 5),
('5b92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', 'A very well-located and comfortable studio.', '2024-10-05 08:00:00', 4);

INSERT INTO bill (bookingid, propertyid, userid, billstatus) VALUES
('1b92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Paid'),
('2b92d6e0-6dbe-11ec-90d6-0242ac120003', '2e92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Pending'),
('3b92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', '3e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Paid'),
('4b92d6e0-6dbe-11ec-90d6-0242ac120003', '4e92d6e0-6dbe-11ec-90d6-0242ac120003', '1e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Pending'),
('5b92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', '5e92d6e0-6dbe-11ec-90d6-0242ac120003', 'Paid');
