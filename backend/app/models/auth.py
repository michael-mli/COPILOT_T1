from pydantic import BaseModel, EmailStr

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"
    expires_in: int

class TokenData(BaseModel):
    username: str = None

class User(BaseModel):
    id: int
    email: EmailStr
    first_name: str
    last_name: str
    is_active: bool
    user_type: str  # member, employer, admin
