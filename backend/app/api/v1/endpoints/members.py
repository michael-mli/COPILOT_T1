from fastapi import APIRouter, HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from typing import List
from app.models.member import Member, MemberCreate, MemberUpdate, MemberLogin
from app.services.member_service import MemberService

router = APIRouter()
security = HTTPBearer()
member_service = MemberService()

@router.post("/register", response_model=Member)
async def register_member(member_data: MemberCreate):
    """Register a new member"""
    try:
        member = await member_service.create_member(member_data)
        return member
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/login")
async def login_member(login_data: MemberLogin):
    """Authenticate member and return access token"""
    try:
        token = await member_service.authenticate_member(login_data)
        return {"access_token": token, "token_type": "bearer"}
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))

@router.get("/profile", response_model=Member)
async def get_member_profile(credentials: HTTPAuthorizationCredentials = Depends(security)):
    """Get current member's profile"""
    try:
        member = await member_service.get_member_by_token(credentials.credentials)
        return member
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))

@router.put("/profile", response_model=Member)
async def update_member_profile(
    member_update: MemberUpdate,
    credentials: HTTPAuthorizationCredentials = Depends(security)
):
    """Update member profile"""
    try:
        member = await member_service.update_member_by_token(credentials.credentials, member_update)
        return member
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/pension-info")
async def get_pension_info(credentials: HTTPAuthorizationCredentials = Depends(security)):
    """Get member's pension information"""
    try:
        pension_info = await member_service.get_pension_info_by_token(credentials.credentials)
        return pension_info
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
