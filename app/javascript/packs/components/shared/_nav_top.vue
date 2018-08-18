<template>
  <div>
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <a class="navbar-item" href="https://tt6p.kodius.io">
          <img src="https://diu1mzq1btmsf.cloudfront.net/assets/kodius-logo-bijeli-ace02e27001a70c4f25b3cdf82c4d757441ac92894a35a0c61054c71511ab1ac.png" 
               alt="Kodius" 
               width="168" height="54"
               style="background:#343434">
        </a>

        <div id="navbarExampleTransparentExample" class="navbar-menu">
          <div class="navbar-start">
            <router-link class="navbar-item" :to="{ name: 'dashboard_path'}">Dashboard</router-link>
            <router-link class="navbar-item" :to="{ name: 'log_path'}">Log</router-link>
          </div>
        </div>

        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>
    </nav>
    <section class="hero">
      <div class="hero-body">
        <div class="container">
          <h1 class="title">
            Time to sixpack 
          </h1>
          <h2 class="subtitle">
            Get sixpack by keeping track
          </h2>
        </div>
      </div>
    </section>

  </div>

</template>

<script>
export default {

  data: function() {
    return {
      locale: window.I18n.locale,
      availableLocales: window.I18n.availableLocales
    }
  },

  methods: {
    activeOn: function(paths) {
      if(paths.includes(this.$route.name)) {
        return 'active';
      } else {
        return '';
      }
    }
  },

  watch: {
    locale: function(locale) {
      let redirectTo = `/${locale}${this.$route.path}`;
      if(locale == this.availableLocales[0]) {
        redirectTo = `${this.$route.path}`
      }

      window.location.href = redirectTo;
    }
  }
}
</script>
