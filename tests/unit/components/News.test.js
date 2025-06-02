import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import News from '../../../src/components/News.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/news', component: News }
  ]
})

describe('News.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/news')
    await router.isReady()
    
    wrapper = mount(News, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.news').exists()).toBe(true)
  })

  it('has the correct component name', () => {
    expect(wrapper.vm.$options.name).toBe('News')
  })

  it('displays the hero section with correct content', () => {
    const hero = wrapper.find('.hero')
    expect(hero.exists()).toBe(true)
    
    const title = hero.find('h1')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('News & Updates')
    
    const subtitle = hero.find('.hero-subtitle')
    expect(subtitle.exists()).toBe(true)
    expect(subtitle.text()).toContain('Stay informed')
  })

  it('displays latest news section', () => {
    const latestSection = wrapper.find('.latest-news')
    expect(latestSection.exists()).toBe(true)
    
    const title = latestSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Latest News')
    
    const newsCards = latestSection.findAll('.news-card')
    expect(newsCards.length).toBeGreaterThan(0)
  })

  it('displays news articles with proper structure', () => {
    const newsCards = wrapper.findAll('.news-card')
    
    newsCards.forEach(card => {
      // Each news card should have a title
      expect(card.find('h3').exists()).toBe(true)
      
      // Each news card should have a date
      expect(card.find('.news-date').exists()).toBe(true)
      
      // Each news card should have content
      expect(card.find('p').exists()).toBe(true)
      
      // Each news card should have a read more link
      expect(card.find('.read-more').exists()).toBe(true)
    })
  })

  it('displays news categories section', () => {
    const categoriesSection = wrapper.find('.news-categories')
    expect(categoriesSection.exists()).toBe(true)
    
    const title = categoriesSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Browse by Category')
    
    const categoryCards = categoriesSection.findAll('.category-card')
    expect(categoryCards.length).toBeGreaterThan(0)
    
    // Check for specific categories
    const categoryTitles = categoryCards.map(card => card.find('h3').text())
    expect(categoryTitles).toContain('Plan Updates')
    expect(categoryTitles).toContain('Market Insights')
    expect(categoryTitles).toContain('Member Benefits')
    expect(categoryTitles).toContain('Regulatory Changes')
  })

  it('displays newsletter signup section', () => {
    const newsletterSection = wrapper.find('.newsletter-signup')
    expect(newsletterSection.exists()).toBe(true)
    
    const title = newsletterSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Stay Connected')
    
    // Check for form elements
    const emailInput = newsletterSection.find('input[type="email"]')
    expect(emailInput.exists()).toBe(true)
    expect(emailInput.attributes('placeholder')).toContain('email')
    
    const subscribeButton = newsletterSection.find('.btn-primary')
    expect(subscribeButton.exists()).toBe(true)
    expect(subscribeButton.text()).toBe('Subscribe')
  })

  it('has proper CSS styling structure', () => {
    expect(wrapper.find('.hero').exists()).toBe(true)
    expect(wrapper.find('.container').exists()).toBe(true)
    expect(wrapper.find('.news-grid').exists()).toBe(true)
    expect(wrapper.find('.categories-grid').exists()).toBe(true)
    expect(wrapper.find('.newsletter-form').exists()).toBe(true)
  })

  it('contains interactive elements', () => {
    // Check for read more links
    const readMoreLinks = wrapper.findAll('.read-more')
    expect(readMoreLinks.length).toBeGreaterThan(0)
    
    // Check for category links
    const categoryLinks = wrapper.findAll('.category-card a')
    expect(categoryLinks.length).toBeGreaterThan(0)
    
    // Check for newsletter form
    const form = wrapper.find('.newsletter-form')
    expect(form.exists()).toBe(true)
    
    const submitButton = wrapper.find('.btn-primary')
    expect(submitButton.exists()).toBe(true)
  })

  it('displays proper date formatting', () => {
    const dates = wrapper.findAll('.news-date')
    
    dates.forEach(date => {
      const dateText = date.text()
      // Should contain month names or date-like patterns
      expect(dateText).toMatch(/\w+\s+\d{1,2},\s+\d{4}|\d{1,2}\/\d{1,2}\/\d{4}/)
    })
  })

  it('renders without JavaScript errors', () => {
    expect(wrapper.vm).toBeTruthy()
    expect(wrapper.html()).toBeTruthy()
  })

  it('follows CAAT branding guidelines', () => {
    const html = wrapper.html()
    
    // Check for CAAT-related content
    expect(html).toContain('News')
    expect(html).toContain('pension')
    
    // Check for proper CSS classes
    expect(wrapper.find('.hero').exists()).toBe(true)
    expect(wrapper.find('.btn-primary').exists()).toBe(true)
    expect(wrapper.find('.btn-secondary').exists()).toBe(true)
  })

  it('includes comprehensive news content', () => {
    const html = wrapper.html()
    
    // Check for news-related terms
    expect(html).toContain('Updates')
    expect(html).toContain('Newsletter')
    expect(html).toContain('Subscribe')
    
    // Check for proper article structure
    const articles = wrapper.findAll('.news-card')
    expect(articles.length).toBeGreaterThanOrEqual(3) // Should have multiple news items
  })

  it('has accessible form elements', () => {
    const emailInput = wrapper.find('input[type="email"]')
    expect(emailInput.exists()).toBe(true)
    
    // Should have proper input attributes
    expect(emailInput.attributes('placeholder')).toBeDefined()
    expect(emailInput.attributes('required')).toBeDefined()
  })
})
