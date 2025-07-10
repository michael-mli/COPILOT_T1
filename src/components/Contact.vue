<template>
  <main class="contact">
    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1>Contact Us</h1>
          <p class="hero-subtitle">Get in touch with our team for support, questions, or more information about your pension plan</p>
        </div>
      </div>
    </section>

    <!-- Contact Options -->
    <section class="contact-options">
      <div class="container">
        <h2>How Can We Help You?</h2>
        <div class="contact-grid">
          <div class="contact-card">
            <div class="contact-icon">📞</div>
            <h3>Phone Support</h3>
            <p>Speak directly with our knowledgeable support team</p>
            <div class="contact-details">
              <p class="phone-number">1-800-CAA-TPEN</p>
              <p class="hours">Monday - Friday: 8:00 AM - 5:00 PM EST</p>
            </div>
          </div>

          <div class="contact-card">
            <div class="contact-icon">✉️</div>
            <h3>Email Support</h3>
            <p>Send us your questions and we'll respond within 24 hours</p>
            <div class="contact-details">
              <p class="email">info@caatpension.ca</p>
              <p class="response-time">Response within 24 hours</p>
            </div>
          </div>

          <div class="contact-card">
            <div class="contact-icon">💬</div>
            <h3>Live Chat</h3>
            <p>Chat with our support team in real-time</p>
            <div class="contact-details">
              <a href="/support/chat" class="btn btn-primary" aria-describedby="chat-support-description">Start Chat</a>
              <div id="chat-support-description" class="visually-hidden">Open live chat support with our team during business hours</div>
              <p class="availability">Available during business hours</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact Form -->
    <section class="contact-form-section">
      <div class="container">
        <div class="form-container">
          <h2>Send Us a Message</h2>
          <form class="contact-form">
            <div class="form-row">
              <div class="form-group">
                <label for="firstName">First Name *</label>
                <input type="text" id="firstName" required>
              </div>
              <div class="form-group">
                <label for="lastName">Last Name *</label>
                <input type="text" id="lastName" required>
              </div>
            </div>
            
            <div class="form-row">
              <div class="form-group">
                <label for="email">Email Address *</label>
                <input type="email" id="email" required>
              </div>
              <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone">
              </div>
            </div>

            <div class="form-group">
              <label for="subject">Subject *</label>
              <select id="subject" required>
                <option value="">Please select a subject</option>
                <option value="general">General Inquiry</option>
                <option value="member">Member Services</option>
                <option value="employer">Employer Services</option>
                <option value="technical">Technical Support</option>
                <option value="complaint">Complaint or Concern</option>
              </select>
            </div>

            <div class="form-group">
              <label for="message">Message *</label>
              <textarea id="message" rows="6" required placeholder="Please provide details about your inquiry..."></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Send Message</button>
          </form>
        </div>
      </div>
    </section>

    <!-- Office Information -->
    <section class="office-info">
      <div class="container">
        <div class="office-grid">
          <div class="office-details">
            <h2>Office Location</h2>
            <div class="address">
              <h3>CAAT Pension Plan</h3>
              <p>123 Bay Street, Suite 2000<br>
                 Toronto, ON M5K 1L5<br>
                 Canada</p>
            </div>
            
            <div class="office-hours">
              <h3>Office Hours</h3>
              <ul>
                <li>Monday - Friday: 8:00 AM - 5:00 PM EST</li>
                <li>Saturday - Sunday: Closed</li>
                <li>Holidays: Closed</li>
              </ul>
            </div>

            <div class="directions">
              <h3>Getting Here</h3>
              <p>Located in the heart of Toronto's financial district, easily accessible by public transit and major highways.</p>
              <a href="https://maps.google.com/maps?q=123+Bay+Street,+Toronto,+ON" class="btn btn-secondary" target="_blank" rel="noopener noreferrer" aria-describedby="directions-description">Get Directions</a>
              <div id="directions-description" class="visually-hidden">Opens Google Maps in a new tab to get directions to our Toronto office</div>
            </div>
          </div>

          <div class="map-placeholder">
            <div class="map-content">
              <h3>Interactive Map</h3>
              <p>Our office is conveniently located in downtown Toronto</p>
              <div class="map-visual" role="img" aria-label="Map showing our Toronto office location at 123 Bay Street">🗺️</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ Section -->
    <section class="quick-faq">
      <div class="container">
        <h2>Frequently Asked Questions</h2>
        <div class="faq-grid">
          <div class="faq-item">
            <h3>How do I access my pension information?</h3>
            <p>You can access your pension information through our secure member portal or by calling our support line.</p>
          </div>
          <div class="faq-item">
            <h3>When will I receive my annual statement?</h3>
            <p>Annual statements are typically sent out in the spring each year, around April or May.</p>
          </div>
          <div class="faq-item">
            <h3>How do I update my contact information?</h3>
            <p>You can update your contact information through the member portal or by submitting a change form.</p>
          </div>
          <div class="faq-item">
            <h3>What should I do if I'm changing jobs?</h3>
            <p>Contact us immediately to discuss your options for transferring or maintaining your pension benefits.</p>
          </div>
        </div>
        <div class="faq-link">
          <a href="/faq" class="btn btn-secondary">View All FAQs</a>
        </div>
      </div>
    </section>
  </main>
