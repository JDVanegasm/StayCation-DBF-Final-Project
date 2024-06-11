drop database if exists staycation;

create database staycation;

use staycation;

-- User table creation
create table User (
    userId varchar(36) primary key,
    userRole varchar(1) not null,
    name varchar(50) not null,
    email varchar(60) unique not null,
    hashedPassword varchar (64) not null, -- use SHA-256
    phone varchar(20) unique not null
);

-- Property Type table creation
create table PropertyType (
    propertyTypeId int primary key auto_increment,
    name varchar(50) unique not null,
    description varchar(200) not null
);

-- Property Addons table creation
create table PropertyAddon (
    propertyAddonId int primary key auto_increment,
    wifi boolean default false,
    kitchen boolean default false,
    parking boolean default false,
    staffService boolean default false,
    pool boolean default false,
    securityCameras boolean default false,
    laundry boolean default false,
    gym boolean default false
);

-- Property table creation
create table Property (
    propertyId varchar(36) primary key,
    userId varchar(36) not null,
    propertyTypeId int not null,
    propertyAddonId int not null,
    location varchar(100) not null,
    guestsCapacity int check(guestsCapacity > 0),
    availableRooms int check(availableRooms > 0),
    availableBeds int check(availableBeds > 0),
    availableBaths int check(availableBaths > 0),
    media varchar(200) not null, -- Url
    name varchar(25) unique not null,
    description varchar(200) not null,
    price decimal(10,2) not null,
    foreign key (userId) references User(userId),
    foreign key (propertyTypeId) references PropertyType(propertyTypeId),
    foreign key (propertyAddonId) references PropertyAddon(propertyAddonId)
);

-- Card table creation
create table Card (
    cardId varchar(36) primary key,
    userId varchar(36) not null,
    cardNumber varchar(28) not null,
    cardOwner varchar(50) not null,
    dueDate varchar(5) not null,
    cvv varchar(5) not null, -- i.e: 07/28 
    balance int check(balance > 0),
    foreign key(userId) references User(userId)
);

-- Booking table creation
create table Booking (
    bookingId varchar(36) primary key,
    propertyId varchar(36) not null,
    userId varchar(36) not null,
    startingDate timestamp default current_timestamp,
    endingDate timestamp null,
    foreign key (propertyId) references Property(propertyId),
    foreign key (userId) references User(userId)
);

-- Comment table creation
create table Comment (
    commentId int primary key auto_increment,
    bookingId varchar(36) not null,
    propertyId varchar(36) not null,
    userId varchar(36) not null,
    content varchar(500) not null,
    uploadDate timestamp default current_timestamp,
    rating int check (rating >= 0 AND rating <= 5),
    foreign key (propertyId) references Property(propertyId),
    foreign key (bookingId) references Booking(bookingId),
    foreign key (userId) references User(userId)
);

-- Bill table creation
create table Bill (
    billId int primary key auto_increment,
    bookingId varchar(36) not null,
    propertyId varchar(36) not null,
    userId varchar(36) not null,
    billStatus varchar(15) not null,
    foreign key (bookingId) references Booking(bookingId),
    foreign key (propertyId) references Property(propertyId)
);
