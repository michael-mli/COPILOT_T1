from fastapi import APIRouter
from app.api.v1.endpoints import members, news, contact, employers, auth

api_router = APIRouter()

api_router.include_router(auth.router, prefix="/auth", tags=["authentication"])
api_router.include_router(members.router, prefix="/members", tags=["members"])
api_router.include_router(news.router, prefix="/news", tags=["news"])
api_router.include_router(contact.router, prefix="/contact", tags=["contact"])
api_router.include_router(employers.router, prefix="/employers", tags=["employers"])
