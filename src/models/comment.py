from pydantic import BaseModel

class Comment(BaseModel):
    commentId: int
    bookingId: str
    propertyId: str
    userId: str
    content: str
    uploadDate: str
    rating: int
