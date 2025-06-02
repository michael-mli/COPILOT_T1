from datetime import datetime, timedelta
from app.models.auth import LoginRequest, Token, User
from app.core.security import verify_password, create_access_token, verify_token
from app.core.config import settings

class AuthService:
    def __init__(self):
        # Mock user data - in production this would use a database
        self.users = [
            {
                "id": 1,
                "email": "john.doe@example.com",
                "first_name": "John",
                "last_name": "Doe",
                "hashed_password": "$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW",  # password123
                "is_active": True,
                "user_type": "member"
            },
            {
                "id": 2,
                "email": "admin@caatpension.ca",
                "first_name": "Admin",
                "last_name": "User",
                "hashed_password": "$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW",  # admin123
                "is_active": True,
                "user_type": "admin"
            }
        ]
        
        # Store active tokens (in production use Redis or database)
        self.active_tokens = set()

    async def authenticate_user(self, login_data: LoginRequest) -> Token:
        # Find user by email
        user = None
        for u in self.users:
            if u["email"] == login_data.email:
                user = u
                break
        
        if not user or not verify_password(login_data.password, user["hashed_password"]):
            raise ValueError("Invalid email or password")
        
        if not user["is_active"]:
            raise ValueError("Account is inactive")
        
        # Create access token
        access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = create_access_token(
            data={"sub": user["email"], "user_type": user["user_type"]},
            expires_delta=access_token_expires
        )
        
        # Store token as active
        self.active_tokens.add(access_token)
        
        return Token(
            access_token=access_token,
            token_type="bearer",
            expires_in=settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60
        )

    async def logout_user(self, token: str) -> None:
        # Remove token from active tokens
        if token in self.active_tokens:
            self.active_tokens.remove(token)
        else:
            raise ValueError("Invalid token")

    async def verify_token(self, token: str) -> User:
        # Check if token is in active tokens
        if token not in self.active_tokens:
            raise ValueError("Token has been invalidated")
        
        # Verify token signature and expiration
        email = verify_token(token)
        if not email:
            # Remove invalid token
            self.active_tokens.discard(token)
            raise ValueError("Invalid or expired token")
        
        # Find user
        user = None
        for u in self.users:
            if u["email"] == email:
                user = u
                break
        
        if not user:
            raise ValueError("User not found")
        
        return User(
            id=user["id"],
            email=user["email"],
            first_name=user["first_name"],
            last_name=user["last_name"],
            is_active=user["is_active"],
            user_type=user["user_type"]
        )
