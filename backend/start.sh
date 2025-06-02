#!/bin/bash

# CAAT Pension Backend Setup and Start Script

echo "🏢 Setting up CAAT Pension Backend API..."

# Check if we're in the backend directory
if [ ! -f "requirements.txt" ]; then
    echo "❌ Error: Please run this script from the backend directory"
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "🔄 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📥 Installing dependencies..."
pip install -r requirements.txt

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "⚙️ Creating .env file..."
    cp .env.example .env
    echo "✏️ Please edit .env file with your configuration"
fi

# Run tests
echo "🧪 Running tests..."
python -m pytest tests/ -v

if [ $? -eq 0 ]; then
    echo "✅ All tests passed!"
    echo "🚀 Starting FastAPI development server..."
    echo "📖 API Documentation will be available at: http://localhost:8000/docs"
    echo "🔗 API will be running at: http://localhost:8000"
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    
    # Start the server
    uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
else
    echo "❌ Tests failed. Please fix the issues before starting the server."
    exit 1
fi
