from pydantic import BaseModel

class Booking(BaseModel):
    bookingId: str
    propertyId: str
    userId: str
    startingDate: str
    endingDate: str
