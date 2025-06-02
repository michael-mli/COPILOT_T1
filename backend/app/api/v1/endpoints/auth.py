from fastapi import APIRouter, HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from app.models.auth import Token, LoginRequest
from app.services.auth_service import AuthService

router = APIRouter()
security = HTTPBearer()
auth_service = AuthService()

@router.post("/login", response_model=Token)
async def login(login_data: LoginRequest):
    """Authenticate user and return access token"""
    try:
        token = await auth_service.authenticate_user(login_data)
        return token
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))

@router.post("/logout")
async def logout(credentials: HTTPAuthorizationCredentials = Depends(security)):
    """Logout user (invalidate token)"""
    try:
        await auth_service.logout_user(credentials.credentials)
        return {"message": "Successfully logged out"}
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))

@router.get("/verify")
async def verify_token(credentials: HTTPAuthorizationCredentials = Depends(security)):
    """Verify if token is valid"""
    try:
        user_info = await auth_service.verify_token(credentials.credentials)
        return {"valid": True, "user": user_info}
    except ValueError as e:
        raise HTTPException(status_code=401, detail={"valid": False, "error": str(e)})
