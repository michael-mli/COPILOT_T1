from fastapi import APIRouter, HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from typing import List
from app.models.employer import Employer, EmployerCreate, EmployerService as EmployerServiceModel
from app.services.employer_service import EmployerService

router = APIRouter()
security = HTTPBearer()
employer_service = EmployerService()

@router.get("/", response_model=List[Employer])
async def get_employers():
    """Get list of all participating employers"""
    try:
        employers = await employer_service.get_all_employers()
        return employers
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/{employer_id}", response_model=Employer)
async def get_employer(employer_id: int):
    """Get specific employer information"""
    try:
        employer = await employer_service.get_employer_by_id(employer_id)
        if not employer:
            raise HTTPException(status_code=404, detail="Employer not found")
        return employer
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))

@router.get("/services/available", response_model=List[EmployerServiceModel])
async def get_employer_services():
    """Get available services for employers"""
    try:
        services = await employer_service.get_available_services()
        return services
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/resources/downloads")
async def get_employer_resources():
    """Get downloadable resources for employers"""
    return {
        "forms": [
            {
                "title": "New Employee Enrollment Form",
                "description": "Form for enrolling new employees in the pension plan",
                "file_type": "PDF",
                "download_url": "/downloads/new-employee-enrollment.pdf"
            },
            {
                "title": "Payroll Remittance Form",
                "description": "Monthly payroll remittance form",
                "file_type": "PDF",
                "download_url": "/downloads/payroll-remittance.pdf"
            },
            {
                "title": "Employee Termination Form",
                "description": "Form for processing employee terminations",
                "file_type": "PDF",
                "download_url": "/downloads/employee-termination.pdf"
            }
        ],
        "guides": [
            {
                "title": "Employer Guide to CAAT Pension Plan",
                "description": "Comprehensive guide for employers",
                "file_type": "PDF",
                "download_url": "/downloads/employer-guide.pdf"
            },
            {
                "title": "Payroll Processing Guide",
                "description": "Step-by-step payroll processing instructions",
                "file_type": "PDF",
                "download_url": "/downloads/payroll-guide.pdf"
            }
        ]
    }
