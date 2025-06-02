import uuid
from datetime import datetime
from app.models.contact import ContactForm, ContactResponse

class ContactService:
    def __init__(self):
        # Mock storage - in production this would use a database
        self.submissions = []

    async def submit_contact_form(self, contact_data: ContactForm) -> ContactResponse:
        # Generate reference number
        reference_number = f"CAAT-{datetime.now().strftime('%Y%m%d')}-{str(uuid.uuid4())[:8].upper()}"
        
        # Store submission (in production, save to database and send email)
        submission = {
            "id": len(self.submissions) + 1,
            "reference_number": reference_number,
            "name": contact_data.name,
            "email": contact_data.email,
            "phone": contact_data.phone,
            "subject": contact_data.subject,
            "message": contact_data.message,
            "member_id": contact_data.member_id,
            "inquiry_type": contact_data.inquiry_type,
            "submitted_at": datetime.now(),
            "status": "submitted"
        }
        
        self.submissions.append(submission)
        
        # Determine response time based on inquiry type
        response_time = "1-2 business days"
        if contact_data.inquiry_type == "member_services":
            response_time = "24 hours"
        elif contact_data.inquiry_type == "employer_services":
            response_time = "2-3 business days"
        
        return ContactResponse(
            success=True,
            message="Thank you for contacting CAAT Pension Plan. We have received your message and will respond shortly.",
            reference_number=reference_number,
            estimated_response_time=response_time
        )
