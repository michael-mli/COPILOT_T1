<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-section">
          <h3>CAAT Pension Plan</h3>
          <p>Improving retirement security for Canadians through reliable pension management and exceptional service.</p>
          <div class="social-links">
            <a href="#" aria-label="LinkedIn">📘</a>
            <a href="#" aria-label="Twitter">🐦</a>
            <a href="#" aria-label="Facebook">📱</a>
          </div>
        </div>

        <div class="footer-section">
          <h4>Quick Links</h4>
          <ul>
            <li><router-link to="/about">About Us</router-link></li>
            <li><router-link to="/services">Services</router-link></li>
            <li><router-link to="/news">News & Updates</router-link></li>
            <li><router-link to="/careers">Careers</router-link></li>
          </ul>
        </div>

        <div class="footer-section">
          <h4>For Members</h4>
          <ul>
            <li><a href="#">Member Portal</a></li>
            <li><a href="#">Forms & Documents</a></li>
            <li><a href="#">Retirement Calculator</a></li>
            <li><a href="#">FAQs</a></li>
          </ul>
        </div>

        <div class="footer-section">
          <h4>For Employers</h4>
          <ul>
            <li><a href="#">Employer Portal</a></li>
            <li><a href="#">Contribution Guidelines</a></li>
            <li><a href="#">Resources</a></li>
            <li><a href="#">Contact Support</a></li>
          </ul>
        </div>

        <div class="footer-section">
          <h4>Contact Information</h4>
          <div class="contact-info">
            <p>📞 1-800-CAA-TPEN</p>
            <p>✉️ info@caatpension.ca</p>
            <p>📍 Toronto, Ontario, Canada</p>
          </div>
        </div>
      </div>

      <div class="footer-bottom">
        <div class="footer-bottom-content">
          <p>&copy; 2025 CAAT Pension Plan. All rights reserved.</p>
          <div class="footer-links">
            <a href="#">Privacy Policy</a>
            <span>|</span>
            <a href="#">Terms of Service</a>
            <span>|</span>
            <a href="#">Accessibility</a>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'AppFooter'
}
</script>

<style scoped>
.footer {
  background-color: var(--dark-blue);
  color: var(--white);
  margin-top: auto;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  padding: 3rem 0;
}

.footer-section h3 {
  color: var(--white);
  margin-bottom: 1rem;
  font-size: 1.5rem;
}

.footer-section h4 {
  color: var(--white);
  margin-bottom: 1rem;
  font-size: 1.2rem;
  font-weight: 600;
}

.footer-section p {
  color: #cccccc;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.footer-section ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-section ul li {
  margin-bottom: 0.5rem;
}

.footer-section ul li a {
  color: #cccccc;
  text-decoration: none;
  transition: color 0.3s ease;
}

.footer-section ul li a:hover {
  color: var(--white);
}

.social-links {
  display: flex;
  gap: 1rem;
  margin-top: 1rem;
}

.social-links a {
  display: inline-block;
  width: 40px;
  height: 40px;
  background-color: var(--primary-blue);
  border-radius: 50%;
  text-align: center;
  line-height: 40px;
  text-decoration: none;
  transition: background-color 0.3s ease;
}

.social-links a:hover {
  background-color: var(--secondary-blue);
}

.contact-info p {
  margin-bottom: 0.5rem;
  font-size: 0.95rem;
}

.footer-bottom {
  border-top: 1px solid #555;
  padding: 1.5rem 0;
}

.footer-bottom-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
}

.footer-bottom p {
  color: #cccccc;
  margin: 0;
}

.footer-links {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.footer-links a {
  color: #cccccc;
  text-decoration: none;
  font-size: 0.9rem;
  transition: color 0.3s ease;
}

.footer-links a:hover {
  color: var(--white);
}

.footer-links span {
  color: #666;
}

@media (max-width: 768px) {
  .footer-content {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .footer-bottom-content {
    flex-direction: column;
    text-align: center;
    gap: 1rem;
  }
  
  .footer-links {
    flex-wrap: wrap;
    justify-content: center;
  }
}
</style>
