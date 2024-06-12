from fastapi import FastAPI
from typing import List
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import uvicorn
import os

from models.user import User
from models.propertyType import PropertyType
from models.propertyAddon import PropertyAddon
from models.property import Property
from models.card import Card
from models.booking import Booking
from models.comment import Comment
from models.bill import Bill

# Initialize the FastAPI application with metadata
app = FastAPI(title="StayCation DB API", description="API for StayCation Database", version="0.1")

# Database URLs from environment variables
mysql_db_url = os.getenv("MYSQL_DB_URL", "mysql://root:P4ssw0rd@mysql_db:3306/staycation")
postgresql_db_url = os.getenv("POSTGRESQL_DB_URL", "postgresql://postgres:P4ssw0rd@postgres_db:5432/staycation")

# Create engines and sessions for both databases
mysql_engine = create_engine(mysql_db_url)
postgresql_engine = create_engine(postgresql_db_url)

MysqlSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=mysql_engine)
PostgresqlSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=postgresql_engine)

@app.get("/")
def healthcheck():
    """This endpoint is used to check if the web API is running."""
    return {"status": "ok"}

@app.post("/user/add/mysql", status_code=201)
def add_user_mysql(user: User):
    """Add a new user to the MySQL database."""
    db = MysqlSessionLocal()
    query = f"insert into user (userId, userRole, name, email, hashedPassword, phone) values ('{user.userId}', '{user.userRole}', '{user.name}', '{user.email}', '{user.hashedPassword}', '{user.phone}')"
    db.execute(query)
    db.commit()
    db.close()
    return None

@app.post("/user/add/postgresql", status_code=201)
def add_user_postgresql(user: User):
    """Add a new user to the PostgreSQL database."""
    db = PostgresqlSessionLocal()
    query = f"insert into user (userId, userRole, name, email, hashedPassword, phone) values ('{user.userId}', '{user.userRole}', '{user.name}', '{user.email}', '{user.hashedPassword}', '{user.phone}')"
    db.execute(query)
    db.commit()
    db.close()
    return None

@app.get("/users/mysql", response_model=List[User])
def get_all_users_mysql():
    """Retrieve all users from the MySQL database."""
    db = MysqlSessionLocal()
    query = "select * from user"
    result = db.execute(query).fetchall()
    users = [User(**row) for row in result]
    db.close()
    return users

@app.get("/users/postgresql", response_model=List[User])
def get_all_users_postgresql():
    """Retrieve all users from the PostgreSQL database."""
    db = PostgresqlSessionLocal()
    query = "select * from user"
    result = db.execute(query).fetchall()
    users = [User(**row) for row in result]
    db.close()
    return users

@app.get("/users/role/mysql/{role}", response_model=List[User])
def get_users_by_role_mysql(role: str):
    """Retrieve users from the MySQL database based on their role."""
    db = MysqlSessionLocal()
    query = f"select userId, name, email, phone from user where userRole = '{role}'"
    result = db.execute(query).fetchall()
    users = [User(**row) for row in result]
    db.close()
    return users

@app.get("/users/role/postgresql/{role}", response_model=List[User])
def get_users_by_role_postgresql(role: str):
    """Retrieve users from the PostgreSQL database based on their role."""
    db = PostgresqlSessionLocal()
    query = f"select userId, name, email, phone from user where userRole = '{role}'"
    result = db.execute(query).fetchall()
    users = [User(**row) for row in result]
    db.close()
    return users

@app.get("/properties/type/mysql/{type}", response_model=List[Property])
def get_properties_by_type_mysql(type: str):
    """Retrieve properties from the MySQL database based on their type."""
    db = MysqlSessionLocal()
    query = f"""
    select p.propertyId, p.name as propertyName, p.description as propertyDescription, pt.name as propertyType, p.price
    from property p
    join propertyType pt on p.propertyTypeId = pt.propertyTypeId
    where pt.name = '{type}'
    """
    result = db.execute(query).fetchall()
    properties = [Property(**row) for row in result]
    db.close()
    return properties

