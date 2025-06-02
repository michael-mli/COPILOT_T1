import { test, expect } from 'vitest'

test('simple math test', () => {
  expect(2 + 2).toBe(4)
})

test('string test', () => {
  expect('hello world').toContain('world')
})

test('array test', () => {
  const items = ['apple', 'banana', 'cherry']
  expect(items).toHaveLength(3)
  expect(items[0]).toBe('apple')
})
