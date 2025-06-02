<template>
  <header class="header">
    <div class="container">
      <nav class="navbar">
        <div class="navbar-brand">
          <router-link to="/" class="logo">
            <h2>CAAT</h2>
            <span>Pension Plan</span>
          </router-link>
        </div>
        
        <div class="navbar-menu" :class="{ 'active': isMenuOpen }">
          <ul class="navbar-nav">
            <li><router-link to="/" @click="closeMenu">Home</router-link></li>
            <li><router-link to="/about" @click="closeMenu">About</router-link></li>
            <li><router-link to="/services" @click="closeMenu">Services</router-link></li>
            <li><router-link to="/members" @click="closeMenu">Members</router-link></li>
            <li><router-link to="/employers" @click="closeMenu">Employers</router-link></li>
            <li><router-link to="/news" @click="closeMenu">News</router-link></li>
            <li><router-link to="/contact" @click="closeMenu">Contact</router-link></li>
          </ul>
        </div>
        
        <button class="mobile-menu-toggle" @click="toggleMenu">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </nav>
    </div>
  </header>
</template>

<script>
export default {
  name: 'AppHeader',
  data() {
    return {
      isMenuOpen: false
    }
  },
  methods: {
    toggleMenu() {
      this.isMenuOpen = !this.isMenuOpen
    },
    closeMenu() {
      this.isMenuOpen = false
    }
  }
}
</script>

<style scoped>
.header {
  background-color: var(--white);
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 0;
}

.navbar-brand .logo {
  text-decoration: none;
  display: flex;
  align-items: center;
  gap: 10px;
}

.navbar-brand h2 {
  color: var(--primary-blue);
  font-size: 2em;
  font-weight: 700;
  margin: 0;
}

.navbar-brand span {
  color: var(--gray-dark);
  font-size: 0.9em;
  font-weight: 500;
}

.navbar-nav {
  display: flex;
  list-style: none;
  gap: 2rem;
  margin: 0;
  padding: 0;
}

.navbar-nav a {
  text-decoration: none;
  color: var(--text-dark);
  font-weight: 500;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  transition: all 0.3s ease;
}

.navbar-nav a:hover,
.navbar-nav a.router-link-active {
  background-color: var(--light-blue);
  color: var(--primary-blue);
}

.mobile-menu-toggle {
  display: none;
  flex-direction: column;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
  width: 24px;
  height: 24px;
}

.mobile-menu-toggle span {
  width: 100%;
  height: 3px;
  background-color: var(--primary-blue);
  margin: 2px 0;
  transition: 0.3s;
}

@media (max-width: 768px) {
  .mobile-menu-toggle {
    display: flex;
  }
  
  .navbar-menu {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background-color: var(--white);
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    transform: translateY(-100%);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
  }
  
  .navbar-menu.active {
    transform: translateY(0);
    opacity: 1;
    visibility: visible;
  }
  
  .navbar-nav {
    flex-direction: column;
    gap: 0;
    padding: 1rem;
  }
  
  .navbar-nav a {
    padding: 1rem;
    border-bottom: 1px solid var(--gray-light);
  }
  
  .navbar-nav a:last-child {
    border-bottom: none;
  }
}
</style>
