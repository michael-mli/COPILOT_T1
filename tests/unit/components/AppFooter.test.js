import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import AppFooter from '../../../src/components/AppFooter.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: { template: '<div>Home</div>' } },
    { path: '/about', component: { template: '<div>About</div>' } },
    { path: '/services', component: { template: '<div>Services</div>' } },
    { path: '/news', component: { template: '<div>News</div>' } },
    { path: '/careers', component: { template: '<div>Careers</div>' } },
  ]
})

describe('AppFooter.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/')
    await router.isReady()
    
    wrapper = mount(AppFooter, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.footer').exists()).toBe(true)
  })

  it('displays the main footer content', () => {
    const footerContent = wrapper.find('.footer-content')
    expect(footerContent.exists()).toBe(true)
    
    const footerSections = wrapper.findAll('.footer-section')
    expect(footerSections.length).toBe(5)
  })

  it('displays company information section', () => {
    const companySections = wrapper.findAll('.footer-section')
    const companySection = companySections[0]
    
    expect(companySection.find('h3').text()).toBe('CAAT Pension Plan')
    expect(companySection.find('p').text()).toContain('Improving retirement security for Canadians')
    
    const socialLinks = companySection.find('.social-links')
    expect(socialLinks.exists()).toBe(true)
    
    const socialLinkItems = socialLinks.findAll('a')
    expect(socialLinkItems.length).toBe(3)
  })

  it('displays quick links section', () => {
    const sections = wrapper.findAll('.footer-section')
    const quickLinksSection = sections[1]
    
    expect(quickLinksSection.find('h4').text()).toBe('Quick Links')
    
    const quickLinks = quickLinksSection.findAll('ul li')
    expect(quickLinks.length).toBe(4)
    
    const expectedLinks = ['About Us', 'Services', 'News & Updates', 'Careers']
    quickLinks.forEach((link, index) => {
      expect(link.find('a').text()).toBe(expectedLinks[index])
    })
  })

  it('has correct router links in quick links', () => {
    const sections = wrapper.findAll('.footer-section')
    const quickLinksSection = sections[1]
    const routerLinks = quickLinksSection.findAll('router-link')
    
    expect(routerLinks[0].attributes('to')).toBe('/about')
    expect(routerLinks[1].attributes('to')).toBe('/services')
    expect(routerLinks[2].attributes('to')).toBe('/news')
    expect(routerLinks[3].attributes('to')).toBe('/careers')
  })

  it('displays for members section', () => {
    const sections = wrapper.findAll('.footer-section')
    const membersSection = sections[2]
    
    expect(membersSection.find('h4').text()).toBe('For Members')
    
    const memberLinks = membersSection.findAll('ul li')
    expect(memberLinks.length).toBe(4)
    
    const expectedLinks = ['Member Portal', 'Forms & Documents', 'Retirement Calculator', 'FAQs']
    memberLinks.forEach((link, index) => {
      expect(link.find('a').text()).toBe(expectedLinks[index])
    })
  })

  it('displays for employers section', () => {
    const sections = wrapper.findAll('.footer-section')
    const employersSection = sections[3]
    
    expect(employersSection.find('h4').text()).toBe('For Employers')
    
    const employerLinks = employersSection.findAll('ul li')
    expect(employerLinks.length).toBe(4)
    
    const expectedLinks = ['Employer Portal', 'Contribution Guidelines', 'Resources', 'Contact Support']
    employerLinks.forEach((link, index) => {
      expect(link.find('a').text()).toBe(expectedLinks[index])
    })
  })

  it('displays contact information section', () => {
    const sections = wrapper.findAll('.footer-section')
    const contactSection = sections[4]
    
    expect(contactSection.find('h4').text()).toBe('Contact Information')
    
    const contactInfo = contactSection.find('.contact-info')
    expect(contactInfo.exists()).toBe(true)
    
    const contactDetails = contactInfo.findAll('p')
    expect(contactDetails.length).toBe(3)
    
    expect(contactDetails[0].text()).toContain('1-800-CAA-TPEN')
    expect(contactDetails[1].text()).toContain('info@caatpension.ca')
    expect(contactDetails[2].text()).toContain('Toronto, Ontario, Canada')
  })

  it('displays footer bottom section', () => {
    const footerBottom = wrapper.find('.footer-bottom')
    expect(footerBottom.exists()).toBe(true)
    
    const footerBottomContent = wrapper.find('.footer-bottom-content')
    expect(footerBottomContent.exists()).toBe(true)
    
    const copyrightText = footerBottomContent.find('p')
    expect(copyrightText.text()).toBe('© 2025 CAAT Pension Plan. All rights reserved.')
  })

  it('displays footer links in bottom section', () => {
    const footerLinks = wrapper.find('.footer-links')
    expect(footerLinks.exists()).toBe(true)
    
    const links = footerLinks.findAll('a')
    expect(links.length).toBe(3)
    
    expect(links[0].text()).toBe('Privacy Policy')
    expect(links[1].text()).toBe('Terms of Service')
    expect(links[2].text()).toBe('Accessibility')
    
    const separators = footerLinks.findAll('span')
    expect(separators.length).toBe(2)
    separators.forEach(separator => {
      expect(separator.text()).toBe('|')
    })
  })

  it('has proper social media link structure', () => {
    const socialLinks = wrapper.find('.social-links')
    const socialLinkItems = socialLinks.findAll('a')
    
    socialLinkItems.forEach(link => {
      expect(link.attributes('aria-label')).toBeDefined()
      expect(link.attributes('href')).toBe('#')
    })
  })

  it('contains all external links as regular anchor tags', () => {
    // Member links should be regular anchors (external)
    const sections = wrapper.findAll('.footer-section')
    const membersSection = sections[2]
    const memberAnchors = membersSection.findAll('a')
    
    memberAnchors.forEach(anchor => {
      expect(anchor.attributes('href')).toBe('#')
    })
    
    // Employer links should be regular anchors (external)
    const employersSection = sections[3]
    const employerAnchors = employersSection.findAll('a')
    
    employerAnchors.forEach(anchor => {
      expect(anchor.attributes('href')).toBe('#')
    })
  })

  it('has proper grid layout structure', () => {
    const footerContent = wrapper.find('.footer-content')
    expect(footerContent.exists()).toBe(true)
    
    const footerSections = wrapper.findAll('.footer-section')
    expect(footerSections.length).toBe(5)
  })

  it('applies correct CSS classes', () => {
    expect(wrapper.find('.footer').exists()).toBe(true)
    expect(wrapper.find('.container').exists()).toBe(true)
    expect(wrapper.find('.footer-content').exists()).toBe(true)
    expect(wrapper.find('.footer-bottom').exists()).toBe(true)
    expect(wrapper.find('.footer-bottom-content').exists()).toBe(true)
    expect(wrapper.find('.footer-links').exists()).toBe(true)
    expect(wrapper.find('.social-links').exists()).toBe(true)
    expect(wrapper.find('.contact-info').exists()).toBe(true)
  })

  it('has proper semantic HTML structure', () => {
    expect(wrapper.find('footer').exists()).toBe(true)
    expect(wrapper.findAll('h3').length).toBe(1) // Company name
    expect(wrapper.findAll('h4').length).toBe(4) // Section headers
    expect(wrapper.findAll('ul').length).toBe(4) // Link lists
  })

  it('contains proper contact information formatting', () => {
    const contactInfo = wrapper.find('.contact-info')
    const contactParagraphs = contactInfo.findAll('p')
    
    // Check for emoji/icon indicators
    expect(contactParagraphs[0].text()).toMatch(/📞.*1-800-CAA-TPEN/)
    expect(contactParagraphs[1].text()).toMatch(/✉️.*info@caatpension.ca/)
    expect(contactParagraphs[2].text()).toMatch(/📍.*Toronto, Ontario, Canada/)
  })

  it('maintains consistent link structure', () => {
    const allLinks = wrapper.findAll('a')
    
    // All links should have proper structure
    allLinks.forEach(link => {
      expect(link.exists()).toBe(true)
      // Should have either href or to attribute
      const hasHref = link.attributes('href') !== undefined
      const hasTo = link.attributes('to') !== undefined
      expect(hasHref || hasTo).toBe(true)
    })
  })
})
