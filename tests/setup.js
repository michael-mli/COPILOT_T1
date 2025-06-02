import { config } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'

// Mock router for testing
const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: { template: '<div>Home</div>' } },
    { path: '/about', component: { template: '<div>About</div>' } },
    { path: '/services', component: { template: '<div>Services</div>' } },
    { path: '/members', component: { template: '<div>Members</div>' } },
    { path: '/employers', component: { template: '<div>Employers</div>' } },
    { path: '/news', component: { template: '<div>News</div>' } },
    { path: '/contact', component: { template: '<div>Contact</div>' } },
  ]
})

// Global config for tests
config.global.plugins = [router]
