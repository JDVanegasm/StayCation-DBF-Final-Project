from pydantic import BaseModel

class Bill(BaseModel):
    billId: int
    bookingId: str
    propertyId: str
    userId: str
    billStatus: str