@app.get("/properties/type/postgresql/{type}", response_model=List[Property])
def get_properties_by_type_postgresql(type: str):
    """Retrieve properties from the PostgreSQL database based on their type."""
    db = PostgresqlSessionLocal()
    query = f"""
    select p.propertyId, p.name as propertyName, p.description as propertyDescription, pt.name as propertyType, p.price
    from property p
    join propertyType pt on p.propertyTypeId = pt.propertyTypeId
    where pt.name = '{type}'
    """
    result = db.execute(query).fetchall()
    properties = [Property(**row) for row in result]
    db.close()
    return properties

@app.get("/bookings/date/mysql/{date}", response_model=List[Booking])
def get_bookings_by_date_mysql(date: str):
    """Retrieve bookings from the MySQL database that start on a specific date."""
    db = MysqlSessionLocal()
    query = f"select bookingId, propertyId, userId, startingDate, endingDate from booking where date(startingDate) = '{date}'"
    result = db.execute(query).fetchall()
    bookings = [Booking(**row) for row in result]
    db.close()
    return bookings

@app.get("/bookings/date/postgresql/{date}", response_model=List[Booking])
def get_bookings_by_date_postgresql(date: str):
    """Retrieve bookings from the PostgreSQL database that start on a specific date."""
    db = PostgresqlSessionLocal()
    query = f"select bookingId, propertyId, userId, startingDate, endingDate from booking where date(startingDate) = '{date}'"
    result = db.execute(query).fetchall()
    bookings = [Booking(**row) for row in result]
    db.close()
    return bookings

@app.get("/properties/mysql", response_model=List[Property])
def get_all_properties_mysql():
    """Retrieve all properties from the MySQL database with detailed information."""
    db = MysqlSessionLocal()
    query = """
    select 
        p.propertyId, p.name as propertyName, p.description as propertyDescription, pt.name as propertyType, 
        pa.wifi, pa.kitchen, pa.parking, pa.staffService, pa.pool, pa.securityCameras, pa.laundry, pa.gym, 
        p.location, p.guestsCapacity, p.availableRooms, p.availableBeds, p.availableBaths, p.media, p.price
    from 
        property p
    join 
        propertyType pt on p.propertyTypeId = pt.propertyTypeId
    join 
        propertyAddon pa on p.propertyAddonId = pa.propertyAddonId
    """
    result = db.execute(query).fetchall()
    properties = [Property(**row) for row in result]
    db.close()
    return properties

@app.get("/properties/postgresql", response_model=List[Property])
def get_all_properties_postgresql():
    """Retrieve all properties from the PostgreSQL database with detailed information."""
    db = PostgresqlSessionLocal()
    query = """
    select 
        p.propertyId, p.name as propertyName, p.description as propertyDescription, pt.name as propertyType, 
        pa.wifi, pa.kitchen, pa.parking, pa.staffService, pa.pool, pa.securityCameras, pa.laundry, pa.gym, 
        p.location, p.guestsCapacity, p.availableRooms, p.availableBeds, p.availableBaths, p.media, p.price
    from 
        property p
    join 
        propertyType pt on p.propertyTypeId = pt.propertyTypeId
    join 
        propertyAddon pa on p.propertyAddonId = pa.propertyAddonId
    """
    result = db.execute(query).fetchall()
    properties = [Property(**row) for row in result]
    db.close()
    return properties

@app.get("/bookings/user/mysql/{userId}", response_model=List[Booking])
def get_bookings_by_user_mysql(userId: str):
    """Retrieve all bookings from the MySQL database made by a specific user."""
    db = MysqlSessionLocal()
    query = f"""
    select b.bookingId, b.propertyId, p.name as propertyName, b.startingDate, b.endingDate
    from booking b
    join property p on b.propertyId = p.propertyId
    where b.userId = '{userId}'
    """
    result = db.execute(query).fetchall()
    bookings = [Booking(**row) for row in result]
    db.close()
    return bookings

