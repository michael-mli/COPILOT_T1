from typing import List, Optional
from datetime import datetime
from app.models.member import Member, MemberCreate, MemberUpdate, MemberLogin, PensionInfo
from app.core.security import verify_password, get_password_hash, create_access_token, verify_token

class MemberService:
    def __init__(self):
        # Mock data - in production this would use a database
        self.members = [
            {
                "id": 1,
                "email": "john.doe@example.com",
                "first_name": "John",
                "last_name": "Doe",
                "employee_id": "EMP001",
                "employer_id": 1,
                "hashed_password": get_password_hash("password123"),
                "is_active": True,
                "created_at": datetime.now(),
                "updated_at": None
            }
        ]
        
        self.pension_data = [
            {
                "member_id": 1,
                "total_contributions": 45000.00,
                "employer_contributions": 27000.00,
                "member_contributions": 18000.00,
                "estimated_annual_pension": 12500.00,
                "years_of_service": 5.5,
                "vesting_status": "vested",
                "last_updated": datetime.now()
            }
        ]

    async def create_member(self, member_data: MemberCreate) -> Member:
        # Check if email already exists
        for member in self.members:
            if member["email"] == member_data.email:
                raise ValueError("Email already registered")
        
        # Create new member
        new_member = {
            "id": len(self.members) + 1,
            "email": member_data.email,
            "first_name": member_data.first_name,
            "last_name": member_data.last_name,
            "employee_id": member_data.employee_id,
            "employer_id": member_data.employer_id,
            "hashed_password": get_password_hash(member_data.password),
            "is_active": True,
            "created_at": datetime.now(),
            "updated_at": None
        }
        
        self.members.append(new_member)
        return Member(**{k: v for k, v in new_member.items() if k != "hashed_password"})

    async def authenticate_member(self, login_data: MemberLogin) -> str:
        # Find member by email
        member = None
        for m in self.members:
            if m["email"] == login_data.email:
                member = m
                break
        
        if not member or not verify_password(login_data.password, member["hashed_password"]):
            raise ValueError("Invalid email or password")
        
        if not member["is_active"]:
            raise ValueError("Account is inactive")
        
        # Create access token
        access_token = create_access_token(data={"sub": member["email"]})
        return access_token

    async def get_member_by_token(self, token: str) -> Member:
        email = verify_token(token)
        if not email:
            raise ValueError("Invalid token")
        
        member = None
        for m in self.members:
            if m["email"] == email:
                member = m
                break
        
        if not member:
            raise ValueError("Member not found")
        
        return Member(**{k: v for k, v in member.items() if k != "hashed_password"})

    async def update_member_by_token(self, token: str, member_update: MemberUpdate) -> Member:
        email = verify_token(token)
        if not email:
            raise ValueError("Invalid token")
        
        member = None
        member_index = None
        for i, m in enumerate(self.members):
            if m["email"] == email:
                member = m
                member_index = i
                break
        
        if not member:
            raise ValueError("Member not found")
        
        # Update member data
        update_data = member_update.model_dump(exclude_unset=True)
        for key, value in update_data.items():
            if key in member:
                member[key] = value
        
        member["updated_at"] = datetime.now()
        self.members[member_index] = member
        
        return Member(**{k: v for k, v in member.items() if k != "hashed_password"})

    async def get_pension_info_by_token(self, token: str) -> PensionInfo:
        email = verify_token(token)
        if not email:
            raise ValueError("Invalid token")
        
        member = None
        for m in self.members:
            if m["email"] == email:
                member = m
                break
        
        if not member:
            raise ValueError("Member not found")
        
        # Find pension info
        pension_info = None
        for info in self.pension_data:
            if info["member_id"] == member["id"]:
                pension_info = info
                break
        
        if not pension_info:
            raise ValueError("Pension information not found")
        
        return PensionInfo(**pension_info)
