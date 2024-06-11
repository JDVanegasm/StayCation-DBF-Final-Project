from pydantic import BaseModel

class PropertyType(BaseModel):
    propertyTypeId: int
    name: str
    description: str
