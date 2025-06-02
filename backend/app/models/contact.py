from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

class ContactForm(BaseModel):
    name: str
    email: EmailStr
    phone: Optional[str] = None
    subject: str
    message: str
    member_id: Optional[str] = None
    inquiry_type: str = "general"  # general, member_services, employer_services

class ContactResponse(BaseModel):
    success: bool
    message: str
    reference_number: str
    estimated_response_time: str = "1-2 business days"
