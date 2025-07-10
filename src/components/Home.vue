<template>
  <main class="home">
    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1>Our purpose is to improve retirement security for Canadians</h1>
          <p class="hero-subtitle">Because we believe that every Canadian deserves to retire well.</p>
          <div class="hero-actions">
            <router-link to="/members" class="btn btn-primary">For Members</router-link>
            <router-link to="/employers" class="btn btn-secondary">For Employers</router-link>
          </div>
        </div>
        <div class="hero-image">
          <div class="placeholder-image">
            <p>Professional retirement planning image placeholder</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CEO Message Section -->
    <section class="ceo-message">
      <div class="container">
        <div class="message-content">
          <div class="message-text">
            <blockquote>
              "Our commitment remains unwavering in providing exceptional retirement benefits and services to help Canadians achieve financial security in their golden years."
            </blockquote>
            <cite>Derek W. Dobson, CEO & Plan Manager</cite>
          </div>
          <div class="message-image">
            <div class="placeholder-image">
              <p>CEO Portrait Placeholder</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- What's New Section -->
    <section class="whats-new">
      <div class="container">
        <h2>What's new with CAAT</h2>
        <p class="section-subtitle">Read below for more information about what the CAAT team has been working on.</p>
        
        <div class="news-grid">
          <article class="news-item">
            <div class="news-image">
              <div class="placeholder-image">News Image 1</div>
            </div>
            <div class="news-content">
              <h3>2024 Annual Report Released</h3>
              <p>Discover our achievements and financial performance over the past year in our comprehensive annual report.</p>
              <a href="#" class="read-more">Read More →</a>
            </div>
          </article>

          <article class="news-item">
            <div class="news-image">
              <div class="placeholder-image">News Image 2</div>
            </div>
            <div class="news-content">
              <h3>Enhanced Digital Services</h3>
              <p>We've upgraded our online portal to provide members with better access to their pension information.</p>
              <a href="#" class="read-more">Read More →</a>
            </div>
          </article>

          <article class="news-item">
            <div class="news-image">
              <div class="placeholder-image">News Image 3</div>
            </div>
            <div class="news-content">
              <h3>Sustainability Initiatives</h3>
              <p>Learn about our commitment to responsible investing and environmental sustainability.</p>
              <a href="#" class="read-more">Read More →</a>
            </div>
          </article>
        </div>
      </div>
    </section>

    <!-- Services Section -->
    <section class="services">
      <div class="container">
        <h2>Our Services</h2>
        <div class="services-grid">
          <div class="service-card">
            <div class="service-icon">📊</div>
            <h3>Pension Administration</h3>
            <p>Comprehensive pension plan management and administration services for optimal retirement planning.</p>
          </div>

          <div class="service-card">
            <div class="service-icon">💰</div>
            <h3>Investment Management</h3>
            <p>Professional investment strategies designed to grow and protect your retirement savings.</p>
          </div>

          <div class="service-card">
            <div class="service-icon">🎯</div>
            <h3>Retirement Planning</h3>
            <p>Personalized retirement planning tools and resources to help you achieve your financial goals.</p>
          </div>

          <div class="service-card">
            <div class="service-icon">🛡️</div>
            <h3>Benefits Protection</h3>
            <p>Secure and reliable benefit programs that provide peace of mind for your retirement years.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Quick Access Section -->
    <section class="quick-access">
      <div class="container">
        <h2>Quick Access</h2>
        <div class="access-grid">
          <div class="access-card">
            <h3>Member Portal</h3>
            <p>Access your pension information, update personal details, and manage your account online.</p>
            <a href="#" class="btn btn-primary">Member Login</a>
          </div>

          <div class="access-card">
            <h3>Employer Resources</h3>
            <p>Tools and resources for employers to manage employee pension benefits and contributions.</p>
            <a href="#" class="btn btn-secondary">Employer Portal</a>
          </div>

          <div class="access-card">
            <h3>Forms & Documents</h3>
            <p>Download important forms, documents, and resources related to your pension plan.</p>
            <a href="#" class="btn btn-primary">View Documents</a>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script>
export default {
  name: 'Home'
}
</script>

<style scoped>
.home {
  flex: 1;
}

/* Hero Section */
.hero {
  background: linear-gradient(135deg, var(--light-blue) 0%, var(--white) 100%);
  padding: 4rem 0;
  min-height: 80vh;
  display: flex;
  align-items: center;
}

.hero .container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.hero-content h1 {
  margin-bottom: 1.5rem;
  font-size: 3.5rem;
  line-height: 1.2;
}

.hero-subtitle {
  font-size: 1.3rem;
  color: var(--gray-dark);
  margin-bottom: 2.5rem;
}

.hero-actions {
  display: flex;
  gap: 1rem;
}

.hero-image .placeholder-image {
  background-color: var(--gray-medium);
  height: 300px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--gray-dark);
  font-style: italic;
}

/* CEO Message Section */
.ceo-message {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.message-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem;
  align-items: center;
}

.message-text blockquote {
  font-size: 1.4rem;
  font-style: italic;
  color: var(--primary-blue);
  margin-bottom: 1rem;
  line-height: 1.6;
}

.message-text cite {
  font-size: 1.1rem;
  color: var(--gray-dark);
  font-weight: 600;
}

.message-image .placeholder-image {
  background-color: var(--gray-medium);
  height: 200px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--gray-dark);
  font-size: 0.9rem;
  text-align: center;
}

/* What's New Section */
.whats-new {
  padding: 4rem 0;
}

.whats-new h2 {
  text-align: center;
  margin-bottom: 1rem;
}

.section-subtitle {
  text-align: center;
  color: var(--gray-dark);
  margin-bottom: 3rem;
  font-size: 1.2rem;
}

.news-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.news-item {
  background-color: var(--white);
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.news-item:hover {
  transform: translateY(-5px);
}

.news-image .placeholder-image {
  background-color: #000000;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
}

.news-content {
  padding: 1.5rem;
}

.news-content h3 {
  margin-bottom: 1rem;
  color: var(--primary-blue);
}

.news-content p {
  margin-bottom: 1rem;
  color: var(--gray-dark);
}

.read-more {
  color: #000000;
  font-weight: 600;
  text-decoration: none;
  transition: color 0.3s ease;
}

.read-more:hover {
  color: var(--primary-blue);
}

/* Services Section */
.services {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.services h2 {
  text-align: center;
  margin-bottom: 3rem;
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.service-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  text-align: center;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.service-card:hover {
  transform: translateY(-5px);
}

.service-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.service-card h3 {
  margin-bottom: 1rem;
  color: var(--primary-blue);
}

.service-card p {
  color: var(--gray-dark);
}

/* Quick Access Section */
.quick-access {
  padding: 4rem 0;
}

.quick-access h2 {
  text-align: center;
  margin-bottom: 3rem;
}

.access-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.access-card {
  background-color: var(--light-blue);
  padding: 2rem;
  border-radius: 10px;
  text-align: center;
  border: 2px solid var(--secondary-blue);
}

.access-card h3 {
  margin-bottom: 1rem;
  color: var(--primary-blue);
}

.access-card p {
  margin-bottom: 2rem;
  color: var(--gray-dark);
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero .container {
    grid-template-columns: 1fr;
    gap: 2rem;
    text-align: center;
  }
  
  .hero-content h1 {
    font-size: 2.5rem;
  }
  
  .hero-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .message-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .news-grid {
    grid-template-columns: 1fr;
  }
  
  .services-grid {
    grid-template-columns: 1fr;
  }
  
  .access-grid {
    grid-template-columns: 1fr;
  }
}
</style>
