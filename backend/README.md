# CAAT Pension Backend API

A FastAPI backend service for the CAAT Pension website providing REST APIs for pension management, member services, and administrative functions.

## Features

- RESTful API endpoints for pension data
- Member authentication and authorization
- News and announcements management
- Employer services API
- Contact form handling
- Data validation with Pydantic models

## Setup

1. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Run the development server:
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

## API Documentation

Once running, visit:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Project Structure

```
backend/
├── app/
│   ├── main.py              # FastAPI application entry point
│   ├── core/                # Core functionality
│   │   ├── config.py        # Configuration settings
│   │   └── security.py      # Authentication & security
│   ├── api/                 # API routes
│   │   └── v1/              # API version 1
│   ├── models/              # Pydantic models
│   ├── services/            # Business logic
│   └── database.py          # Database configuration
├── tests/                   # Test files
└── requirements.txt         # Python dependencies
```

## Environment Variables

Create a `.env` file with:
```
DATABASE_URL=postgresql://user:password@localhost/caat_pension
SECRET_KEY=your-secret-key-here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```
