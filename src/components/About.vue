<template>
  <main class="about">
    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1>About CAAT Pension Plan</h1>
          <p class="hero-subtitle">Learn about our mission to improve retirement security for Canadians</p>
        </div>
      </div>
    </section>

    <!-- Mission Section -->
    <section class="mission">
      <div class="container">
        <div class="mission-content">
          <div class="mission-text">
            <h2>Our Mission</h2>
            <p>The CAAT Pension Plan is dedicated to improving retirement security for Canadians. We believe that every Canadian deserves to retire well, with dignity and financial peace of mind.</p>
            <p>Since our establishment, we have been committed to providing exceptional pension administration services, innovative investment management, and comprehensive retirement planning support.</p>
          </div>
          <div class="mission-image">
            <div class="placeholder-image">
              <p>Mission Vision Placeholder</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Values Section -->
    <section class="values">
      <div class="container">
        <h2>Our Core Values</h2>
        <div class="values-grid">
          <div class="value-card">
            <div class="value-icon">🎯</div>
            <h3>Excellence</h3>
            <p>We strive for excellence in everything we do, from investment management to member services.</p>
          </div>
          <div class="value-card">
            <div class="value-icon">🤝</div>
            <h3>Integrity</h3>
            <p>We operate with the highest standards of integrity, transparency, and ethical conduct.</p>
          </div>
          <div class="value-card">
            <div class="value-icon">💡</div>
            <h3>Innovation</h3>
            <p>We embrace innovation to continuously improve our services and member experience.</p>
          </div>
          <div class="value-card">
            <div class="value-icon">🛡️</div>
            <h3>Security</h3>
            <p>We prioritize the security and protection of member assets and personal information.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Leadership Section -->
    <section class="leadership">
      <div class="container">
        <h2>Leadership Team</h2>
        <div class="leadership-grid">
          <div class="leader-card">
            <div class="leader-image">
              <div class="placeholder-image">CEO Photo</div>
            </div>
            <h3>Derek W. Dobson</h3>
            <p class="title">CEO & Plan Manager</p>
            <p>Leading CAAT with a vision for sustainable retirement security and innovative pension solutions.</p>
          </div>
          <div class="leader-card">
            <div class="leader-image">
              <div class="placeholder-image">CIO Photo</div>
            </div>
            <h3>Investment Leadership</h3>
            <p class="title">Chief Investment Officer</p>
            <p>Overseeing investment strategies and portfolio management to maximize member returns.</p>
          </div>
          <div class="leader-card">
            <div class="leader-image">
              <div class="placeholder-image">COO Photo</div>
            </div>
            <h3>Operations Leadership</h3>
            <p class="title">Chief Operating Officer</p>
            <p>Ensuring efficient operations and exceptional service delivery to all stakeholders.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- History Section -->
    <section class="history">
      <div class="container">
        <h2>Our History</h2>
        <div class="timeline">
          <div class="timeline-item">
            <div class="timeline-date">1967</div>
            <div class="timeline-content">
              <h3>Foundation</h3>
              <p>CAAT Pension Plan was established to provide retirement security for college and university employees.</p>
            </div>
          </div>
          <div class="timeline-item">
            <div class="timeline-date">1990s</div>
            <div class="timeline-content">
              <h3>Expansion</h3>
              <p>Expanded services to include comprehensive pension administration and member support programs.</p>
            </div>
          </div>
          <div class="timeline-item">
            <div class="timeline-date">2000s</div>
            <div class="timeline-content">
              <h3>Innovation</h3>
              <p>Launched digital services and online member portals to enhance accessibility and convenience.</p>
            </div>
          </div>
          <div class="timeline-item">
            <div class="timeline-date">Today</div>
            <div class="timeline-content">
              <h3>Future Ready</h3>
              <p>Continuing to evolve with cutting-edge technology and sustainable investment practices.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Statistics Section -->
    <section class="statistics">
      <div class="container">
        <h2>By the Numbers</h2>
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-number">50,000+</div>
            <div class="stat-label">Active Members</div>
          </div>
          <div class="stat-card">
            <div class="stat-number">$15B+</div>
            <div class="stat-label">Assets Under Management</div>
          </div>
          <div class="stat-card">
            <div class="stat-number">500+</div>
            <div class="stat-label">Participating Employers</div>
          </div>
          <div class="stat-card">
            <div class="stat-number">55+</div>
            <div class="stat-label">Years of Service</div>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script>
