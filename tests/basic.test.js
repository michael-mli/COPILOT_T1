import { describe, it, expect } from 'vitest'

describe('Basic Test Suite', () => {
  it('should perform basic arithmetic', () => {
    expect(1 + 1).toBe(2)
  })

  it('should check string equality', () => {
    expect('hello').toBe('hello')
  })

  it('should validate array length', () => {
    const arr = [1, 2, 3]
    expect(arr).toHaveLength(3)
  })

  it('should test object properties', () => {
    const obj = { name: 'CAAT', type: 'pension' }
    expect(obj).toHaveProperty('name')
    expect(obj.name).toBe('CAAT')
  })
})
