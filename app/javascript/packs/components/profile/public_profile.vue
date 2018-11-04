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
        </div>
        <div v-else>
          Loading...
        </div>
        <br />
      </div>
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
        return this.$store.state.selectedUser.initialLoad
      },
      plan() {
        return this.$store.state.selectedUser.plan
      },
      bodyMass() {
        return this.$store.state.selectedUser.bodyMass
      },
    },
    beforeMount(){
      this.$store.dispatch('selectedUser/reloadUser')
    },
    mounted() {
      this.$store.dispatch('selectedUser/loadPlan', {
        id: this.$route.params.id
      })
      this.$store.dispatch('selectedUser/loadBodyMass', {
        dimension: this.currentDimension,
        id: this.$route.params.id
      })
    },

  }
</script>
