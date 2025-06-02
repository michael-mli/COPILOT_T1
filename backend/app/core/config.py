from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    PROJECT_NAME: str = "CAAT Pension API"
    API_V1_STR: str = "/api/v1"
    SECRET_KEY: str = "change-this-secret-key"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    DATABASE_URL: str = "sqlite:///./caat_pension.db"
    DEBUG: bool = False
    
    class Config:
        env_file = ".env"

settings = Settings()
