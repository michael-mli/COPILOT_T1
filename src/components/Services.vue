<template>
  <main class="services">
    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1>Our Services</h1>
          <p class="hero-subtitle">Comprehensive pension solutions designed to secure your financial future</p>
        </div>
      </div>
    </section>

    <!-- Services Overview -->
    <section class="services-overview">
      <div class="container">
        <div class="overview-content">
          <h2>Complete Pension Solutions</h2>
          <p>At CAAT Pension Plan, we provide end-to-end pension services that ensure reliable retirement security for all our members. Our comprehensive approach combines innovative technology, expert management, and personalized support.</p>
        </div>
      </div>
    </section>

    <!-- Main Services Grid -->
    <section class="main-services">
      <div class="container">
        <div class="services-grid">
          <!-- Pension Administration -->
          <div class="service-card featured">
            <div class="service-icon">📋</div>
            <h3>Pension Administration</h3>
            <p>Complete pension plan management including enrollment, contributions tracking, benefit calculations, and retirement processing.</p>
            <ul class="service-features">
              <li>Member enrollment and onboarding</li>
              <li>Contribution processing and tracking</li>
              <li>Benefit calculations and projections</li>
              <li>Retirement and termination processing</li>
              <li>Annual statements and reporting</li>
            </ul>
            <a href="#pension-admin" class="service-link">Learn More →</a>
          </div>

          <!-- Investment Management -->
          <div class="service-card featured">
            <div class="service-icon">📈</div>
            <h3>Investment Management</h3>
            <p>Professional portfolio management and investment strategies designed to maximize returns while managing risk for long-term growth.</p>
            <ul class="service-features">
              <li>Diversified investment portfolios</li>
              <li>ESG and sustainable investing</li>
              <li>Risk management and assessment</li>
              <li>Performance monitoring and reporting</li>
              <li>Strategic asset allocation</li>
            </ul>
            <a href="#investment" class="service-link">Learn More →</a>
          </div>

          <!-- Member Services -->
          <div class="service-card">
            <div class="service-icon">👥</div>
            <h3>Member Services</h3>
            <p>Dedicated support and resources to help members understand their benefits and plan for retirement.</p>
            <ul class="service-features">
              <li>Personal benefit consultations</li>
              <li>Retirement planning workshops</li>
              <li>Online member portal access</li>
              <li>Educational resources and tools</li>
            </ul>
            <a href="#member-services" class="service-link">Learn More →</a>
          </div>

          <!-- Employer Services -->
          <div class="service-card">
            <div class="service-icon">🏢</div>
            <h3>Employer Services</h3>
            <p>Comprehensive support for participating employers including compliance assistance and reporting.</p>
            <ul class="service-features">
              <li>Employer onboarding and setup</li>
              <li>Contribution management</li>
              <li>Compliance monitoring</li>
              <li>Employee communication support</li>
            </ul>
            <a href="#employer-services" class="service-link">Learn More →</a>
          </div>

          <!-- Financial Planning -->
          <div class="service-card">
            <div class="service-icon">💰</div>
            <h3>Financial Planning</h3>
            <p>Personalized financial planning services and tools to help optimize retirement savings and strategies.</p>
            <ul class="service-features">
              <li>Retirement income projections</li>
              <li>Tax-efficient strategies</li>
              <li>Estate planning guidance</li>
              <li>Financial wellness programs</li>
            </ul>
            <a href="#financial-planning" class="service-link">Learn More →</a>
          </div>

          <!-- Digital Solutions -->
          <div class="service-card">
            <div class="service-icon">💻</div>
            <h3>Digital Solutions</h3>
            <p>Modern technology platforms that provide easy access to pension information and self-service options.</p>
            <ul class="service-features">
              <li>Online member portal</li>
              <li>Mobile applications</li>
              <li>Document management system</li>
              <li>Automated notifications</li>
            </ul>
            <a href="#digital-solutions" class="service-link">Learn More →</a>
          </div>
        </div>
      </div>
    </section>

    <!-- Service Categories -->
    <section class="service-categories">
      <div class="container">
        <h2>Services by Category</h2>
        <div class="categories-grid">
          <!-- For Members -->
          <div class="category-card">
            <h3>For Members</h3>
            <div class="category-icon">👤</div>
            <ul>
              <li>Benefit statements and calculations</li>
              <li>Retirement planning tools</li>
              <li>Pre-retirement counseling</li>
              <li>Pension option selection</li>
              <li>Survivor benefit information</li>
              <li>Transfer and portability options</li>
            </ul>
            <router-link to="/members" class="btn btn-primary">Member Resources</router-link>
          </div>

          <!-- For Employers -->
          <div class="category-card">
            <h3>For Employers</h3>
            <div class="category-icon">🏛️</div>
            <ul>
              <li>Plan design and implementation</li>
              <li>Employee communication materials</li>
              <li>Contribution calculation assistance</li>
              <li>Regulatory compliance support</li>
              <li>Data management and reporting</li>
              <li>Training and education programs</li>
            </ul>
            <router-link to="/employers" class="btn btn-primary">Employer Portal</router-link>
          </div>

          <!-- For Retirees -->
          <div class="category-card">
            <h3>For Retirees</h3>
            <div class="category-icon">🌅</div>
            <ul>
              <li>Pension payment processing</li>
              <li>Tax slip preparation</li>
              <li>Direct deposit management</li>
              <li>Address and banking updates</li>
              <li>Survivor benefit processing</li>
              <li>Retiree health benefit coordination</li>
            </ul>
            <router-link to="/retirees" class="btn btn-primary">Retiree Services</router-link>
          </div>
        </div>
      </div>
    </section>

    <!-- Process Flow -->
    <section class="process-flow">
      <div class="container">
        <h2>Our Service Process</h2>
        <div class="process-steps">
          <div class="step">
            <div class="step-number">1</div>
            <h3>Consultation</h3>
            <p>Initial assessment of your pension needs and goals</p>
          </div>
          <div class="step-arrow">→</div>
          <div class="step">
            <div class="step-number">2</div>
            <h3>Planning</h3>
            <p>Develop a customized strategy for your retirement</p>
          </div>
          <div class="step-arrow">→</div>
          <div class="step">
            <div class="step-number">3</div>
            <h3>Implementation</h3>
            <p>Execute your pension plan with ongoing management</p>
          </div>
          <div class="step-arrow">→</div>
          <div class="step">
            <div class="step-number">4</div>
            <h3>Monitoring</h3>
            <p>Continuous review and optimization of your benefits</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Service Standards -->
    <section class="service-standards">
      <div class="container">
        <h2>Our Service Standards</h2>
        <div class="standards-grid">
          <div class="standard-card">
            <div class="standard-icon">⚡</div>
            <h3>Fast Response</h3>
            <p>24-hour response time for all member inquiries</p>
          </div>
          <div class="standard-card">
            <div class="standard-icon">🎯</div>
            <h3>Accuracy</h3>
            <p>99.9% accuracy in benefit calculations and processing</p>
          </div>
          <div class="standard-card">
            <div class="standard-icon">🔒</div>
            <h3>Security</h3>
            <p>Bank-level security for all personal and financial data</p>
          </div>
          <div class="standard-card">
            <div class="standard-icon">📞</div>
            <h3>Support</h3>
            <p>Dedicated support team available during business hours</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact CTA -->
    <section class="contact-cta">
      <div class="container">
        <div class="cta-content">
          <h2>Ready to Learn More?</h2>
          <p>Contact our team to discuss how our services can help secure your retirement future.</p>
          <div class="cta-actions">
            <router-link to="/contact" class="btn btn-primary">Contact Us</router-link>
            <a href="tel:1-800-CAA-TPEN" class="btn btn-secondary">Call 1-800-CAA-TPEN</a>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script>