@app.get("/bookings/user/postgresql/{userId}", response_model=List[Booking])
def get_bookings_by_user_postgresql(userId: str):
    """Retrieve all bookings from the PostgreSQL database made by a specific user."""
    db = PostgresqlSessionLocal()
    query = f"""
    select b.bookingId, b.propertyId, p.name as propertyName, b.startingDate, b.endingDate
    from booking b
    join property p on b.propertyId = p.propertyId
    where b.userId = '{userId}'
    """
    result = db.execute(query).fetchall()
    bookings = [Booking(**row) for row in result]
    db.close()
    return bookings

@app.get("/bills/booking/mysql/{bookingId}", response_model=List[Bill])
def get_bill_by_booking_mysql(bookingId: str):
    """Retrieve the bill from the MySQL database for a specific booking."""
    db = MysqlSessionLocal()
    query = f"""
    select b.billId, b.bookingId, p.name as propertyName, b.billStatus
    from bill b
    join property p on b.propertyId = p.propertyId
    where b.bookingId = '{bookingId}'
    """
    result = db.execute(query).fetchall()
    bills = [Bill(**row) for row in result]
    db.close()
    return bills

@app.get("/bills/booking/postgresql/{bookingId}", response_model=List[Bill])
def get_bill_by_booking_postgresql(bookingId: str):
    """Retrieve the bill from the PostgreSQL database for a specific booking."""
    db = PostgresqlSessionLocal()
    query = f"""
    select b.billId, b.bookingId, p.name as propertyName, b.billStatus
    from bill b
    join property p on b.propertyId = p.propertyId
    where b.bookingId = '{bookingId}'
    """
    result = db.execute(query).fetchall()
    bills = [Bill(**row) for row in result]
    db.close()
    return bills

@app.get("/properties/availability/mysql", response_model=List[Property])
def get_properties_by_availability_mysql(beds: int, baths: int):
    """Retrieve properties from the MySQL database with a specific number of available beds and baths."""
    db = MysqlSessionLocal()
    query = f"""
    select p.propertyId, p.name as propertyName, p.description as propertyDescription, p.guestsCapacity, p.availableRooms, 
    p.availableBeds, p.availableBaths, p.price
    from property p
    where p.availableBeds >= {beds} and p.availableBaths >= {baths}
    """
    result = db.execute(query).fetchall()
    properties = [Property(**row) for row in result]
    db.close()
    return properties

@app.get("/properties/availability/postgresql", response_model=List[Property])
def get_properties_by_availability_postgresql(beds: int, baths: int):
    """Retrieve properties from the PostgreSQL database with a specific number of available beds and baths."""
    db = PostgresqlSessionLocal()
    query = f"""
    select p.propertyId, p.name as propertyName, p.description as propertyDescription, p.guestsCapacity, p.availableRooms, 
    p.availableBeds, p.availableBaths, p.price
    from property p
    where p.availableBeds >= {beds} and p.availableBaths >= {baths}
    """
    result = db.execute(query).fetchall()
    properties = [Property(**row) for row in result]
    db.close()
    return properties

@app.get("/cards/user/mysql/{userId}/total_balance")
def get_total_balance_mysql(userId: str):
    """Retrieve the total balance of all credit cards from the MySQL database for a specific user."""
    db = MysqlSessionLocal()
    query = f"""
    select sum(c.balance) as totalBalance
    from card c
    where c.userId = '{userId}'
    group by c.userId
    """
    result = db.execute(query).fetchone()
    db.close()
    return {"totalBalance": result[0]}

@app.get("/cards/user/postgresql/{userId}/total_balance")
def get_total_balance_postgresql(userId: str):
    """Retrieve the total balance of all credit cards from the PostgreSQL database for a specific user."""
    db = PostgresqlSessionLocal()
    query = f"""
    select sum(c.balance) as totalBalance
    from card c
    where c.userId = '{userId}'
    group by c.userId
    """
    result = db.execute(query).fetchone()
    db.close()
    return {"totalBalance": result[0]}

