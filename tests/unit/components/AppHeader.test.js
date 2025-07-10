import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import AppHeader from '../../../src/components/AppHeader.vue'

// Mock components for router
const Home = { template: '<div>Home</div>' }
const About = { template: '<div>About</div>' }
const Services = { template: '<div>Services</div>' }

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: Home },
    { path: '/about', component: About },
    { path: '/services', component: Services },
    { path: '/members', component: { template: '<div>Members</div>' } },
    { path: '/employers', component: { template: '<div>Employers</div>' } },
    { path: '/news', component: { template: '<div>News</div>' } },
    { path: '/contact', component: { template: '<div>Contact</div>' } },
  ]
})

describe('AppHeader.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/')
    await router.isReady()
    
    wrapper = mount(AppHeader, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.header').exists()).toBe(true)
    expect(wrapper.find('.navbar').exists()).toBe(true)
  })

  it('displays the CAAT logo and brand name', () => {
    const logo = wrapper.find('.navbar-brand .logo')
    expect(logo.exists()).toBe(true)
    
    const brandTitle = wrapper.find('.navbar-brand h2')
    expect(brandTitle.text()).toBe('CAAT')
    
    const brandSubtitle = wrapper.find('.navbar-brand span')
    expect(brandSubtitle.text()).toBe('Pension Plan')
  })

  it('renders all navigation links', () => {
    const navLinks = wrapper.findAll('.navbar-nav a')
    expect(navLinks.length).toBe(7)
    
    const expectedLinks = ['Home', 'About', 'Services', 'Members', 'Employers', 'News', 'Contact']
    expectedLinks.forEach((linkText, index) => {
      expect(navLinks[index].text()).toBe(linkText)
    })
  })

  it('has correct router-link paths', () => {
    const navLinks = wrapper.find('.navbar-nav').findAllComponents({ name: 'router-link' })
    
    expect(navLinks[0].props('to')).toBe('/')
    expect(navLinks[1].props('to')).toBe('/about')
    expect(navLinks[2].props('to')).toBe('/services')
    expect(navLinks[3].props('to')).toBe('/members')
    expect(navLinks[4].props('to')).toBe('/employers')
    expect(navLinks[5].props('to')).toBe('/news')
    expect(navLinks[6].props('to')).toBe('/contact')
  })

  it('shows mobile menu toggle button', () => {
    const mobileToggle = wrapper.find('.mobile-menu-toggle')
    expect(mobileToggle.exists()).toBe(true)
    
    const spans = mobileToggle.findAll('span')
    expect(spans.length).toBe(3) // Hamburger menu has 3 lines
  })

  it('toggles mobile menu when button is clicked', async () => {
    const mobileToggle = wrapper.find('.mobile-menu-toggle')
    const navbarMenu = wrapper.find('.navbar-menu')
    
    // Initially menu should not be active
    expect(navbarMenu.classes()).not.toContain('active')
    expect(wrapper.vm.isMenuOpen).toBe(false)
    
    // Click toggle button
    await mobileToggle.trigger('click')
    
    // Menu should now be active
    expect(wrapper.vm.isMenuOpen).toBe(true)
    expect(navbarMenu.classes()).toContain('active')
    
    // Click again to close
    await mobileToggle.trigger('click')
    expect(wrapper.vm.isMenuOpen).toBe(false)
  })

  it('closes mobile menu when navigation link is clicked', async () => {
    const mobileToggle = wrapper.find('.mobile-menu-toggle')
    const navLink = wrapper.findAll('.navbar-nav a')[1] // About link
    
    // Open mobile menu
    await mobileToggle.trigger('click')
    expect(wrapper.vm.isMenuOpen).toBe(true)
    
    // Click navigation link
    await navLink.trigger('click')
    expect(wrapper.vm.isMenuOpen).toBe(false)
  })

  it('has proper component data structure', () => {
    expect(wrapper.vm.isMenuOpen).toBeDefined()
    expect(typeof wrapper.vm.isMenuOpen).toBe('boolean')
  })

  it('has proper component methods', () => {
    expect(typeof wrapper.vm.toggleMenu).toBe('function')
    expect(typeof wrapper.vm.closeMenu).toBe('function')
  })

  it('toggleMenu method works correctly', () => {
    expect(wrapper.vm.isMenuOpen).toBe(false)
    
    wrapper.vm.toggleMenu()
    expect(wrapper.vm.isMenuOpen).toBe(true)
    
    wrapper.vm.toggleMenu()
    expect(wrapper.vm.isMenuOpen).toBe(false)
  })

  it('closeMenu method works correctly', () => {
    wrapper.vm.isMenuOpen = true
    wrapper.vm.closeMenu()
    expect(wrapper.vm.isMenuOpen).toBe(false)
  })

  it('applies correct CSS classes', () => {
    expect(wrapper.find('.header').exists()).toBe(true)
    expect(wrapper.find('.navbar').exists()).toBe(true)
    expect(wrapper.find('.navbar-brand').exists()).toBe(true)
    expect(wrapper.find('.navbar-menu').exists()).toBe(true)
    expect(wrapper.find('.navbar-nav').exists()).toBe(true)
    expect(wrapper.find('.mobile-menu-toggle').exists()).toBe(true)
  })
})
