import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import Members from '../../../src/components/Members.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/members', component: Members }
  ]
})

describe('Members.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/members')
    await router.isReady()
    
    wrapper = mount(Members, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.members').exists()).toBe(true)
  })

  it('has the correct component name', () => {
    expect(wrapper.vm.$options.name).toBe('Members')
  })

  it('displays the hero section with correct content', () => {
    const hero = wrapper.find('.hero')
    expect(hero.exists()).toBe(true)
    
    const title = hero.find('h1')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Member Resources')
    
    const subtitle = hero.find('.hero-subtitle')
    expect(subtitle.exists()).toBe(true)
    expect(subtitle.text()).toContain('Access your pension information')
  })

  it('displays member portal access section', () => {
    const portalSection = wrapper.find('.member-portal')
    expect(portalSection.exists()).toBe(true)
    
    const title = portalSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Member Portal Access')
    
    const loginButton = portalSection.find('.btn-primary')
    expect(loginButton.exists()).toBe(true)
    expect(loginButton.text()).toBe('Login to Portal')
  })

  it('displays planning tools section with correct items', () => {
    const planningSection = wrapper.find('.planning-tools')
    expect(planningSection.exists()).toBe(true)
    
    const title = planningSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Retirement Planning Tools')
    
    const toolCards = planningSection.findAll('.tool-card')
    expect(toolCards.length).toBeGreaterThan(0)
    
    // Check for specific tools
    const toolTitles = toolCards.map(card => card.find('h3').text())
    expect(toolTitles).toContain('Retirement Calculator')
    expect(toolTitles).toContain('Pension Projector')
    expect(toolTitles).toContain('Benefit Estimator')
  })

  it('displays resources section with document links', () => {
    const resourcesSection = wrapper.find('.member-resources')
    expect(resourcesSection.exists()).toBe(true)
    
    const title = resourcesSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Important Resources')
    
    const resourceCards = resourcesSection.findAll('.resource-category')
    expect(resourceCards.length).toBeGreaterThan(0)
    
    // Check for download links
    const downloadLinks = resourcesSection.findAll('a[href="#"]')
    expect(downloadLinks.length).toBeGreaterThan(0)
  })

  it('displays support section with contact information', () => {
    const supportSection = wrapper.find('.member-support')
    expect(supportSection.exists()).toBe(true)
    
    const title = supportSection.find('h2')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Need Help?')
    
    const supportCards = supportSection.findAll('.support-card')
    expect(supportCards.length).toBeGreaterThan(0)
    
    // Check for phone number
    const phoneNumber = supportSection.find('.contact-info')
    expect(phoneNumber.exists()).toBe(true)
    expect(phoneNumber.text()).toBe('1-800-CAA-TPEN')
  })

  it('has proper CSS styling structure', () => {
    expect(wrapper.find('.hero').exists()).toBe(true)
    expect(wrapper.find('.container').exists()).toBe(true)
    expect(wrapper.find('.portal-grid').exists()).toBe(true)
    expect(wrapper.find('.tools-grid').exists()).toBe(true)
    expect(wrapper.find('.resources-grid').exists()).toBe(true)
    expect(wrapper.find('.support-grid').exists()).toBe(true)
  })

  it('contains interactive elements', () => {
    // Check for buttons
    const buttons = wrapper.findAll('.btn')
    expect(buttons.length).toBeGreaterThan(0)
    
    // Check for links
    const links = wrapper.findAll('a')
    expect(links.length).toBeGreaterThan(0)
  })

  it('renders without JavaScript errors', () => {
    expect(wrapper.vm).toBeTruthy()
    expect(wrapper.html()).toBeTruthy()
  })

  it('follows CAAT branding guidelines', () => {
    const html = wrapper.html()
    
    // Check for CAAT-related content
    expect(html).toContain('Member')
    expect(html).toContain('pension')
    
    // Check for proper CSS classes
    expect(wrapper.find('.hero').exists()).toBe(true)
    expect(wrapper.find('.btn-primary').exists()).toBe(true)
    expect(wrapper.find('.btn-secondary').exists()).toBe(true)
  })
})
