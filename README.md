# CAAT Pension Vue.js Website

A modern, responsive Vue.js website that replicates the design and functionality of the CAAT Pension website (https://www.caatpension.ca).

## Features

- **Modern Vue.js Architecture**: Built with Vue 3 and Vite for fast development and optimal performance
- **Responsive Design**: Mobile-first approach with professional financial services styling
- **Component-Based Structure**: Modular components for easy maintenance and scalability
- **Professional Styling**: Professional color scheme inspired by CAAT with blues and green accents
- **Accessible Design**: Following accessibility best practices for inclusive user experience

## Tech Stack

- **Vue 3**: Progressive JavaScript framework
- **Vite**: Fast build tool and development server
- **Vue Router**: Client-side routing for single-page application
- **CSS3**: Modern styling with CSS custom properties and responsive design

## Project Structure

```
src/
├── App.vue              # Main application component
├── main.js              # Application entry point
├── style.css            # Global styles and CSS variables
└── components/
    ├── AppHeader.vue    # Navigation header with responsive menu
    ├── Home.vue         # Main landing page with hero and sections
    └── AppFooter.vue    # Site footer with links and contact info
```

## Design System

### Color Palette
- Primary Blue: `#004d9f`
- Secondary Blue: `#0066cc`
- Light Blue: `#e6f2ff`
- Dark Blue: `#003366`
- Green Accent: `#00a86b`
- Gray variants for text and backgrounds

### Typography
- Font Family: Inter, system-ui, Avenir, Helvetica, Arial, sans-serif
- Responsive font sizes with mobile-first approach
- Professional hierarchy for headings and body text

## Getting Started

### Prerequisites
- Node.js (version 14 or higher)
- npm or yarn package manager

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

4. Open your browser and navigate to `http://localhost:5173`

### Build for Production

```bash
npm run build
```

### Preview Production Build

```bash
npm run preview
```

## Component Overview

### AppHeader.vue
- Responsive navigation with mobile hamburger menu
- CAAT branding and logo
- Navigation links for all main sections
- Sticky header with shadow effect

### Home.vue
- Hero section with call-to-action buttons
- CEO message section with quote
- "What's New" news grid with latest updates
- Services overview with icons and descriptions
- Quick access cards for members and employers

### AppFooter.vue
- Comprehensive footer with multiple sections
- Quick links and contact information
- Social media links
- Legal and accessibility links

## Responsive Breakpoints

- Mobile: < 768px
- Tablet/Desktop: ≥ 768px

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## Contributing

1. Follow the established component structure
2. Use scoped styles in Vue components
3. Maintain responsive design patterns
4. Follow accessibility best practices
5. Use CSS custom properties for consistent theming

## License

This project is for educational/demonstration purposes, inspired by the CAAT Pension website design.
