<template>
  <section class="hero is-info">
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <router-link class="navbar-item" :to="{ name: 'root_path'}">
          <img src="/logo.png" 
               alt="Kodius">
       </router-link>
      </div>

        <div id="navbarExampleTransparentExample" class="navbar-menu">
          <div class="navbar-start has-text-weight-semibold is-size-6">
            <router-link :class="activeOn(['dashboard_path'])" :to="{ name: 'dashboard_path'}">Home</router-link>
            <router-link :class="activeOn(['log_path'])" :to="{ name: 'log_path'}">Log</router-link>
            <router-link :class="activeOn(['root_path'])" :to="{ name: 'root_path'}">Board</router-link>
          </div>
        </div>

        <div class="navbar-menu">
            <div class="navbar-end">
              <b-dropdown position="is-bottom-left">
                <a class="navbar-item" slot="trigger" v-if="hasPlan">
                  <span style="line-height: 36px; vertical-align: middle; margin-right: 12px">{{ plan.email }}</span>
                  <img :src="plan.avatar" alt="avatar" style="border-radius: 50%; margin-right: 6px">
                  <b-icon icon="menu-down"></b-icon>
                </a>

                <router-link :to="{name: 'my_profile_path'}">
                  <b-dropdown-item>
                    <p>Profile</p>
                  </b-dropdown-item>
                </router-link>
                <b-dropdown-item disabled>
                  <p>Settings</p>
                </b-dropdown-item>
                <b-dropdown-item @click="openEditPlan()">
                  <p>Change plan</p>
                </b-dropdown-item>
                <b-dropdown-item separator />
                <b-dropdown-item @click="logOut()">
                  <p>Logout</p>
                </b-dropdown-item>
              </b-dropdown>
            </div>
          </div>
        </div>

        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
    </nav>
      <div class="hero-body">
        <div class="tile is-ancestor">
          <div class="tile is-child is-6">
            <h1 class="title is-size-4 has-text-weight-semibold">
              Time to Six Pack 
            </h1>
            <h2 class="subtitle">
              Getting it for real
            </h2> 
          </div>
          <div v-if="hasPlan" class="has-text-centered columns">
            <div class="is-one-fitfth column">
              <p>Fat</p>
              <div class="button is-large is-rounded" 
                :class="{'is-danger': (plan.fatLost < 0), 'is-success': (plan.fatLost >= 0)}">
                  {{plan.fatLost > 0 ? `-${plan.fatLost}` : `+${plan.fatLost * (-1)}`}} kg
            </div>
            </div>
            <div class="is-one-fitfth column">
              <p>LBM</p>
              <a class="button is-large is-rounded" 
                :class="{'is-danger': (plan.lbmDiff < 0), 'is-success': (plan.lbmDiff >= 0)}">
                  {{plan.lbmDiff > 0 ? '+' : ''}}{{plan.lbmDiff}} kg
              </a>
            </div>
            <div class="is-one-fitfth column">
              <p>Streak</p>
              <a class="button is-success is-large is-rounded">{{plan.daysStreak}} {{plan.daysStreak | pluralize('day')}}</a>
            </div>
            <div class="is-one-fitfth column">
              <p>Tracking</p>
              <a class="button is-success is-large is-rounded">{{plan.daysTracked}} {{plan.daysTracked | pluralize('day')}}</a>
            </div>
          </div>
        </div>
      </div>
    </section>

</template>

<script>
import axios from 'axios';
import editPlanModal from '../modals/edit_plan_modal'

export default {
  data: function() {
    return {
      hasPlan: false,
      plan: null,
      loaded: false
    }
  },
  mounted () {
    axios
      .get('my-plan')
      .then(response => {
        this.plan = response.data.plan
        this.hasPlan = !response.data.noplan
        this.loaded = this.hasPlan
      })
  },
  methods: {
    activeOn(paths) {
      if(paths.includes(this.$route.name)) {
        return 'is-active navbar-item';
      } else {
        return 'navbar-item';
      }
    },

    openEditPlan() {
      this.$modal.open({
            parent: this,
            component: editPlanModal,
            hasModalCard: true,
            props: {
              originalPlan: this.plan ? this.plan : null
            }
          });
    },

    logOut() {
      delete localStorage.auth_key_secret;
      this.$router.push({ name: 'login_path' });
    }
  }
}
</script>