@app.get("/cards/user/mysql/{userId}", response_model=List[Card])
def get_cards_by_user_mysql(userId: str):
    """Retrieve all credit cards from the MySQL database for a specific user."""
    db = MysqlSessionLocal()
    query = f"""
    select cardId, cardNumber, cardOwner, dueDate, balance
    from card
    where userId = '{userId}'
    """
    result = db.execute(query).fetchall()
    cards = [Card(**row) for row in result]
    db.close()
    return cards

@app.get("/cards/user/postgresql/{userId}", response_model=List[Card])
def get_cards_by_user_postgresql(userId: str):
    """Retrieve all credit cards from the PostgreSQL database for a specific user."""
    db = PostgresqlSessionLocal()
    query = f"""
    select cardId, cardNumber, cardOwner, dueDate, balance
    from card
    where userId = '{userId}'
    """
    result = db.execute(query).fetchall()
    cards = [Card(**row) for row in result]
    db.close()
    return cards

@app.get("/properties/count_by_type/mysql")
def get_properties_count_by_type_mysql():
    """Retrieve the total number of properties by type from the MySQL database."""
    db = MysqlSessionLocal()
    query = """
    select pt.name as propertyType, count(p.propertyId) as totalProperties
    from property p
    join propertyType pt on p.propertyTypeId = pt.propertyTypeId
    group by pt.name
    """
    result = db.execute(query).fetchall()
    db.close()
    return [{"propertyType": row[0], "totalProperties": row[1]} for row in result]

@app.get("/properties/count_by_type/postgresql")
def get_properties_count_by_type_postgresql():
    """Retrieve the total number of properties by type from the PostgreSQL database."""
    db = PostgresqlSessionLocal()
    query = """
    select pt.name as propertyType, count(p.propertyId) as totalProperties
    from property p
    join propertyType pt on p.propertyTypeId = pt.propertyTypeId
    group by pt.name
    """
    result = db.execute(query).fetchall()
    db.close()
    return [{"propertyType": row[0], "totalProperties": row[1]} for row in result]

@app.get("/properties/{propertyId}/average_rating/mysql")
def get_property_average_rating_mysql(propertyId: str):
    """Retrieve the average rating for a specific property from the MySQL database."""
    db = MysqlSessionLocal()
    query = f"""
    select avg(rating) as averageRating
    from comment
    where propertyId = '{propertyId}'
    group by propertyId
    """
    result = db.execute(query).fetchone()
    db.close()
    return {"propertyId": propertyId, "averageRating": result[0]}

@app.get("/properties/{propertyId}/average_rating/postgresql")
def get_property_average_rating_postgresql(propertyId: str):
    """Retrieve the average rating for a specific property from the PostgreSQL database."""
    db = PostgresqlSessionLocal()
    query = f"""
    select avg(rating) as averageRating
    from comment
    where propertyId = '{propertyId}'
    group by propertyId
    """
    result = db.execute(query).fetchone()
    db.close()
    return {"propertyId": propertyId, "averageRating": result[0]}

@app.get("/bills/pending/mysql", response_model=List[Bill])
def get_pending_bills_mysql():
    """Retrieve all pending bills from the MySQL database."""
    db = MysqlSessionLocal()
    query = """
    select billId, bookingId, propertyId, userId, billStatus
    from bill
    where billStatus = 'pending'
    """
    result = db.execute(query).fetchall()
    bills = [Bill(**row) for row in result]
    db.close()
    return bills

@app.get("/bills/pending/postgresql", response_model=List[Bill])
def get_pending_bills_postgresql():
    """Retrieve all pending bills from the PostgreSQL database."""
    db = PostgresqlSessionLocal()
    query = """
    select billId, bookingId, propertyId, userId, billStatus
    from bill
    where billStatus = 'pending'
    """
    result = db.execute(query).fetchall()
    bills = [Bill(**row) for row in result]
    db.close()
    return bills

