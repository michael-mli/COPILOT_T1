from fastapi import APIRouter, HTTPException
from app.models.contact import ContactForm, ContactResponse
from app.services.contact_service import ContactService

router = APIRouter()
contact_service = ContactService()

@router.post("/submit", response_model=ContactResponse)
async def submit_contact_form(contact_data: ContactForm):
    """Submit a contact form"""
    try:
        response = await contact_service.submit_contact_form(contact_data)
        return response
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/info")
async def get_contact_info():
    """Get contact information"""
    return {
        "phone": "1-800-668-CAAT (2228)",
        "email": "info@caatpension.ca",
        "address": {
            "street": "250 Yonge Street, Suite 2900",
            "city": "Toronto",
            "province": "Ontario",
            "postal_code": "M5B 2L7",
            "country": "Canada"
        },
        "business_hours": {
            "monday_friday": "8:30 AM - 5:00 PM ET",
            "saturday": "Closed",
            "sunday": "Closed"
        },
        "member_services_hours": {
            "monday_friday": "8:30 AM - 5:00 PM ET",
            "phone": "1-800-668-CAAT (2228)"
        }
    }
