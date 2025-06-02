import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import Members from '../../../src/components/Members.vue'

describe('Members.vue - Simple Tests', () => {
  it('can be imported and mounted', () => {
    const wrapper = mount(Members)
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.vm.$options.name).toBe('Members')
  })

  it('has main container element', () => {
    const wrapper = mount(Members)
    expect(wrapper.find('.members').exists()).toBe(true)
  })

  it('contains expected sections', () => {
    const wrapper = mount(Members)
    const html = wrapper.html()
    
    expect(html).toContain('Member Resources')
    expect(html).toContain('Portal')
    expect(html).toContain('Planning')
    expect(html).toContain('Resources')
  })
})
