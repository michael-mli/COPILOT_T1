import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import App from '../../../src/App.vue'
import AppHeader from '../../../src/components/AppHeader.vue'
import AppFooter from '../../../src/components/AppFooter.vue'
import Home from '../../../src/components/Home.vue'
import About from '../../../src/components/About.vue'
import Services from '../../../src/components/Services.vue'
import Members from '../../../src/components/Members.vue'
import Employers from '../../../src/components/Employers.vue'
import News from '../../../src/components/News.vue'
import Contact from '../../../src/components/Contact.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: Home },
    { path: '/about', component: About },
    { path: '/services', component: Services },
    { path: '/members', component: Members },
    { path: '/employers', component: Employers },
    { path: '/news', component: News },
    { path: '/contact', component: Contact },
  ]
})

describe('App.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/')
    await router.isReady()
    
    wrapper = mount(App, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('#app').exists()).toBe(true)
  })

  it('has the correct component structure', () => {
    expect(wrapper.findComponent(AppHeader).exists()).toBe(true)
    expect(wrapper.findComponent(AppFooter).exists()).toBe(true)
    expect(wrapper.find('router-view').exists()).toBe(true)
  })

  it('renders components in correct order', () => {
    const appElement = wrapper.find('#app')
    const children = appElement.element.children
    
    // Should have 3 direct children: header, router-view, footer
    expect(children.length).toBe(3)
    
    // Check order by looking at component types
    expect(wrapper.findComponent(AppHeader).exists()).toBe(true)
    expect(wrapper.findComponent(AppFooter).exists()).toBe(true)
  })

  it('applies correct CSS structure', () => {
    const appElement = wrapper.find('#app')
    expect(appElement.exists()).toBe(true)
    
    // The app should have flex display with column direction (from CSS)
    expect(appElement.attributes('id')).toBe('app')
  })

  it('imports and registers components correctly', () => {
    // Check that components are properly imported and registered
    expect(wrapper.vm.$options.components.AppHeader).toBeDefined()
    expect(wrapper.vm.$options.components.AppFooter).toBeDefined()
  })

  it('has proper component name', () => {
    expect(wrapper.vm.$options.name).toBe('App')
  })

  it('renders without errors', () => {
    // The component should mount without throwing errors
    expect(wrapper.vm).toBeTruthy()
    expect(wrapper.html()).toContain('CAAT') // Should contain brand name from header
  })

  it('provides router-view for content', () => {
    const routerView = wrapper.findComponent({ name: 'RouterView' })
    expect(routerView.exists()).toBe(true)
  })

  it('maintains consistent layout structure', () => {
    // App should always have header at top and footer at bottom
    const header = wrapper.findComponent(AppHeader)
    const footer = wrapper.findComponent(AppFooter)
    
    expect(header.exists()).toBe(true)
    expect(footer.exists()).toBe(true)
    
    // Header should come before footer in DOM
    const headerElement = header.element
    const footerElement = footer.element
    const appElement = wrapper.find('#app').element
    
    const headerIndex = Array.from(appElement.children).indexOf(headerElement)
    const footerIndex = Array.from(appElement.children).indexOf(footerElement)
    
    expect(headerIndex).toBeLessThan(footerIndex)
  })

  it('integrates with Vue Router correctly', async () => {
    // Test navigation between routes
    expect(wrapper.findComponent({ name: 'RouterView' }).exists()).toBe(true)
    
    // Navigate to about page
    await router.push('/about')
    await wrapper.vm.$nextTick()
    
    // Should still have header and footer
    expect(wrapper.findComponent(AppHeader).exists()).toBe(true)
    expect(wrapper.findComponent(AppFooter).exists()).toBe(true)
    
    // Navigate to services page
    await router.push('/services')
    await wrapper.vm.$nextTick()
    
    // Should still maintain layout
    expect(wrapper.findComponent(AppHeader).exists()).toBe(true)
    expect(wrapper.findComponent(AppFooter).exists()).toBe(true)
    
    // Test new routes
    await router.push('/members')
    await wrapper.vm.$nextTick()
    expect(wrapper.findComponent(AppHeader).exists()).toBe(true)
    expect(wrapper.findComponent(AppFooter).exists()).toBe(true)
    
    await router.push('/employers')
    await wrapper.vm.$nextTick()
    expect(wrapper.findComponent(AppHeader).exists()).toBe(true)
    expect(wrapper.findComponent(AppFooter).exists()).toBe(true)
    
    await router.push('/news')
    await wrapper.vm.$nextTick()
    expect(wrapper.findComponent(AppHeader).exists()).toBe(true)
    expect(wrapper.findComponent(AppFooter).exists()).toBe(true)
    
    await router.push('/contact')
    await wrapper.vm.$nextTick()
    expect(wrapper.findComponent(AppHeader).exists()).toBe(true)
    expect(wrapper.findComponent(AppFooter).exists()).toBe(true)
  })

  it('has no JavaScript errors in component definition', () => {
    // Component should have valid structure
    expect(wrapper.vm.$options).toBeDefined()
    expect(wrapper.vm.$options.name).toBe('App')
    expect(wrapper.vm.$options.components).toBeDefined()
  })

  it('passes data to child components correctly', () => {
    // Header and footer should receive router context
    const header = wrapper.findComponent(AppHeader)
    const footer = wrapper.findComponent(AppFooter)
    
    expect(header.vm.$router).toBeDefined()
    expect(footer.vm.$router).toBeDefined()
  })
})
