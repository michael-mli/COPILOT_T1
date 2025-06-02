<template>
  <main class="news">
    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1>News & Updates</h1>
          <p class="hero-subtitle">Stay informed about the latest developments, announcements, and updates from CAAT Pension Plan</p>
        </div>
      </div>
    </section>

    <!-- Latest News -->
    <section class="latest-news">
      <div class="container">
        <h2>Latest News</h2>
        <div class="news-grid">
          <article class="news-article featured">
            <div class="article-image">
              <div class="placeholder-image">Featured News Image</div>
            </div>
            <div class="article-content">
              <div class="article-meta">
                <span class="date">December 15, 2024</span>
                <span class="category">Plan Updates</span>
              </div>
              <h3>CAAT Pension Plan Announces Strong Performance for 2024</h3>
              <p>The CAAT Pension Plan is pleased to report strong investment performance and continued growth in membership for the 2024 fiscal year.</p>
              <a href="#" class="read-more">Read Full Article →</a>
            </div>
          </article>

          <article class="news-article">
            <div class="article-image">
              <div class="placeholder-image">News Image 1</div>
            </div>
            <div class="article-content">
              <div class="article-meta">
                <span class="date">November 28, 2024</span>
                <span class="category">Digital Services</span>
              </div>
              <h3>Enhanced Online Portal Now Available</h3>
              <p>We've launched an upgraded member portal with new features and improved user experience.</p>
              <a href="#" class="read-more">Read More →</a>
            </div>
          </article>

          <article class="news-article">
            <div class="article-image">
              <div class="placeholder-image">News Image 2</div>
            </div>
            <div class="article-content">
              <div class="article-meta">
                <span class="date">November 10, 2024</span>
                <span class="category">Sustainability</span>
              </div>
              <h3>Commitment to Sustainable Investing</h3>
              <p>Learn about our continued commitment to responsible investment practices and ESG initiatives.</p>
              <a href="#" class="read-more">Read More →</a>
            </div>
          </article>

          <article class="news-article">
            <div class="article-image">
              <div class="placeholder-image">News Image 3</div>
            </div>
            <div class="article-content">
              <div class="article-meta">
                <span class="date">October 22, 2024</span>
                <span class="category">Member Services</span>
              </div>
              <h3>New Retirement Planning Workshops</h3>
              <p>Join our upcoming retirement planning workshops designed to help members prepare for their future.</p>
              <a href="#" class="read-more">Read More →</a>
            </div>
          </article>
        </div>
      </div>
    </section>

    <!-- News Categories -->
    <section class="news-categories">
      <div class="container">
        <h2>Browse by Category</h2>
        <div class="categories-grid">
          <div class="category-card">
            <div class="category-icon">📊</div>
            <h3>Plan Performance</h3>
            <p>Investment returns, financial reports, and plan performance updates</p>
            <a href="#" class="category-link">View Articles →</a>
          </div>
          <div class="category-card">
            <div class="category-icon">💻</div>
            <h3>Digital Updates</h3>
            <p>Technology improvements, portal enhancements, and digital services</p>
            <a href="#" class="category-link">View Articles →</a>
          </div>
          <div class="category-card">
            <div class="category-icon">🌱</div>
            <h3>Sustainability</h3>
            <p>ESG initiatives, responsible investing, and environmental commitments</p>
            <a href="#" class="category-link">View Articles →</a>
          </div>
          <div class="category-card">
            <div class="category-icon">🎓</div>
            <h3>Education</h3>
            <p>Workshops, seminars, and educational resources for members</p>
            <a href="#" class="category-link">View Articles →</a>
          </div>
        </div>
      </div>
    </section>

    <!-- Newsletter Signup -->
    <section class="newsletter">
      <div class="container">
        <div class="newsletter-content">
          <h2>Stay Informed</h2>
          <p>Subscribe to our newsletter to receive the latest updates and important announcements directly in your inbox.</p>
          <form class="newsletter-form">
            <input type="email" placeholder="Enter your email address" required>
            <button type="submit" class="btn btn-primary">Subscribe</button>
          </form>
        </div>
      </div>
    </section>
  </main>
</template>

<script>
export default {
  name: 'News'
}
</script>

<style scoped>
.news {
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

/* Latest News */
.latest-news {
  padding: 4rem 0;
}

.news-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.news-article {
  background-color: var(--white);
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  transition: transform 0.3s ease;
}

.news-article:hover {
  transform: translateY(-5px);
}

.news-article.featured {
  grid-column: span 2;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 0;
}

.article-image {
  height: 200px;
  overflow: hidden;
}

.featured .article-image {
  height: auto;
}

.placeholder-image {
  width: 100%;
  height: 100%;
  background-color: var(--gray-light);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--gray-dark);
  font-weight: 600;
}

.article-content {
  padding: 2rem;
}

.article-meta {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
  font-size: 0.9rem;
}

.date {
  color: var(--gray-dark);
}

.category {
  background-color: var(--green-accent);
  color: var(--white);
  padding: 0.2rem 0.8rem;
  border-radius: 15px;
  font-weight: 600;
}

.article-content h3 {
  margin-bottom: 1rem;
  color: var(--primary-blue);
}

.read-more {
  color: var(--primary-blue);
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease;
}

.read-more:hover {
  color: var(--green-accent);
}

/* News Categories */
.news-categories {
  padding: 4rem 0;
  background-color: var(--gray-light);
}

.categories-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.category-card {
  background-color: var(--white);
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  text-align: center;
  transition: transform 0.3s ease;
}

.category-card:hover {
  transform: translateY(-5px);
}

.category-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.category-link {
  color: var(--primary-blue);
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease;
}

.category-link:hover {
  color: var(--green-accent);
}

/* Newsletter */
.newsletter {
  padding: 4rem 0;
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
  color: var(--white);
}

.newsletter-content {
  text-align: center;
  max-width: 600px;
  margin: 0 auto;
}

.newsletter-form {
  display: flex;
  gap: 1rem;
  margin-top: 2rem;
  max-width: 400px;
  margin-left: auto;
  margin-right: auto;
}

.newsletter-form input {
  flex: 1;
  padding: 0.75rem;
  border: none;
  border-radius: 5px;
  font-size: 1rem;
}

.newsletter-form button {
  white-space: nowrap;
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero-content h1 {
    font-size: 2.2rem;
  }
  
  .hero-subtitle {
    font-size: 1.1rem;
  }
  
  .news-article.featured {
    grid-column: span 1;
    grid-template-columns: 1fr;
  }
  
  .newsletter-form {
    flex-direction: column;
    gap: 1rem;
  }
  
  .article-meta {
    flex-direction: column;
    gap: 0.5rem;
  }
}
</style>
