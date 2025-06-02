import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import './style.css'
import App from './App.vue'
import Home from './components/Home.vue'
import About from './components/About.vue'
import Services from './components/Services.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/about', component: About },
  { path: '/services', component: Services },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

createApp(App).use(router).mount('#app')