</template>

<script>
export default {
  name: 'Contact'
}
</script>

<style scoped>
.contact {
  flex: 1;
}

/* Hero Section */
.hero {
  background: linear-gradient(135deg, var(--light-blue) 0%, var(--white) 100%);
  padding: 4rem 0;
  text-align: center;
}

.hero-content h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
  font-weight: 700;
  color: var(--primary-blue);
}

.hero-subtitle {
  font-size: 1.3rem;
  color: var(--gray-dark);
  max-width: 800px;
  margin: 0 auto;
}

/* Contact Options */
.contact-options {
  padding: 4rem 0;
}

.contact-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.contact-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  text-align: center;
  transition: transform 0.3s ease;
}

.contact-card:hover {
  transform: translateY(-5px);
}

.contact-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.contact-details {
  margin-top: 1rem;
}

.phone-number, .email {
  font-weight: 600;
  color: var(--primary-blue);
  font-size: 1.2rem;
  margin: 0.5rem 0;
}

.hours, .response-time, .availability {
  color: var(--gray-dark);
  font-size: 0.9rem;
}

/* Contact Form */
.contact-form-section {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.form-container {
  max-width: 800px;
  margin: 0 auto;
  background-color: var(--white);
  padding: 3rem;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.contact-form {
  margin-top: 2rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: var(--text-dark);
}

.form-group input,
.form-group select,
.form-group textarea {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid var(--gray-medium);
  border-radius: 5px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  outline: none;
  border-color: var(--primary-blue);
}

/* Office Information */
.office-info {
  padding: 4rem 0;
}

.office-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  margin-top: 2rem;
}

.office-details h3 {
  color: var(--primary-blue);
  margin-bottom: 1rem;
}

.address, .office-hours, .directions {
  margin-bottom: 2rem;
}

.office-hours ul {
  list-style: none;
  padding: 0;
}

.office-hours li {
  margin-bottom: 0.5rem;
}

.map-placeholder {
  background-color: var(--gray-light);
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 300px;
}

.map-content {
  text-align: center;
}

.map-visual {
  font-size: 4rem;
  margin-top: 1rem;
}

/* FAQ Section */
.quick-faq {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.faq-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.faq-item {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.faq-item h3 {
  color: var(--primary-blue);
  margin-bottom: 1rem;
}

.faq-link {
  text-align: center;
  margin-top: 3rem;
}

/* Accessibility Styles */
.visually-hidden {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

/* Enhanced focus styles */
.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  outline: 2px solid var(--primary-blue);
  outline-offset: 2px;
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero-content h1 {
    font-size: 2.2rem;
  }
  
  .hero-subtitle {
    font-size: 1.1rem;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .office-grid {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .form-container {
    padding: 2rem;
  }
  
  .contact-grid,
  .faq-grid {
    grid-template-columns: 1fr;
  }
}
</style>
