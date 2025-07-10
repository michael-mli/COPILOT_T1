import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import News from '../../../src/components/News.vue'

describe('News.vue - Simple Tests', () => {
  it('can be imported and mounted', () => {
    const wrapper = mount(News)
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.vm.$options.name).toBe('News')
  })

  it('has main container element', () => {
    const wrapper = mount(News)
    expect(wrapper.find('.news').exists()).toBe(true)
  })

  it('contains expected sections', () => {
    const wrapper = mount(News)
    const html = wrapper.html()
    
    expect(html).toContain('News &amp; Updates')
    expect(html).toContain('Latest')
    expect(html).toContain('Category')
    expect(html).toContain('Newsletter')
  })
})
