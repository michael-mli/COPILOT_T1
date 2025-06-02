#!/bin/bash

# CAAT Pension Vue.js - GitHub Repository Setup Script
# This script initializes git, commits the codebase, and pushes to a new GitHub repository

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_NAME="caat-pension-vue"
REPO_DESCRIPTION="A modern Vue.js website replicating the CAAT Pension website design and functionality"
DEFAULT_BRANCH="main"

# Function to print colored output
print_step() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
print_step "Checking prerequisites..."

if ! command_exists git; then
    print_error "Git is not installed. Please install git first."
    exit 1
fi

if ! command_exists gh; then
    print_warning "GitHub CLI (gh) is not installed."
    print_warning "You can install it with: sudo apt install gh (Ubuntu/Debian) or brew install gh (macOS)"
    print_warning "Alternatively, you'll need to create the repository manually on GitHub."
    USE_GH_CLI=false
else
    USE_GH_CLI=true
fi

# Get user input
echo
print_step "Repository Configuration"
read -p "Enter repository name (default: $REPO_NAME): " input_repo_name
REPO_NAME=${input_repo_name:-$REPO_NAME}

read -p "Enter repository description (default: $REPO_DESCRIPTION): " input_description
REPO_DESCRIPTION=${input_description:-$REPO_DESCRIPTION}

read -p "Make repository private? (y/N): " private_repo
PRIVATE_FLAG=""
if [[ $private_repo =~ ^[Yy]$ ]]; then
    PRIVATE_FLAG="--private"
fi

echo
print_step "Starting repository setup..."

# Initialize git repository if not already initialized
if [ ! -d ".git" ]; then
    print_step "Initializing git repository..."
    git init
    git branch -M $DEFAULT_BRANCH
    print_success "Git repository initialized"
else
    print_warning "Git repository already exists"
fi

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    print_step "Creating .gitignore file..."
    cat > .gitignore << EOF
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build outputs
dist/
build/

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Logs
logs
*.log

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/

# Temporary folders
tmp/
temp/
EOF
    print_success ".gitignore created"
fi

# Add all files to git
print_step "Adding files to git..."
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    print_warning "No changes to commit"
else
    # Commit changes
    print_step "Committing changes..."
    git commit -m "Initial commit: CAAT Pension Vue.js website

- Vue 3 + Vite setup with modern architecture
- Responsive design with professional styling
- Component-based structure (Header, Home, About, Footer)
- Mobile-first approach with breakpoint at 768px
- CAAT-inspired color scheme (blues and greens)
- Vue Router for SPA navigation
- Comprehensive About page with mission, values, leadership
- Professional documentation and Mermaid diagrams

Features:
- Hero section with call-to-action
- CEO message and company values
- News grid and services overview
- Leadership team showcase
- Company history timeline
- Statistics and achievements
- Fully responsive mobile menu
- Accessible design patterns"

    print_success "Changes committed"
fi

# GitHub repository creation and push
if [ "$USE_GH_CLI" = true ]; then
    print_step "Checking GitHub CLI authentication..."
    
    # Check if user is logged in to GitHub CLI
    if ! gh auth status >/dev/null 2>&1; then
        print_warning "Not authenticated with GitHub CLI"
        print_step "Please authenticate with GitHub..."
        gh auth login
    fi
    
    print_step "Creating GitHub repository with GitHub CLI..."
    
    # Create repository on GitHub
    if gh repo create "$REPO_NAME" --description "$REPO_DESCRIPTION" $PRIVATE_FLAG --source=. --remote=origin --push; then
        print_success "Repository created and code pushed successfully!"
        
        # Get the repository URL
        REPO_URL=$(gh repo view --json url --jq .url)
        print_success "Repository URL: $REPO_URL"
        
        # Open repository in browser (optional)
        read -p "Open repository in browser? (Y/n): " open_browser
        if [[ ! $open_browser =~ ^[Nn]$ ]]; then
            gh repo view --web
        fi
    else
        print_error "Failed to create repository with GitHub CLI"
        exit 1
    fi
    
else
    print_step "Setting up for manual GitHub repository creation..."
    
    # Get GitHub username
    read -p "Enter your GitHub username: " github_username
    
    if [ -z "$github_username" ]; then
        print_error "GitHub username is required"
        exit 1
    fi
    
    # Add remote origin
    REPO_URL="https://github.com/$github_username/$REPO_NAME.git"
    
    print_step "Adding remote origin..."
    if git remote get-url origin >/dev/null 2>&1; then
        git remote set-url origin "$REPO_URL"
    else
        git remote add origin "$REPO_URL"
    fi
    
    print_warning "Manual steps required:"
    echo "1. Go to GitHub.com and create a new repository named: $REPO_NAME"
    echo "2. Set the description to: $REPO_DESCRIPTION"
    if [[ $private_repo =~ ^[Yy]$ ]]; then
        echo "3. Make it private as requested"
    else
        echo "3. Make it public (or private if you prefer)"
    fi
    echo "4. DO NOT initialize with README, .gitignore, or license"
    echo
    read -p "Press Enter after creating the repository on GitHub..."
    
    print_step "Pushing to GitHub..."
    if git push -u origin $DEFAULT_BRANCH; then
        print_success "Code pushed successfully!"
        print_success "Repository URL: $REPO_URL"
    else
        print_error "Failed to push to GitHub. Please check:"
        echo "  - Repository exists on GitHub"
        echo "  - You have write access"
        echo "  - Remote URL is correct: $REPO_URL"
        exit 1
    fi
fi

echo
print_success "🎉 Repository setup complete!"
echo
echo "Summary:"
echo "  Repository Name: $REPO_NAME"
echo "  Description: $REPO_DESCRIPTION"
echo "  Branch: $DEFAULT_BRANCH"
if [ "$USE_GH_CLI" = true ]; then
    echo "  Created with: GitHub CLI"
else
    echo "  Created with: Manual process"
fi
echo
print_step "Next steps:"
echo "  1. Clone the repository on other machines: git clone $REPO_URL"
echo "  2. Install dependencies: npm install"
echo "  3. Start development server: npm run dev"
echo "  4. Build for production: npm run build"
echo
print_success "Happy coding! 🚀"
