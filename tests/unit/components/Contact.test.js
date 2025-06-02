import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import Contact from '../../../src/components/Contact.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/contact', component: Contact }
  ]
})

describe('Contact.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/contact')
    await router.isReady()
    
    wrapper = mount(Contact, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.contact').exists()).toBe(true)
  })

  it('has the correct component name', () => {
    expect(wrapper.vm.$options.name).toBe('Contact')
  })

  it('displays the hero section with correct content', () => {
    const hero = wrapper.find('.hero')
    expect(hero.exists()).toBe(true)
    
    const title = hero.find('h1')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Contact Us')
    
    const subtitle = hero.find('.hero-subtitle')
    expect(subtitle.exists()).toBe(true)
    expect(subtitle.text()).toContain('Get in touch')
  })

  it('displays contact options section', () => {
    const optionsSection = wrapper.find('.contact-options')
    expect(optionsSection.exists()).toBe(true)
    
    const title = optionsSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('How Can We Help You?')
    
    const contactCards = optionsSection.findAll('.contact-card')
    expect(contactCards.length).toBeGreaterThanOrEqual(3)
    
    // Check for specific contact methods
    const cardTitles = contactCards.map(card => card.find('h3').text())
    expect(cardTitles).toContain('Phone Support')
    expect(cardTitles).toContain('Email Support')
    expect(cardTitles).toContain('Live Chat')
  })

  it('displays phone contact information correctly', () => {
    const phoneCard = wrapper.findAll('.contact-card').find(card => 
      card.find('h3').text() === 'Phone Support'
    )
    expect(phoneCard).toBeDefined()
    
    const phoneNumber = phoneCard.find('.phone-number')
    expect(phoneNumber.exists()).toBe(true)
    expect(phoneNumber.text()).toBe('1-800-CAA-TPEN')
    
    const hours = phoneCard.find('.hours')
    expect(hours.exists()).toBe(true)
    expect(hours.text()).toContain('Monday - Friday')
  })

  it('displays email contact information correctly', () => {
    const emailCard = wrapper.findAll('.contact-card').find(card => 
      card.find('h3').text() === 'Email Support'
    )
    expect(emailCard).toBeDefined()
    
    const email = emailCard.find('.email')
    expect(email.exists()).toBe(true)
    expect(email.text()).toBe('info@caatpension.ca')
    
    const responseTime = emailCard.find('.response-time')
    expect(responseTime.exists()).toBe(true)
    expect(responseTime.text()).toContain('24 hours')
  })

  it('displays contact form section', () => {
    const formSection = wrapper.find('.contact-form-section')
    expect(formSection.exists()).toBe(true)
    
    const title = formSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Send Us a Message')
    
    const form = formSection.find('.contact-form')
    expect(form.exists()).toBe(true)
  })

  it('has properly structured contact form', () => {
    const form = wrapper.find('.contact-form')
    
    // Check for required form fields
    const nameInput = form.find('input[placeholder*="name"]')
    expect(nameInput.exists()).toBe(true)
    
    const emailInput = form.find('input[type="email"]')
    expect(emailInput.exists()).toBe(true)
    
    const subjectInput = form.find('input[placeholder*="subject"]')
    expect(subjectInput.exists()).toBe(true)
    
    const messageTextarea = form.find('textarea')
    expect(messageTextarea.exists()).toBe(true)
    
    const submitButton = form.find('.btn-primary')
    expect(submitButton.exists()).toBe(true)
    expect(submitButton.text()).toBe('Send Message')
  })

  it('displays office information section', () => {
    const officeSection = wrapper.find('.office-info')
    expect(officeSection.exists()).toBe(true)
    
    const title = officeSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Visit Our Office')
    
    // Check for address information
    const address = officeSection.find('.office-address')
    expect(address.exists()).toBe(true)
    
    // Check for office hours
    const hours = officeSection.find('.office-hours')
    expect(hours.exists()).toBe(true)
  })

  it('displays map section', () => {
    const mapSection = wrapper.find('.map-placeholder')
    expect(mapSection.exists()).toBe(true)
    
    const mapContent = mapSection.find('.map-content')
    expect(mapContent.exists()).toBe(true)
    
    const mapTitle = mapContent.find('h3')
    expect(mapTitle.exists()).toBe(true)
    expect(mapTitle.text()).toBe('Interactive Map')
  })

  it('displays FAQ section', () => {
    const faqSection = wrapper.find('.quick-faq')
    expect(faqSection.exists()).toBe(true)
    
    const title = faqSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Frequently Asked Questions')
    
    const faqItems = faqSection.findAll('.faq-item')
    expect(faqItems.length).toBeGreaterThanOrEqual(3)
    
    // Each FAQ item should have a question and answer
    faqItems.forEach(item => {
      expect(item.find('h3').exists()).toBe(true)
      expect(item.find('p').exists()).toBe(true)
    })
  })

  it('has proper CSS styling structure', () => {
    expect(wrapper.find('.hero').exists()).toBe(true)
    expect(wrapper.find('.container').exists()).toBe(true)
    expect(wrapper.find('.contact-grid').exists()).toBe(true)
    expect(wrapper.find('.form-container').exists()).toBe(true)
    expect(wrapper.find('.office-grid').exists()).toBe(true)
    expect(wrapper.find('.faq-grid').exists()).toBe(true)
  })

  it('contains interactive elements', () => {
    // Check for buttons
    const buttons = wrapper.findAll('.btn')
    expect(buttons.length).toBeGreaterThan(0)
    
    // Check for form inputs
    const inputs = wrapper.findAll('input')
    expect(inputs.length).toBeGreaterThan(0)
    
    const textarea = wrapper.find('textarea')
    expect(textarea.exists()).toBe(true)
    
    // Check for contact links
    const chatButton = wrapper.find('.contact-card .btn-primary')
    expect(chatButton.exists()).toBe(true)
  })

  it('displays contact icons correctly', () => {
    const contactCards = wrapper.findAll('.contact-card')
    
    contactCards.forEach(card => {
      const icon = card.find('.contact-icon')
      expect(icon.exists()).toBe(true)
      expect(icon.text()).toMatch(/[📞✉️💬]/) // Should contain emoji icons
    })
  })

  it('renders without JavaScript errors', () => {
    expect(wrapper.vm).toBeTruthy()
    expect(wrapper.html()).toBeTruthy()
  })

  it('follows CAAT branding guidelines', () => {
    const html = wrapper.html()
    
    // Check for CAAT-related content
    expect(html).toContain('Contact')
    expect(html).toContain('pension')
    
    // Check for proper CSS classes
    expect(wrapper.find('.hero').exists()).toBe(true)
    expect(wrapper.find('.btn-primary').exists()).toBe(true)
    expect(wrapper.find('.btn-secondary').exists()).toBe(true)
  })

  it('includes comprehensive contact information', () => {
    const html = wrapper.html()
    
    // Check for all contact methods
    expect(html).toContain('Phone')
    expect(html).toContain('Email')
    expect(html).toContain('Chat')
    expect(html).toContain('Office')
    expect(html).toContain('FAQ')
  })

  it('has accessible form elements', () => {
    const form = wrapper.find('.contact-form')
    
    // Check for proper input attributes
    const inputs = form.findAll('input')
    inputs.forEach(input => {
      expect(input.attributes('placeholder')).toBeDefined()
    })
    
    const textarea = form.find('textarea')
    expect(textarea.attributes('placeholder')).toBeDefined()
  })
})
