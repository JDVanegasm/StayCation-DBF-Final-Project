from pydantic import BaseModel

class Property(BaseModel):
    propertyId: str
    userId: str
    propertyTypeId: int
    propertyAddonId: int
    location: str
    guestsCapacity: int
    availableRooms: int
    availableBeds: int
    availableBaths: int
    media: str
    name: str
    description: str
    price: float
