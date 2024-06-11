from pydantic import BaseModel

class User(BaseModel):
    userId: str
    userRole: str
    name: str
    email: str
    hashedPassword: str
    phone: str