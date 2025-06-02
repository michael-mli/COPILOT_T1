"""
CAAT Pension Backend API Startup Script
Run this script to start the FastAPI development server
"""

import subprocess
import sys
import os

def main():
    print("🏢 Starting CAAT Pension Backend API...")
    
    # Check if we're in the backend directory
    if not os.path.exists("requirements.txt"):
        print("❌ Error: Please run this script from the backend directory")
        sys.exit(1)
    
    print("🚀 Starting FastAPI development server...")
    print("📖 API Documentation: http://localhost:8000/docs")
    print("🔗 API Base URL: http://localhost:8000")
    print("🔗 ReDoc Documentation: http://localhost:8000/redoc")
    print("")
    print("Press Ctrl+C to stop the server")
    print("")
    
    try:
        # Start the server
        subprocess.run([
            sys.executable, "-m", "uvicorn", 
            "app.main:app", 
            "--reload", 
            "--host", "0.0.0.0", 
            "--port", "8000"
        ])
    except KeyboardInterrupt:
        print("\n👋 Server stopped")

if __name__ == "__main__":
    main()
