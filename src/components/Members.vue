<template>
  <main class="members">
    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1>Member Resources</h1>
          <p class="hero-subtitle">Access your pension information, tools, and resources to help you plan for a secure retirement</p>
        </div>
      </div>
    </section>

    <!-- Member Portal Section -->
    <section class="member-portal">
      <div class="container">
        <h2>Member Portal Access</h2>
        <div class="portal-grid">
          <div class="portal-card featured">
            <div class="portal-icon">🔐</div>
            <h3>Secure Login</h3>
            <p>Access your personal pension information, statements, and account details through our secure member portal.</p>
            <a href="#" class="btn btn-primary">Login to Portal</a>
          </div>
          <div class="portal-card">
            <div class="portal-icon">📋</div>
            <h3>Account Summary</h3>
            <p>View your current pension balance, contribution history, and projected retirement benefits.</p>
          </div>
          <div class="portal-card">
            <div class="portal-icon">📊</div>
            <h3>Benefit Statements</h3>
            <p>Download your annual pension statements and track your retirement savings progress.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Planning Tools -->
    <section class="planning-tools">
      <div class="container">
        <h2>Retirement Planning Tools</h2>
        <div class="tools-grid">
          <div class="tool-card">
            <div class="tool-icon">🧮</div>
            <h3>Retirement Calculator</h3>
            <p>Estimate your retirement income and determine if you're on track to meet your retirement goals.</p>
            <a href="#" class="tool-link">Use Calculator →</a>
          </div>
          <div class="tool-card">
            <div class="tool-icon">📈</div>
            <h3>Pension Projector</h3>
            <p>Project your future pension benefits based on different retirement scenarios and contribution levels.</p>
            <a href="#" class="tool-link">Start Projection →</a>
          </div>
          <div class="tool-card">
            <div class="tool-icon">💰</div>
            <h3>Benefit Estimator</h3>
            <p>Get an estimate of your monthly pension payments at different retirement ages.</p>
            <a href="#" class="tool-link">Estimate Benefits →</a>
          </div>
          <div class="tool-card">
            <div class="tool-icon">📅</div>
            <h3>Retirement Planner</h3>
            <p>Create a comprehensive retirement plan with our step-by-step planning tool.</p>
            <a href="#" class="tool-link">Start Planning →</a>
          </div>
        </div>
      </div>
    </section>

    <!-- Resources Section -->
    <section class="member-resources">
      <div class="container">
        <h2>Important Resources</h2>
        <div class="resources-grid">
          <div class="resource-category">
            <h3>Forms & Documents</h3>
            <ul class="resource-list">
              <li><a href="#">Beneficiary Designation Form</a></li>
              <li><a href="#">Address Change Form</a></li>
              <li><a href="#">Direct Deposit Form</a></li>
              <li><a href="#">Pension Application Form</a></li>
              <li><a href="#">Transfer/Portability Forms</a></li>
            </ul>
          </div>
          <div class="resource-category">
            <h3>Educational Materials</h3>
            <ul class="resource-list">
              <li><a href="#">Understanding Your Pension</a></li>
              <li><a href="#">Retirement Planning Guide</a></li>
              <li><a href="#">Investment Options Overview</a></li>
              <li><a href="#">Survivor Benefits Guide</a></li>
              <li><a href="#">Tax Information for Members</a></li>
            </ul>
          </div>
          <div class="resource-category">
            <h3>Frequently Asked Questions</h3>
            <ul class="resource-list">
              <li><a href="#">How do I update my beneficiary?</a></li>
              <li><a href="#">When can I retire?</a></li>
              <li><a href="#">How is my pension calculated?</a></li>
              <li><a href="#">What happens if I change jobs?</a></li>
              <li><a href="#">Can I transfer my pension?</a></li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact Support -->
    <section class="member-support">
      <div class="container">
        <h2>Need Help?</h2>
        <div class="support-grid">
          <div class="support-card">
            <div class="support-icon">📞</div>
            <h3>Call Us</h3>
            <p>Speak with a member services representative</p>
            <p class="contact-info">1-800-CAA-TPEN</p>
            <p class="hours">Monday - Friday, 8:00 AM - 5:00 PM EST</p>
          </div>
          <div class="support-card">
            <div class="support-icon">✉️</div>
            <h3>Email Support</h3>
            <p>Send us your questions and we'll respond within 24 hours</p>
            <p class="contact-info">members@caatpension.ca</p>
          </div>
          <div class="support-card">
            <div class="support-icon">💬</div>
            <h3>Live Chat</h3>
            <p>Chat with our support team in real-time</p>
            <a href="#" class="btn btn-secondary">Start Chat</a>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script>
export default {
  name: 'Members'
}
</script>

<style scoped>
.members {
  flex: 1;
}

/* Hero Section */
.hero {
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
  color: var(--white);
  padding: 4rem 0;
  text-align: center;
}

.hero-content h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
  font-weight: 700;
}

.hero-subtitle {
  font-size: 1.3rem;
  opacity: 0.9;
  max-width: 800px;
  margin: 0 auto;
}

/* Member Portal Section */
.member-portal {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.portal-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.portal-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  text-align: center;
  transition: transform 0.3s ease;
}

.portal-card:hover {
  transform: translateY(-5px);
}

.portal-card.featured {
  border: 3px solid var(--green-accent);
}

.portal-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

/* Planning Tools */
.planning-tools {
  padding: 4rem 0;
}

.tools-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.tool-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  text-align: center;
  transition: transform 0.3s ease;
}

.tool-card:hover {
  transform: translateY(-5px);
}

.tool-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.tool-link {
  color: var(--primary-blue);
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease;
}

.tool-link:hover {
  color: var(--green-accent);
}

/* Member Resources */
.member-resources {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.resources-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 3rem;
  margin-top: 2rem;
}

.resource-category {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.resource-list {
  list-style: none;
  padding: 0;
  margin-top: 1rem;
}

.resource-list li {
  margin-bottom: 0.8rem;
}

.resource-list a {
  color: var(--primary-blue);
  text-decoration: none;
  transition: color 0.3s ease;
}

.resource-list a:hover {
  color: var(--green-accent);
}

/* Member Support */
.member-support {
  padding: 4rem 0;
}

.support-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.support-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  text-align: center;
  transition: transform 0.3s ease;
}

.support-card:hover {
  transform: translateY(-5px);
}

.support-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.contact-info {
  font-weight: 600;
  color: var(--primary-blue);
  font-size: 1.2rem;
  margin: 1rem 0;
}

.hours {
  color: var(--gray-dark);
  font-size: 0.9rem;
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero-content h1 {
    font-size: 2.2rem;
  }
  
  .hero-subtitle {
    font-size: 1.1rem;
  }
  
  .portal-grid,
  .tools-grid,
  .resources-grid,
  .support-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .portal-card,
  .tool-card,
  .resource-category,
  .support-card {
    padding: 1.5rem;
  }
}
</style>
