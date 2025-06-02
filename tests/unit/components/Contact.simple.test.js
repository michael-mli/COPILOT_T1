import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import Contact from '../../../src/components/Contact.vue'

describe('Contact.vue - Simple Tests', () => {
  it('can be imported and mounted', () => {
    const wrapper = mount(Contact)
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.vm.$options.name).toBe('Contact')
  })

  it('has main container element', () => {
    const wrapper = mount(Contact)
    expect(wrapper.find('.contact').exists()).toBe(true)
  })

  it('contains expected sections', () => {
    const wrapper = mount(Contact)
    const html = wrapper.html()
    
    expect(html).toContain('Contact Us')
    expect(html).toContain('Phone')
    expect(html).toContain('Email')
    expect(html).toContain('Message')
  })
})
