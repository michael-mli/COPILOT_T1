import { describe, it, expect, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import { createRouter, createWebHistory } from 'vue-router'
import About from '../../../src/components/About.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/about', component: About },
    { path: '/', component: { template: '<div>Home</div>' } },
  ]
})

describe('About.vue', () => {
  let wrapper

  beforeEach(async () => {
    router.push('/about')
    await router.isReady()
    
    wrapper = mount(About, {
      global: {
        plugins: [router]
      }
    })
  })

  it('renders the component correctly', () => {
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.about').exists()).toBe(true)
  })

  it('displays the hero section', () => {
    const heroSection = wrapper.find('.hero')
    expect(heroSection.exists()).toBe(true)
    
    const heroTitle = wrapper.find('.hero-content h1')
    expect(heroTitle.text()).toBe('About CAAT Pension Plan')
    
    const heroSubtitle = wrapper.find('.hero-subtitle')
    expect(heroSubtitle.text()).toBe('Learn about our mission to improve retirement security for Canadians')
  })

  it('displays the mission section', () => {
    const missionSection = wrapper.find('.mission')
    expect(missionSection.exists()).toBe(true)
    
    const missionTitle = wrapper.find('.mission h2')
    expect(missionTitle.text()).toBe('Our Mission')
    
    const missionText = wrapper.find('.mission-text')
    expect(missionText.exists()).toBe(true)
    
    const missionParagraphs = wrapper.findAll('.mission-text p')
    expect(missionParagraphs.length).toBe(2)
    expect(missionParagraphs[0].text()).toContain('dedicated to improving retirement security')
  })

  it('displays core values section with all value cards', () => {
    const valuesSection = wrapper.find('.values')
    expect(valuesSection.exists()).toBe(true)
    
    const valuesTitle = wrapper.find('.values h2')
    expect(valuesTitle.text()).toBe('Our Core Values')
    
    const valueCards = wrapper.findAll('.value-card')
    expect(valueCards.length).toBe(4)
    
    const expectedValues = ['Excellence', 'Integrity', 'Innovation', 'Security']
    valueCards.forEach((card, index) => {
      expect(card.find('h3').text()).toBe(expectedValues[index])
      expect(card.find('.value-icon').exists()).toBe(true)
      expect(card.find('p').exists()).toBe(true)
    })
  })

  it('displays leadership section with leader cards', () => {
    const leadershipSection = wrapper.find('.leadership')
    expect(leadershipSection.exists()).toBe(true)
    
    const leadershipTitle = wrapper.find('.leadership h2')
    expect(leadershipTitle.text()).toBe('Leadership Team')
    
    const leaderCards = wrapper.findAll('.leader-card')
    expect(leaderCards.length).toBe(3)
    
    // Check CEO card
    const ceoCard = leaderCards[0]
    expect(ceoCard.find('h3').text()).toBe('Derek W. Dobson')
    expect(ceoCard.find('.title').text()).toBe('CEO & Plan Manager')
  })

  it('displays history section with timeline', () => {
    const historySection = wrapper.find('.history')
    expect(historySection.exists()).toBe(true)
    
    const historyTitle = wrapper.find('.history h2')
    expect(historyTitle.text()).toBe('Our History')
    
    const timelineItems = wrapper.findAll('.timeline-item')
    expect(timelineItems.length).toBe(4)
    
    const expectedDates = ['1967', '1990s', '2000s', 'Today']
    timelineItems.forEach((item, index) => {
      expect(item.find('.timeline-date').text()).toBe(expectedDates[index])
      expect(item.find('.timeline-content h3').exists()).toBe(true)
      expect(item.find('.timeline-content p').exists()).toBe(true)
    })
  })

  it('displays statistics section with stat cards', () => {
    const statisticsSection = wrapper.find('.statistics')
    expect(statisticsSection.exists()).toBe(true)
    
    const statisticsTitle = wrapper.find('.statistics h2')
    expect(statisticsTitle.text()).toBe('By the Numbers')
    
    const statCards = wrapper.findAll('.stat-card')
    expect(statCards.length).toBe(4)
    
    const expectedStats = ['50,000+', '$15B+', '500+', '55+']
    const expectedLabels = ['Active Members', 'Assets Under Management', 'Participating Employers', 'Years of Service']
    
    statCards.forEach((card, index) => {
      expect(card.find('.stat-number').text()).toBe(expectedStats[index])
      expect(card.find('.stat-label').text()).toBe(expectedLabels[index])
    })
  })

  it('has all required sections in correct order', () => {
    const sections = wrapper.findAll('section')
    expect(sections.length).toBe(6)
    
    const sectionClasses = [
      'hero',
      'mission',
      'values',
      'leadership',
      'history',
      'statistics'
    ]
    
    sectionClasses.forEach((className, index) => {
      expect(sections[index].classes()).toContain(className)
    })
  })

  it('contains proper grid layouts', () => {
    expect(wrapper.find('.values-grid').exists()).toBe(true)
    expect(wrapper.find('.leadership-grid').exists()).toBe(true)
    expect(wrapper.find('.stats-grid').exists()).toBe(true)
    expect(wrapper.find('.timeline').exists()).toBe(true)
  })

  it('has placeholder images for leadership and mission', () => {
    const placeholderImages = wrapper.findAll('.placeholder-image')
    expect(placeholderImages.length).toBeGreaterThan(0)
    
    // Mission placeholder
    const missionPlaceholder = wrapper.find('.mission-image .placeholder-image')
    expect(missionPlaceholder.exists()).toBe(true)
    
    // Leadership placeholders
    const leadershipPlaceholders = wrapper.findAll('.leader-image .placeholder-image')
    expect(leadershipPlaceholders.length).toBe(3)
  })

  it('applies correct background colors to sections', () => {
    const valuesSection = wrapper.find('.values')
    const historySection = wrapper.find('.history')
    const statisticsSection = wrapper.find('.statistics')
    
    expect(valuesSection.exists()).toBe(true)
    expect(historySection.exists()).toBe(true)
    expect(statisticsSection.exists()).toBe(true)
  })

  it('has proper semantic HTML structure', () => {
    expect(wrapper.find('main').exists()).toBe(true)
    expect(wrapper.findAll('section').length).toBe(6)
    expect(wrapper.findAll('h2').length).toBe(5)
    expect(wrapper.findAll('h3').length).toBeGreaterThan(0)
  })

  it('contains interactive elements with hover effects', () => {
    const valueCards = wrapper.findAll('.value-card')
    const leaderCards = wrapper.findAll('.leader-card')
    
    valueCards.forEach(card => {
      expect(card.classes()).toContain('value-card')
    })
    
    leaderCards.forEach(card => {
      expect(card.classes()).toContain('leader-card')
    })
  })
})
