<template>
  <layout>
    <div class="container">
      <div class="notification">
        <div v-if="initialLoad">
          <awards :plan="plan" />
          <div v-if="bodyMass.loaded">
            <measurement-chart :height="300" :labels="bodyMass.labels" :datasets1="bodyMass.totalBodyMass" :datasets="bodyMass.leanBodyMass"
              label1="Weight(kg)" label="Lean Body Mass(kg)" stepSize=10></measurement-chart>
          </div>
          <stats :plan="plan" />
          <p>
            <router-link :to="{ name: 'log_path' }" class="button is-large is-primary" role="button">Log data</router-link>
          </p>
        </div>
        <div v-else>
          Loading...
        </div>
        <br />
      </div>
    </div>
    <div v-if="calories.loaded">
      <measurement-chart :height="300" :labels="calories.labels" :datasets="calories.totalCalories" :datasets1="calories.allowedCalories"
        label="Calories(kcal)" stepSize=500 label1="TDEE calories(kcal)"></measurement-chart>
    </div>
    <section class="section" />
    <kodius-footer />
  </layout>
</template>

<script>
  import axios from 'axios';
  import Buefy from 'buefy'
  import Layout from '../shared/layout';
  import MeasurementChart from '../charts/measurement_chart';
  import Vue from 'vue/dist/vue.esm';
  import Awards from '../dashboard/awards'
  import Stats from '../dashboard/stats'
  import Footer from '../shared/footer'
  import MeasurementsTable from '../dashboard/measurements_table'

  Vue.component('measurement-chart', MeasurementChart);
  Vue.component('measurements-table', MeasurementsTable);
  Vue.component('awards', Awards);
  Vue.component('stats', Stats);
  Vue.component('kodius-footer', Footer);
  Vue.use(Buefy)

  export default {
    components: {
      Layout,
      MeasurementChart
    },
    data() {
      return {
        currentDimension: 'week'
      }
    },
    computed: {
      initialLoad() {
        return this.$store.state.currentUser.initialLoad
      },
      plan() {
        return this.$store.state.currentUser.plan
      },
      bodyMass() {
        return this.$store.state.currentUser.bodyMass
      },
      calories() {
        return this.$store.state.currentUser.calories
      }
    },
    mounted() {
      this.$store.dispatch('currentUser/loadPlan')
      this.$store.dispatch('currentUser/loadBodyMass', {
        dimension: this.currentDimension
      })
      this.$store.dispatch('currentUser/loadCalories', {
        dimension: this.currentDimension
      })
    },

  }
</script>
