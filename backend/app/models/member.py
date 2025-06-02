from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

class MemberBase(BaseModel):
    email: EmailStr
    first_name: str
    last_name: str
    employee_id: Optional[str] = None
    employer_id: Optional[int] = None

class MemberCreate(MemberBase):
    password: str

class MemberUpdate(BaseModel):
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    email: Optional[EmailStr] = None
    phone: Optional[str] = None
    address: Optional[str] = None

class MemberLogin(BaseModel):
    email: EmailStr
    password: str

class Member(MemberBase):
    id: int
    is_active: bool
    created_at: datetime
    updated_at: Optional[datetime] = None
    
    class Config:
        from_attributes = True

class PensionInfo(BaseModel):
    member_id: int
    total_contributions: float
    employer_contributions: float
    member_contributions: float
    estimated_annual_pension: float
    years_of_service: float
    vesting_status: str
    last_updated: datetime