export default {
  name: 'Services'
}
</script>

<style scoped>
.services {
  flex: 1;
}

/* Hero Section */
.hero {
  background: linear-gradient(135deg, var(--light-blue) 0%, var(--white) 100%);
  padding: 4rem 0;
  text-align: center;
}

.hero-content h1 {
  margin-bottom: 1.5rem;
  font-size: 3rem;
  color: var(--primary-blue);
}

.hero-subtitle {
  font-size: 1.3rem;
  color: var(--gray-dark);
  max-width: 600px;
  margin: 0 auto;
}

/* Services Overview */
.services-overview {
  padding: 3rem 0;
  background-color: var(--white);
}

.overview-content {
  text-align: center;
  max-width: 800px;
  margin: 0 auto;
}

.overview-content h2 {
  margin-bottom: 2rem;
  color: var(--primary-blue);
}

.overview-content p {
  font-size: 1.2rem;
  line-height: 1.7;
  color: var(--text-dark);
}

/* Main Services Grid */
.main-services {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.service-card {
  background-color: var(--white);
  padding: 2.5rem;
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  border: 2px solid transparent;
}

.service-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.service-card.featured {
  border-color: var(--green-accent);
  background: linear-gradient(135deg, var(--white) 0%, var(--light-blue) 100%);
}

.service-icon {
  font-size: 3.5rem;
  margin-bottom: 1.5rem;
  text-align: center;
}

.service-card h3 {
  margin-bottom: 1.5rem;
  color: var(--primary-blue);
  font-size: 1.5rem;
}

.service-card p {
  margin-bottom: 2rem;
  color: var(--gray-dark);
  line-height: 1.6;
}

.service-features {
  list-style: none;
  margin-bottom: 2rem;
  padding: 0;
}

.service-features li {
  padding: 0.5rem 0;
  border-bottom: 1px solid var(--gray-medium);
  color: var(--text-dark);
  font-size: 0.95rem;
}

.service-features li:before {
  content: "✓ ";
  color: var(--green-accent);
  font-weight: bold;
  margin-right: 0.5rem;
}

.service-features li:last-child {
  border-bottom: none;
}

.service-link {
  color: var(--green-accent);
  font-weight: 600;
  text-decoration: none;
  transition: color 0.3s ease;
  display: inline-block;
  margin-top: 1rem;
}

.service-link:hover {
  color: var(--primary-blue);
}

/* Service Categories */
.service-categories {
  padding: 4rem 0;
}

.service-categories h2 {
  text-align: center;
  margin-bottom: 3rem;
  color: var(--primary-blue);
}

.categories-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.category-card {
  background-color: var(--white);
  padding: 2.5rem;
  border-radius: 15px;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
  text-align: center;
  border: 2px solid var(--light-blue);
}

.category-card h3 {
  margin-bottom: 1rem;
  color: var(--primary-blue);
}

.category-icon {
  font-size: 4rem;
  margin: 1rem 0 2rem;
}

.category-card ul {
  list-style: none;
  margin-bottom: 2rem;
  padding: 0;
  text-align: left;
}

.category-card ul li {
  padding: 0.75rem 0;
  border-bottom: 1px solid var(--gray-light);
  color: var(--text-dark);
}

.category-card ul li:before {
  content: "• ";
  color: var(--green-accent);
  font-weight: bold;
  margin-right: 0.5rem;
}

.category-card ul li:last-child {
  border-bottom: none;
}

/* Process Flow */
.process-flow {
  padding: 4rem 0;
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
  color: var(--white);
}

.process-flow h2 {
  text-align: center;
  margin-bottom: 3rem;
  color: var(--white);
}

.process-steps {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1000px;
  margin: 0 auto;
}

.step {
  text-align: center;
  flex: 1;
}

.step-number {
  width: 60px;
  height: 60px;
  background-color: var(--green-accent);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1rem;
  font-size: 1.5rem;
  font-weight: bold;
  color: var(--white);
}

.step h3 {
  margin-bottom: 1rem;
  color: var(--white);
}

.step p {
  color: rgba(255, 255, 255, 0.9);
  font-size: 0.95rem;
}

.step-arrow {
  font-size: 2rem;
  color: var(--white);
  margin: 0 1rem;
}

/* Service Standards */
.service-standards {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.service-standards h2 {
  text-align: center;
  margin-bottom: 3rem;
  color: var(--primary-blue);
}

.standards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.standard-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  text-align: center;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.standard-card:hover {
  transform: translateY(-5px);
}

.standard-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.standard-card h3 {
  margin-bottom: 1rem;
  color: var(--primary-blue);
}

.standard-card p {
  color: var(--gray-dark);
  line-height: 1.6;
}

/* Contact CTA */
.contact-cta {
  padding: 4rem 0;
  background-color: var(--green-accent);
  color: var(--white);
}

.cta-content {
  text-align: center;
  max-width: 600px;
  margin: 0 auto;
}

.cta-content h2 {
  margin-bottom: 1.5rem;
  color: var(--white);
}

.cta-content p {
  margin-bottom: 2.5rem;
  font-size: 1.2rem;
  color: rgba(255, 255, 255, 0.9);
}

.cta-actions {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.cta-actions .btn {
  margin: 0;
}

.cta-actions .btn-secondary {
  background-color: var(--white);
  color: var(--green-accent);
}

.cta-actions .btn-secondary:hover {
  background-color: var(--gray-light);
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero-content h1 {
    font-size: 2.2rem;
  }
  
  .services-grid {
    grid-template-columns: 1fr;
  }
  
  .categories-grid {
    grid-template-columns: 1fr;
  }
  
  .process-steps {
    flex-direction: column;
    gap: 2rem;
  }
  
  .step-arrow {
    transform: rotate(90deg);
    margin: 1rem 0;
  }
  
  .standards-grid {
    grid-template-columns: 1fr;
  }
  
  .cta-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .cta-actions .btn {
    width: 100%;
    max-width: 300px;
  }
}

@media (max-width: 480px) {
  .service-card,
  .category-card {
    padding: 1.5rem;
  }
  
  .process-steps {
    padding: 0 1rem;
  }
}
</style>
