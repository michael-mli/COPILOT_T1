import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["message"] == "CAAT Pension API"

def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"

def test_get_news_articles():
    response = client.get("/api/v1/news/")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_get_contact_info():
    response = client.get("/api/v1/contact/info")
    assert response.status_code == 200
    data = response.json()
    assert "phone" in data
    assert "email" in data

def test_get_employers():
    response = client.get("/api/v1/employers/")
    assert response.status_code == 200
    assert isinstance(response.json(), list)
