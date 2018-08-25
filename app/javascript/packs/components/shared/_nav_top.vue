<template>
  <container>
    <section class="hero is-info">
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <router-link class="navbar-item" :to="{ name: 'root_path'}">
          <img src="https://diu1mzq1btmsf.cloudfront.net/assets/kodius-logo-bijeli-ace02e27001a70c4f25b3cdf82c4d757441ac92894a35a0c61054c71511ab1ac.png" 
               alt="Kodius" 
               width="168" height="54"
               style="background:#343434">
       </router-link>

        <div id="navbarExampleTransparentExample" class="navbar-menu">
          <div class="navbar-start">
            <router-link :class="activeOn(['root_path'])" :to="{ name: 'root_path'}">Leaderboard</router-link>
            <router-link :class="activeOn(['dashboard_path'])" :to="{ name: 'dashboard_path'}">Dashboard</router-link>
            <router-link :class="activeOn(['log_path'])" :to="{ name: 'log_path'}">Log</router-link>
          </div>
        </div>

        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>
    </nav>
      <div class="hero-body">
        <div class="tile is-ancestor">
          <div class="tile is-child is-6">
            <h1 class="title">
              Time to Six Pack 
            </h1>
            <h2 class="subtitle">
              Getting it for real
            </h2> 
          </div>
          <div class="tile is-child is-3 notification is-info">
            Fat Lost
          </div>
          <div class="tile is-child is-3 notification is-info">
            Streak
          </div>
        </div>
        <div class="tile is-ancestor">
          <div class="tile is-child is-6">
          </div>
          <div class="tile is-child is-3">
            <span v-if="loaded">
              <a class="button is-danger is-large is-rounded">{{plan.fatLost}}kg</a>
            </span>
          </div>
          <div class="tile is-child is-3">
            <span v-if="loaded">
              <a class="button is-success is-large is-rounded">{{plan.daysStreak}} days</a>
            </span>
          </div>
        </div>
      </div>
    </section>
  </container>


</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      plan: null,
      loaded: false
    }
  },
  mounted () {
    axios
      .get('my-plan')
      .then(response => {
        this.plan = response.data.plan
        this.loaded = true
      })
  },
  methods: {
    activeOn: function(paths) {
      if(paths.includes(this.$route.name)) {
        return 'is-active navbar-item';
      } else {
        return 'navbar-item';
      }
    }
  }
}
</script>
