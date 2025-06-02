import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import Home from '../../../src/components/Home.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: Home },
    { path: '/about', component: { template: '<div>About</div>' } },
    { path: '/members', component: { template: '<div>Members</div>' } },
    { path: '/employers', component: { template: '<div>Employers</div>' } },
  ]
})

describe('Home.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/')
    await router.isReady()
    
    wrapper = mount(Home, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.home').exists()).toBe(true)
  })

  it('displays the hero section with correct content', () => {
    const heroSection = wrapper.find('.hero')
    expect(heroSection.exists()).toBe(true)
    
    const heroTitle = wrapper.find('.hero-content h1')
    expect(heroTitle.text()).toBe('Our purpose is to improve retirement security for Canadians')
    
    const heroSubtitle = wrapper.find('.hero-subtitle')
    expect(heroSubtitle.text()).toBe('Because we believe that every Canadian deserves to retire well.')
    
    const heroActions = wrapper.find('.hero-actions')
    expect(heroActions.exists()).toBe(true)
  })

  it('has correct action buttons in hero section', () => {
    const actionButtons = wrapper.findAll('.hero-actions .btn')
    expect(actionButtons.length).toBe(2)
    
    expect(actionButtons[0].text()).toBe('For Members')
    expect(actionButtons[0].attributes('to')).toBe('/members')
    expect(actionButtons[0].classes()).toContain('btn-primary')
    
    expect(actionButtons[1].text()).toBe('For Employers')
    expect(actionButtons[1].attributes('to')).toBe('/employers')
    expect(actionButtons[1].classes()).toContain('btn-secondary')
  })

  it('displays CEO message section', () => {
    const ceoSection = wrapper.find('.ceo-message')
    expect(ceoSection.exists()).toBe(true)
    
    const blockquote = wrapper.find('.message-text blockquote')
    expect(blockquote.exists()).toBe(true)
    expect(blockquote.text()).toContain('Our commitment remains unwavering')
    
    const cite = wrapper.find('.message-text cite')
    expect(cite.text()).toBe('Derek W. Dobson, CEO & Plan Manager')
  })

  it('displays what\'s new section with news items', () => {
    const whatsNewSection = wrapper.find('.whats-new')
    expect(whatsNewSection.exists()).toBe(true)
    
    const sectionTitle = wrapper.find('.whats-new h2')
    expect(sectionTitle.text()).toBe('What\'s new with CAAT')
    
    const newsItems = wrapper.findAll('.news-item')
    expect(newsItems.length).toBe(3)
    
    // Check first news item
    const firstNews = newsItems[0]
    expect(firstNews.find('h3').text()).toBe('2024 Annual Report Released')
    expect(firstNews.find('.read-more').exists()).toBe(true)
    expect(firstNews.find('.read-more').text()).toBe('Read More →')
  })

  it('displays services section with service cards', () => {
    const servicesSection = wrapper.find('.services')
    expect(servicesSection.exists()).toBe(true)
    
    const serviceCards = wrapper.findAll('.service-card')
    expect(serviceCards.length).toBe(4)
    
    const expectedServices = [
      'Pension Administration',
      'Investment Management', 
      'Retirement Planning',
      'Benefits Protection'
    ]
    
    serviceCards.forEach((card, index) => {
      expect(card.find('h3').text()).toBe(expectedServices[index])
      expect(card.find('.service-icon').exists()).toBe(true)
      expect(card.find('p').exists()).toBe(true)
    })
  })

  it('displays quick access section', () => {
    const quickAccessSection = wrapper.find('.quick-access')
    expect(quickAccessSection.exists()).toBe(true)
    
    const accessCards = wrapper.findAll('.access-card')
    expect(accessCards.length).toBe(3)
    
    const expectedTitles = ['Member Portal', 'Employer Resources', 'Forms & Documents']
    accessCards.forEach((card, index) => {
      expect(card.find('h3').text()).toBe(expectedTitles[index])
      expect(card.find('.btn').exists()).toBe(true)
    })
  })

  it('has all required sections', () => {
    const sections = [
      '.hero',
      '.ceo-message', 
      '.whats-new',
      '.services',
      '.quick-access'
    ]
    
    sections.forEach(sectionClass => {
      expect(wrapper.find(sectionClass).exists()).toBe(true)
    })
  })

  it('contains proper grid layouts', () => {
    expect(wrapper.find('.news-grid').exists()).toBe(true)
    expect(wrapper.find('.services-grid').exists()).toBe(true)
    expect(wrapper.find('.access-grid').exists()).toBe(true)
  })

  it('has placeholder images for visual elements', () => {
    const placeholderImages = wrapper.findAll('.placeholder-image')
    expect(placeholderImages.length).toBeGreaterThan(0)
  })

  it('has proper semantic HTML structure', () => {
    expect(wrapper.find('main').exists()).toBe(true)
    expect(wrapper.findAll('section').length).toBe(5)
    expect(wrapper.findAll('article').length).toBe(3) // News articles
  })

  it('applies correct CSS classes for styling', () => {
    const expectedClasses = [
      '.container',
      '.hero-content',
      '.message-content',
      '.news-grid',
      '.services-grid',
      '.access-grid'
    ]
    
    expectedClasses.forEach(className => {
      expect(wrapper.find(className).exists()).toBe(true)
    })
  })
})
