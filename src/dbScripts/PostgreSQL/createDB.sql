-- Drop the database if it exists
DROP DATABASE IF EXISTS staycation;

-- Create the database
CREATE DATABASE staycation;

-- Connect to the database
\c staycation;

-- User table creation
CREATE TABLE "User" (
    userId UUID PRIMARY KEY,
    userRole CHAR(1) NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    hashedPassword VARCHAR(64) NOT NULL, -- use SHA-256
    phone VARCHAR(20) UNIQUE NOT NULL
);

-- Property Type table creation
CREATE TABLE "PropertyType" (
    propertyTypeId SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(200) NOT NULL
);

-- Property Addons table creation
CREATE TABLE "PropertyAddon" (
    propertyAddonId SERIAL PRIMARY KEY,
    wifi BOOLEAN DEFAULT FALSE,
    kitchen BOOLEAN DEFAULT FALSE,
    parking BOOLEAN DEFAULT FALSE,
    staffService BOOLEAN DEFAULT FALSE,
    pool BOOLEAN DEFAULT FALSE,
    securityCameras BOOLEAN DEFAULT FALSE,
    laundry BOOLEAN DEFAULT FALSE,
    gym BOOLEAN DEFAULT FALSE
);

-- Property table creation
CREATE TABLE "Property" (
    propertyId UUID PRIMARY KEY,
    userId UUID NOT NULL,
    propertyTypeId INT NOT NULL,
    propertyAddonId INT NOT NULL,
    location VARCHAR(100) NOT NULL,
    guestsCapacity INT CHECK(guestsCapacity > 0),
    availableRooms INT CHECK(availableRooms > 0),
    availableBeds INT CHECK(availableBeds > 0),
    availableBaths INT CHECK(availableBaths > 0),
    media VARCHAR(200) NOT NULL, -- URL
    name VARCHAR(25) UNIQUE NOT NULL,
    description VARCHAR(200) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (userId) REFERENCES "User"(userId),
    FOREIGN KEY (propertyTypeId) REFERENCES "PropertyType"(propertyTypeId),
    FOREIGN KEY (propertyAddonId) REFERENCES "PropertyAddon"(propertyAddonId)
);

-- Card table creation
CREATE TABLE "Card" (
    cardId UUID PRIMARY KEY,
    userId UUID NOT NULL,
    cardNumber VARCHAR(28) NOT NULL,
    cardOwner VARCHAR(50) NOT NULL,
    dueDate VARCHAR(5) NOT NULL,
    cvv VARCHAR(5) NOT NULL, -- i.e: 07/28
    balance INT CHECK(balance > 0),
    FOREIGN KEY (userId) REFERENCES "User"(userId)
);

-- Booking table creation
CREATE TABLE "Booking" (
    bookingId UUID PRIMARY KEY,
    propertyId UUID NOT NULL,
    userId UUID NOT NULL,
    startingDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    endingDate TIMESTAMP NULL,
    FOREIGN KEY (propertyId) REFERENCES "Property"(propertyId),
    FOREIGN KEY (userId) REFERENCES "User"(userId)
);

-- Comment table creation
CREATE TABLE "Comment" (
    commentId SERIAL PRIMARY KEY,
    bookingId UUID NOT NULL,
    propertyId UUID NOT NULL,
    userId UUID NOT NULL,
    content VARCHAR(500) NOT NULL,
    uploadDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rating INT CHECK (rating >= 0 AND rating <= 5),
    FOREIGN KEY (propertyId) REFERENCES "Property"(propertyId),
    FOREIGN KEY (bookingId) REFERENCES "Booking"(bookingId),
    FOREIGN KEY (userId) REFERENCES "User"(userId)
);

-- Bill table creation
CREATE TABLE "Bill" (
    billId SERIAL PRIMARY KEY,
    bookingId UUID NOT NULL,
    propertyId UUID NOT NULL,
    userId UUID NOT NULL,
    billStatus VARCHAR(15) NOT NULL,
    FOREIGN KEY (bookingId) REFERENCES "Booking"(bookingId),
    FOREIGN KEY (propertyId) REFERENCES "Property"(propertyId)
);
