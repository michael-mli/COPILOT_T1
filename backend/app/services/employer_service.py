from typing import List, Optional
from datetime import datetime
from app.models.employer import Employer, EmployerService

class EmployerService:
    def __init__(self):
        # Mock employer data - in production this would use a database
        self.employers = [
            {
                "id": 1,
                "name": "Toronto District School Board",
                "sector": "Education",
                "status": "active",
                "join_date": datetime(2018, 1, 15),
                "employee_count": 15000,
                "contact_person": "Sarah Johnson",
                "contact_email": "pension@tdsb.on.ca"
            },
            {
                "id": 2,
                "name": "Seneca College",
                "sector": "Post-Secondary Education",
                "status": "active",
                "join_date": datetime(2019, 9, 1),
                "employee_count": 3500,
                "contact_person": "Michael Chen",
                "contact_email": "hr@senecacollege.ca"
            },
            {
                "id": 3,
                "name": "York Region District School Board",
                "sector": "Education",
                "status": "active",
                "join_date": datetime(2020, 2, 10),
                "employee_count": 12000,
                "contact_person": "Lisa Wang",
                "contact_email": "benefits@yrdsb.ca"
            }
        ]
        
        self.services = [
            {
                "id": 1,
                "name": "Payroll Integration Support",
                "description": "Technical assistance for integrating pension deductions with your payroll system",
                "category": "payroll",
                "available": True,
                "cost": None
            },
            {
                "id": 2,
                "name": "Employee Education Sessions",
                "description": "On-site or virtual pension education sessions for your employees",
                "category": "education",
                "available": True,
                "cost": None
            },
            {
                "id": 3,
                "name": "Customized Reporting",
                "description": "Tailored pension reporting to meet your organization's specific needs",
                "category": "reporting",
                "available": True,
                "cost": 500.00
            },
            {
                "id": 4,
                "name": "HR Support Services",
                "description": "Dedicated HR liaison for pension-related inquiries and support",
                "category": "support",
                "available": True,
                "cost": None
            }
        ]

    async def get_all_employers(self) -> List[Employer]:
        return [Employer(**employer) for employer in self.employers]

    async def get_employer_by_id(self, employer_id: int) -> Optional[Employer]:
        for employer in self.employers:
            if employer["id"] == employer_id:
                return Employer(**employer)
        return None

    async def get_available_services(self) -> List[EmployerService]:
        available_services = [service for service in self.services if service["available"]]
        return [EmployerService(**service) for service in available_services]
