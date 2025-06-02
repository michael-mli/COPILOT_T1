import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import Employers from '../../../src/components/Employers.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/employers', component: Employers }
  ]
})

describe('Employers.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/employers')
    await router.isReady()
    
    wrapper = mount(Employers, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.employers').exists()).toBe(true)
  })

  it('has the correct component name', () => {
    expect(wrapper.vm.$options.name).toBe('Employers')
  })

  it('displays the hero section with correct content', () => {
    const hero = wrapper.find('.hero')
    expect(hero.exists()).toBe(true)
    
    const title = hero.find('h1')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Employer Resources')
    
    const subtitle = hero.find('.hero-subtitle')
    expect(subtitle.exists()).toBe(true)
    expect(subtitle.text()).toContain('Comprehensive pension solutions')
  })

  it('displays employer portal access section', () => {
    const portalSection = wrapper.find('.employer-portal')
    expect(portalSection.exists()).toBe(true)
    
    const title = portalSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Employer Portal')
    
    const loginButton = portalSection.find('.btn-primary')
    expect(loginButton.exists()).toBe(true)
    expect(loginButton.text()).toBe('Access Portal')
  })

  it('displays services section with service offerings', () => {
    const servicesSection = wrapper.find('.employer-services')
    expect(servicesSection.exists()).toBe(true)
    
    const title = servicesSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Our Services')
    
    const serviceCards = servicesSection.findAll('.service-card')
    expect(serviceCards.length).toBeGreaterThan(0)
    
    // Check for specific services
    const serviceTitles = serviceCards.map(card => card.find('h3').text())
    expect(serviceTitles).toContain('Plan Administration')
    expect(serviceTitles).toContain('Employee Education')
    expect(serviceTitles).toContain('Compliance Support')
  })

  it('displays implementation process section', () => {
    const processSection = wrapper.find('.implementation-process')
    expect(processSection.exists()).toBe(true)
    
    const title = processSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Implementation Process')
    
    const processSteps = processSection.findAll('.process-step')
    expect(processSteps.length).toBeGreaterThan(0)
    
    // Check for step numbers
    const stepNumbers = processSteps.map(step => step.find('.step-number').text())
    expect(stepNumbers).toContain('1')
    expect(stepNumbers).toContain('2')
    expect(stepNumbers).toContain('3')
    expect(stepNumbers).toContain('4')
  })

  it('displays support section with contact information', () => {
    const supportSection = wrapper.find('.employer-support')
    expect(supportSection.exists()).toBe(true)
    
    const title = supportSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Dedicated Support')
    
    const supportCards = supportSection.findAll('.support-card')
    expect(supportCards.length).toBeGreaterThan(0)
    
    // Check for dedicated support features
    const supportTitles = supportCards.map(card => card.find('h3').text())
    expect(supportTitles).toContain('Account Manager')
    expect(supportTitles).toContain('Technical Support')
    expect(supportTitles).toContain('Training & Resources')
  })

  it('has proper CSS styling structure', () => {
    expect(wrapper.find('.hero').exists()).toBe(true)
    expect(wrapper.find('.container').exists()).toBe(true)
    expect(wrapper.find('.portal-grid').exists()).toBe(true)
    expect(wrapper.find('.services-grid').exists()).toBe(true)
    expect(wrapper.find('.process-grid').exists()).toBe(true)
    expect(wrapper.find('.support-grid').exists()).toBe(true)
  })

  it('contains interactive elements', () => {
    // Check for buttons
    const buttons = wrapper.findAll('.btn')
    expect(buttons.length).toBeGreaterThan(0)
    
    // Check for specific action buttons
    const primaryButtons = wrapper.findAll('.btn-primary')
    expect(primaryButtons.length).toBeGreaterThan(0)
    
    const secondaryButtons = wrapper.findAll('.btn-secondary')
    expect(secondaryButtons.length).toBeGreaterThan(0)
  })

  it('displays contact information correctly', () => {
    const html = wrapper.html()
    
    // Should contain contact information
    expect(html).toContain('Contact Us')
    expect(html).toContain('Get Started')
  })

  it('renders without JavaScript errors', () => {
    expect(wrapper.vm).toBeTruthy()
    expect(wrapper.html()).toBeTruthy()
  })

  it('follows CAAT branding guidelines', () => {
    const html = wrapper.html()
    
    // Check for CAAT-related content
    expect(html).toContain('Employer')
    expect(html).toContain('pension')
    
    // Check for proper CSS classes
    expect(wrapper.find('.hero').exists()).toBe(true)
    expect(wrapper.find('.btn-primary').exists()).toBe(true)
    expect(wrapper.find('.btn-secondary').exists()).toBe(true)
  })

  it('includes comprehensive service information', () => {
    const html = wrapper.html()
    
    // Check for key employer-related terms
    expect(html).toContain('Administration')
    expect(html).toContain('Implementation')
    expect(html).toContain('Support')
    expect(html).toContain('Education')
  })
})
