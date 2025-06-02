import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import Employers from '../../../src/components/Employers.vue'

describe('Employers.vue - Simple Tests', () => {
  it('can be imported and mounted', () => {
    const wrapper = mount(Employers)
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.vm.$options.name).toBe('Employers')
  })

  it('has main container element', () => {
    const wrapper = mount(Employers)
    expect(wrapper.find('.employers').exists()).toBe(true)
  })

  it('contains expected sections', () => {
    const wrapper = mount(Employers)
    const html = wrapper.html()
    
    expect(html).toContain('Employer Resources')
    expect(html).toContain('Portal')
    expect(html).toContain('Services')
    expect(html).toContain('Implementation')
  })
})