export default {
  name: 'About'
}
</script>

<style scoped>
.about {
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

/* Mission Section */
.mission {
  padding: 4rem 0;
}

.mission-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem;
  align-items: center;
}

.mission-text h2 {
  margin-bottom: 2rem;
  color: var(--primary-blue);
}

.mission-text p {
  margin-bottom: 1.5rem;
  font-size: 1.1rem;
  line-height: 1.7;
  color: var(--text-dark);
}

.mission-image .placeholder-image {
  background-color: var(--gray-medium);
  height: 250px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--gray-dark);
  font-style: italic;
}

/* Values Section */
.values {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.values h2 {
  text-align: center;
  margin-bottom: 3rem;
  color: var(--primary-blue);
}

.values-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.value-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  text-align: center;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.value-card:hover {
  transform: translateY(-5px);
}

.value-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.value-card h3 {
  margin-bottom: 1rem;
  color: var(--primary-blue);
}

.value-card p {
  color: var(--gray-dark);
  line-height: 1.6;
}

/* Leadership Section */
.leadership {
  padding: 4rem 0;
}

.leadership h2 {
  text-align: center;
  margin-bottom: 3rem;
  color: var(--primary-blue);
}

.leadership-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.leader-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  text-align: center;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  border: 2px solid var(--light-blue);
}

.leader-image .placeholder-image {
  background-color: var(--gray-medium);
  height: 150px;
  width: 150px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--gray-dark);
  font-size: 0.9rem;
  margin: 0 auto 1.5rem;
}

.leader-card h3 {
  margin-bottom: 0.5rem;
  color: var(--primary-blue);
}

.leader-card .title {
  font-weight: 600;
  color: var(--green-accent);
  margin-bottom: 1rem;
}

.leader-card p:last-child {
  color: var(--gray-dark);
  line-height: 1.6;
}

/* History Section */
.history {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.history h2 {
  text-align: center;
  margin-bottom: 3rem;
  color: var(--primary-blue);
}

.timeline {
  max-width: 800px;
  margin: 0 auto;
}

.timeline-item {
  display: grid;
  grid-template-columns: 150px 1fr;
  gap: 2rem;
  margin-bottom: 3rem;
  align-items: start;
}

.timeline-date {
  background-color: var(--primary-blue);
  color: var(--white);
  padding: 1rem;
  border-radius: 10px;
  text-align: center;
  font-weight: 600;
  font-size: 1.1rem;
}

.timeline-content {
  background-color: var(--white);
  padding: 1.5rem;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.timeline-content h3 {
  margin-bottom: 1rem;
  color: var(--primary-blue);
}

.timeline-content p {
  color: var(--gray-dark);
  line-height: 1.6;
}

/* Statistics Section */
.statistics {
  padding: 4rem 0;
  background-color: var(--primary-blue);
  color: var(--white);
}

.statistics h2 {
  text-align: center;
  margin-bottom: 3rem;
  color: var(--white);
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 2rem;
}

.stat-card {
  text-align: center;
  padding: 2rem;
  background-color: rgba(255, 255, 255, 0.1);
  border-radius: 10px;
  backdrop-filter: blur(10px);
}

.stat-number {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--white);
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.9);
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero-content h1 {
    font-size: 2.2rem;
  }
  
  .mission-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .values-grid {
    grid-template-columns: 1fr;
  }
  
  .leadership-grid {
    grid-template-columns: 1fr;
  }
  
  .timeline-item {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .timeline-date {
    width: fit-content;
    margin: 0 auto;
  }
  
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }
}
</style>
