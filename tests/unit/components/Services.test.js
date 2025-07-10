import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import Services from '../../../src/components/Services.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/services', component: Services },
    { path: '/members', component: { template: '<div>Members</div>' } },
    { path: '/employers', component: { template: '<div>Employers</div>' } },
    { path: '/retirees', component: { template: '<div>Retirees</div>' } },
    { path: '/contact', component: { template: '<div>Contact</div>' } },
  ]
})

describe('Services.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/services')
    await router.isReady()
    
    wrapper = mount(Services, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.services').exists()).toBe(true)
  })

  it('displays the hero section', () => {
    const heroSection = wrapper.find('.hero')
    expect(heroSection.exists()).toBe(true)
    
    const heroTitle = wrapper.find('.hero-content h1')
    expect(heroTitle.text()).toBe('Our Services')
    
    const heroSubtitle = wrapper.find('.hero-subtitle')
    expect(heroSubtitle.text()).toBe('Comprehensive pension solutions designed to secure your financial future')
  })

  it('displays services overview section', () => {
    const overviewSection = wrapper.find('.services-overview')
    expect(overviewSection.exists()).toBe(true)
    
    const overviewTitle = wrapper.find('.overview-content h2')
    expect(overviewTitle.text()).toBe('Complete Pension Solutions')
    
    const overviewText = wrapper.find('.overview-content p')
    expect(overviewText.text()).toContain('end-to-end pension services')
  })

  it('displays main services grid with all service cards', () => {
    const mainServicesSection = wrapper.find('.main-services')
    expect(mainServicesSection.exists()).toBe(true)
    
    const serviceCards = wrapper.findAll('.service-card')
    expect(serviceCards.length).toBe(6)
    
    const expectedServices = [
      'Pension Administration',
      'Investment Management',
      'Member Services',
      'Employer Services',
      'Financial Planning',
      'Digital Solutions'
    ]
    
    serviceCards.forEach((card, index) => {
      expect(card.find('h3').text()).toBe(expectedServices[index])
      expect(card.find('.service-icon').exists()).toBe(true)
      expect(card.find('p').exists()).toBe(true)
      expect(card.find('.service-features').exists()).toBe(true)
      expect(card.find('.service-link').exists()).toBe(true)
    })
  })

  it('highlights featured services correctly', () => {
    const featuredCards = wrapper.findAll('.service-card.featured')
    expect(featuredCards.length).toBe(2)
    
    // First two cards should be featured
    expect(featuredCards[0].find('h3').text()).toBe('Pension Administration')
    expect(featuredCards[1].find('h3').text()).toBe('Investment Management')
  })

  it('displays service categories section', () => {
    const categoriesSection = wrapper.find('.service-categories')
    expect(categoriesSection.exists()).toBe(true)
    
    const categoryCards = wrapper.findAll('.category-card')
    expect(categoryCards.length).toBe(3)
    
    const expectedCategories = ['For Members', 'For Employers', 'For Retirees']
    categoryCards.forEach((card, index) => {
      expect(card.find('h3').text()).toBe(expectedCategories[index])
      expect(card.find('.category-icon').exists()).toBe(true)
      expect(card.find('ul').exists()).toBe(true)
      expect(card.find('.btn').exists()).toBe(true)
    })
  })

  it('has correct router links in category cards', () => {
    const categoriesSection = wrapper.find('.service-categories')
    const categoryButtons = categoriesSection.findAllComponents({ name: 'router-link' })
    expect(categoryButtons.length).toBe(3)
    
    expect(categoryButtons[0].props('to')).toBe('/members')
    expect(categoryButtons[1].props('to')).toBe('/employers')
    expect(categoryButtons[2].props('to')).toBe('/retirees')
  })

  it('displays process flow section', () => {
    const processSection = wrapper.find('.process-flow')
    expect(processSection.exists()).toBe(true)
    
    const processTitle = wrapper.find('.process-flow h2')
    expect(processTitle.text()).toBe('Our Service Process')
    
    const processSteps = wrapper.findAll('.step')
    expect(processSteps.length).toBe(4)
    
    const expectedSteps = ['Consultation', 'Planning', 'Implementation', 'Monitoring']
    processSteps.forEach((step, index) => {
      expect(step.find('h3').text()).toBe(expectedSteps[index])
      expect(step.find('.step-number').text()).toBe((index + 1).toString())
      expect(step.find('p').exists()).toBe(true)
    })
  })

  it('displays service standards section', () => {
    const standardsSection = wrapper.find('.service-standards')
    expect(standardsSection.exists()).toBe(true)
    
    const standardsTitle = wrapper.find('.service-standards h2')
    expect(standardsTitle.text()).toBe('Our Service Standards')
    
    const standardCards = wrapper.findAll('.standard-card')
    expect(standardCards.length).toBe(4)
    
    const expectedStandards = ['Fast Response', 'Accuracy', 'Security', 'Support']
    standardCards.forEach((card, index) => {
      expect(card.find('h3').text()).toBe(expectedStandards[index])
      expect(card.find('.standard-icon').exists()).toBe(true)
      expect(card.find('p').exists()).toBe(true)
    })
  })

  it('displays contact CTA section', () => {
    const ctaSection = wrapper.find('.contact-cta')
    expect(ctaSection.exists()).toBe(true)
    
    const ctaTitle = wrapper.find('.cta-content h2')
    expect(ctaTitle.text()).toBe('Ready to Learn More?')
    
    const ctaButtons = wrapper.findAll('.cta-actions .btn')
    expect(ctaButtons.length).toBe(2)
    
    expect(ctaButtons[0].text()).toBe('Contact Us')
    const contactButton = ctaSection.findComponent({ name: 'router-link' })
    expect(contactButton.props('to')).toBe('/contact')
    expect(ctaButtons[1].text()).toBe('Call 1-800-CAA-TPEN')
    expect(ctaButtons[1].attributes('href')).toBe('tel:1-800-CAA-TPEN')
  })

  it('has all required sections in correct order', () => {
    const sections = wrapper.findAll('section')
    expect(sections.length).toBe(7)
    
    const sectionClasses = [
      'hero',
      'services-overview',
      'main-services',
      'service-categories',
      'process-flow',
      'service-standards',
      'contact-cta'
    ]
    
    sectionClasses.forEach((className, index) => {
      expect(sections[index].classes()).toContain(className)
    })
  })

  it('contains proper grid layouts', () => {
    expect(wrapper.find('.services-grid').exists()).toBe(true)
    expect(wrapper.find('.categories-grid').exists()).toBe(true)
    expect(wrapper.find('.process-steps').exists()).toBe(true)
    expect(wrapper.find('.standards-grid').exists()).toBe(true)
  })

  it('displays service features lists correctly', () => {
    const serviceFeatures = wrapper.findAll('.service-features')
    expect(serviceFeatures.length).toBe(6)
    
    serviceFeatures.forEach(featureList => {
      const listItems = featureList.findAll('li')
      expect(listItems.length).toBeGreaterThan(0)
    })
  })

  it('has process arrows between steps', () => {
    const stepArrows = wrapper.findAll('.step-arrow')
    expect(stepArrows.length).toBe(3) // 4 steps = 3 arrows between them
    
    stepArrows.forEach(arrow => {
      expect(arrow.text()).toBe('→')
    })
  })

  it('applies correct background colors to sections', () => {
    const grayBackgroundSections = [
      '.main-services',
      '.service-standards'
    ]
    
    const coloredBackgroundSections = [
      '.process-flow',
      '.contact-cta'
    ]
    
    grayBackgroundSections.forEach(sectionClass => {
      expect(wrapper.find(sectionClass).exists()).toBe(true)
    })
    
    coloredBackgroundSections.forEach(sectionClass => {
      expect(wrapper.find(sectionClass).exists()).toBe(true)
    })
  })

  it('has proper semantic HTML structure', () => {
    expect(wrapper.find('main').exists()).toBe(true)
    expect(wrapper.findAll('section').length).toBe(7)
    expect(wrapper.findAll('h2').length).toBe(5)
    expect(wrapper.findAll('h3').length).toBeGreaterThan(0)
  })

  it('contains interactive elements with proper classes', () => {
    const serviceCards = wrapper.findAll('.service-card')
    const categoryCards = wrapper.findAll('.category-card')
    const standardCards = wrapper.findAll('.standard-card')
    
    serviceCards.forEach(card => {
      expect(card.classes()).toContain('service-card')
    })
    
    categoryCards.forEach(card => {
      expect(card.classes()).toContain('category-card')
    })
    
    standardCards.forEach(card => {
      expect(card.classes()).toContain('standard-card')
    })
  })
})
