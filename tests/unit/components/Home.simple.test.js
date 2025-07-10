import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import Home from '../../../src/components/Home.vue'

describe('Home.vue', () => {
  it('should mount without crashing', () => {
    const wrapper = mount(Home, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.exists()).toBe(true)
  })

  it('should contain hero section', () => {
    const wrapper = mount(Home, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.find('.hero').exists()).toBe(true)
  })

  it('should display welcome message', () => {
    const wrapper = mount(Home, {
      global: {
        stubs: ['router-link']
      }
    })
    expect(wrapper.text()).toContain('Our purpose is to improve retirement security')
  })
})
