import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import AppHeader from '../../../src/components/AppHeader.vue'

describe('AppHeader.vue', () => {
  it('should mount without crashing', () => {
    const wrapper = mount(AppHeader, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.exists()).toBe(true)
  })

  it('should contain header element', () => {
    const wrapper = mount(AppHeader, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.find('header').exists()).toBe(true)
  })

  it('should display CAAT brand name', () => {
    const wrapper = mount(AppHeader, {
      global: {
        stubs: {
          'router-link': {
            template: '<a><slot/></a>'
          }
        }
      }
    })
    const brandElement = wrapper.find('.navbar-brand')
    expect(brandElement.exists()).toBe(true)
    expect(brandElement.html()).toContain('CAAT')
  })

  it('should have navbar element', () => {
    const wrapper = mount(AppHeader, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.find('nav').exists()).toBe(true)
  })

  it('should have navigation menu', () => {
    const wrapper = mount(AppHeader, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.find('.navbar-menu').exists()).toBe(true)
  })
})
