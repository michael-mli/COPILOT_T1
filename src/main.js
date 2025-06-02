import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import './style.css'
import App from './App.vue'
import Home from './components/Home.vue'
import About from './components/About.vue'
import Services from './components/Services.vue'
import Members from './components/Members.vue'
import Employers from './components/Employers.vue'
import News from './components/News.vue'
import Contact from './components/Contact.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/about', component: About },
  { path: '/services', component: Services },
  { path: '/members', component: Members },
  { path: '/employers', component: Employers },
  { path: '/news', component: News },
  { path: '/contact', component: Contact },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

createApp(App).use(router).mount('#app')
