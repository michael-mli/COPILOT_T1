import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import AppFooter from '../../../src/components/AppFooter.vue'

describe('AppFooter.vue', () => {
  it('should mount without crashing', () => {
    const wrapper = mount(AppFooter, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.exists()).toBe(true)
  })

  it('should contain footer element', () => {
    const wrapper = mount(AppFooter, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.find('footer').exists()).toBe(true)
  })

  it('should display copyright information', () => {
    const wrapper = mount(AppFooter, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.text()).toContain('2025')
  })
})
