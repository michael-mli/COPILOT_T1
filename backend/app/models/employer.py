from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime

class EmployerBase(BaseModel):
    name: str
    sector: str
    status: str = "active"
    join_date: datetime

class EmployerCreate(EmployerBase):
    pass

class Employer(EmployerBase):
    id: int
    employee_count: int
    contact_person: Optional[str] = None
    contact_email: Optional[str] = None
    
    class Config:
        from_attributes = True

class EmployerService(BaseModel):
    id: int
    name: str
    description: str
    category: str
    available: bool = True
    cost: Optional[float] = None
