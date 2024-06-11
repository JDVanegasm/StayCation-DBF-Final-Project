from pydantic import BaseModel

class Card(BaseModel):
    cardId: str
    userId: str
    cardNumber: str
    cardOwner: str
    dueDate: str
    cvv: str
    balance: int