@app.get("/comments/user/mysql/{userId}", response_model=List[Comment])
def get_comments_by_user_mysql(userId: str):
    """Retrieve all comments made by a specific user from the MySQL database."""
    db = MysqlSessionLocal()
    query = f"""
    select c.commentId, c.content, c.uploadDate, c.rating, p.name as propertyName
    from comment c
    join property p on c.propertyId = p.propertyId
    where c.userId = '{userId}'
    """
    result = db.execute(query).fetchall()
    comments = [Comment(**row) for row in result]
    db.close()
    return comments

@app.get("/comments/user/postgresql/{userId}", response_model=List[Comment])
def get_comments_by_user_postgresql(userId: str):
    """Retrieve all comments made by a specific user from the PostgreSQL database."""
    db = PostgresqlSessionLocal()
    query = f"""
    select c.commentId, c.content, c.uploadDate, c.rating, p.name as propertyName
    from comment c
    join property p on c.propertyId = p.propertyId
    where c.userId = '{userId}'
    """
    result = db.execute(query).fetchall()
    comments = [Comment(**row) for row in result]
    db.close()
    return comments

@app.get("/bookings/ending_date/mysql/{date}", response_model=List[Booking])
def get_bookings_by_ending_date_mysql(date: str):
    """Retrieve bookings from the MySQL database that end on a specific date."""
    db = MysqlSessionLocal()
    query = f"select bookingId, propertyId, userId, startingDate, endingDate from booking where date(endingDate) = '{date}'"
    result = db.execute(query).fetchall()
    bookings = [Booking(**row) for row in result]
    db.close()
    return bookings

@app.get("/bookings/ending_date/postgresql/{date}", response_model=List[Booking])
def get_bookings_by_ending_date_postgresql(date: str):
    """Retrieve bookings from the PostgreSQL database that end on a specific date."""
    db = PostgresqlSessionLocal()
    query = f"select bookingId, propertyId, userId, startingDate, endingDate from booking where date(endingDate) = '{date}'"
    result = db.execute(query).fetchall()
    bookings = [Booking(**row) for row in result]
    db.close()
    return bookings

@app.get("/users/no_bookings/mysql", response_model=List[User])
def get_users_with_no_bookings_mysql():
    """Retrieve users from the MySQL database who have not made any bookings."""
    db = MysqlSessionLocal()
    query = """
    select u.userId, u.name, u.email
    from user u
    left join booking b on u.userId = b.userId
    where b.userId is null
    """
    result = db.execute(query).fetchall()
    users = [User(**row) for row in result]
    db.close()
    return users

@app.get("/users/no_bookings/postgresql", response_model=List[User])
def get_users_with_no_bookings_postgresql():
    """Retrieve users from the PostgreSQL database who have not made any bookings."""
    db = PostgresqlSessionLocal()
    query = """
    select u.userId, u.name, u.email
    from user u
    left join booking b on u.userId = b.userId
    where b.userId is null
    """
    result = db.execute(query).fetchall()
    users = [User(**row) for row in result]
    db.close()
    return users

@app.get("/properties/addon/pool/mysql", response_model=List[Property])
def get_properties_with_pool_mysql():
    """Retrieve all properties from the MySQL database that have a pool."""
    db = MysqlSessionLocal()
    query = """
    select p.propertyId, p.name as propertyName, p.description as propertyDescription, p.price
    from property p
    join propertyAddon pa on p.propertyAddonId = pa.propertyAddonId
    where pa.pool = true
    """
    result = db.execute(query).fetchall()
    properties = [Property(**row) for row in result]
    db.close()
    return properties

@app.get("/properties/addon/pool/postgresql", response_model=List[Property])
def get_properties_with_pool_postgresql():
    """Retrieve all properties from the PostgreSQL database that have a pool."""
    db = PostgresqlSessionLocal()
    query = """
    select p.propertyId, p.name as propertyName, p.description as propertyDescription, p.price
    from property p
    join propertyAddon pa on p.propertyAddonId = pa.propertyAddonId
    where pa.pool = true
    """
    result = db.execute(query).fetchall()
    properties = [Property(**row) for row in result]
    db.close()
    return properties

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)