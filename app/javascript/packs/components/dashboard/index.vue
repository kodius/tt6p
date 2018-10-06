<template>
  <layout>

    <div class="container">

      <div class="notification">
        <div v-if="!isLoading">
           <div class="tile is-ancestor">
              <div class="tile is-parent">
                  <div class="tile is-child box is-12 notification">
                      <p class="title">{{ plan.email }} </p>
                      <p class="subtitle">{{ plan.awards }}</p>
                  </div>
              </div>
          </div>
          <div v-if="loadedBodyMass">
            <measurement-chart :height="300" :labels="bodyMasssLabels" :datasets1="bodyMassDatasets" :datasets="leanBodyMassDatasets" label1="Weight(kg)" label="Lean Body Mass(kg)" stepSize=10></measurement-chart>
          </div>
          <div class="tile is-ancestor">
            <div class="tile is-4 is-vertical is-parent">
              <article class="tile is-child notification is-warning box">
                <p class="title">Body Stats</p>
                <strong>Weight:</strong> {{ plan.lastWeight }} kg
                <br/>
                <strong>Body Fat:</strong> {{ plan.lastBodyFat }}%
                <br/>
                <strong>Gender: </strong>{{ plan.gender | humanize }}
                <br/>
                <strong>Activity Level:</strong> {{ plan.activityLevel | humanize }}
              </article>
              <article class="tile is-child notification is-info box">
                <p class="title">Target Stats</p>
                <strong>Target Body Fat: </strong>{{ plan.targetBodyFat }}%
                <br/>
                <strong>Target Weight: </strong>{{ plan.targetWeight }} kg
              </article>
            </div>
            <div class="tile is-parent">
              <div class="tile is-child box">
                <p class="title">Lean Mass & Calories</p>
                <div class="tile">
                  <div class="tile is-child box is-6">
                    <p class="title">LBM</p>
                    <p class="subtitle">{{ plan.lastLbm }} kg</p>
                  </div>
                  <div class="tile is-child box is-6">
                    <p class="title">TDEE</p>
                    <p class="subtitle">{{ plan.tdee }} kcal</p>
                  </div>
                </div>
                <div class="tile">
                  <div class="tile is-child box is-6">
                    <p class="title">Days Till Sixpack</p>
                    <p class="subtitle">{{ plan.daysTillSixpack }} days</p>
                  </div>
                  <div class="tile is-child box is-6  notification is-success">
                    <p class="title">Day of Sixpack</p>
                    <p class="subtitle">{{ plan.dayOfSixpack }}</p>
                  </div>
                </div>
                <div class="tile is-child box is-12 notification is-danger">
                  <p class="title">Calories to Eat</p>
                  <p class="subtitle">{{ plan.totalCalories }}  kcal (cutting 20%)</p>
                </div>
              </div>
            </div>
          </div>
          <p><router-link :to="{ name: 'log_path' }" class="button is-large is-primary" role="button">Log data</router-link></p>
        </div>
        <div v-else>
          Loading...
        </div>
        <br />
      </div>
    </div>
    <div v-if="loadedCalories">
      <measurement-chart :height="300" :labels="caloriesLabels" :datasets="datasets" label="Calories(kcal)" stepSize=500 label1="TDEE calories(kcal)" :datasets1="targetCalories"></measurement-chart>
    </div>
    <div v-if="!isLoading">
      <br>
      <table class="table is-bordered is-striped is-fullwidth">
        <thead>
          <tr>
            <th>Date</th>
            <th>Weight</th>
            <th>Calories</th>
            <th>BF%</th>
            <th>LBM</th>
            <th>Status</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
        <tr v-for="measurement in measurements" 
            v-bind:key="measurement.id">
          <td>{{ measurement.logDate }} </td>
          <td>{{ measurement.weight }} kg</td>
          <td>
            <span v-if="measurement.calories">
              {{ measurement.calories }} kcal
            </span>
            <span v-else>
              -
            </span>
          </td>
          <td>
            <span v-if="measurement.bodyFat">
              {{ measurement.bodyFat }}%
            </span>
            <span v-else>
              -
            </span>
          </td>
          <td>
            <span v-if="measurement.lbm">
              {{ measurement.lbm }} kg
            </span>
            <span v-else>
              -
            </span>
          </td>
          <td>
            <span v-if="measurement.success != false" class="icon has-text-success">
              <i class="fas fa-check-square"></i>
            </span>
            <span v-if="measurement.success == false" class="icon has-text-danger">
              <i class="fas fa-minus-square"></i>
            </span>
          </td>
          <td class="has-text-right">
            <a class="has-text-white" @click="imageModal(measurement.image)" v-if="measurement.image" href="javascript:void();"><i class="far fa-image"></i></a>
            <a class="has-text-white" @click="openEditModal(measurement)" href="javascript:void();">Edit</a>
            <a class="has-text-danger" @click="confirmDelete(measurement)" href="javascript:void();">Delete</a>
          </td>
        </tr>
        </tbody>
      </table>
      <div v-if="total > 20"> 
        <b-pagination
          :total="total"
          :current.sync="page"
          :per-page="20"
          order="is-centered"
          @change="loadMeasurements">
        </b-pagination>
      </div>
    </div>
    <b-loading :is-full-page="true" :active.sync="isLoading" :can-cancel="false"></b-loading>
    <section class="section">
       Powered by Kodius 
    </section>
  </layout>
</template>

<script>
import axios from 'axios';
import Buefy from 'buefy'
import Layout from '../shared/layout';
import MeasurementChart from '../charts/measurement_chart';
import Vue from 'vue/dist/vue.esm';
import humanizeString from 'humanize-string';
import editLogModal from '../modals/edit_log_modal';
import chartMixin from '../../mixins/chart_mixin';

Vue.component('measurement-chart', MeasurementChart);
Vue.use(Buefy)

export default {
  mixins: [chartMixin],
  components: {
    Layout,
    MeasurementChart
  },
  data () {
    return {
      isLoading: true,
      plan: null,
      currentDimension: 'week',
      measurements: [],
      bodyMassDatasets: [],
      leanBodyMassDatasets: [],
      bodyMasssLabels: [],
      caloriesLabels: [],
      page: 1,
      total: 0,
      loadedBodyMass: false,
      loadedCalories: false
    }
  },
  filters: {
    humanize(text) {
      return humanizeString(text);
    }
  },
  mounted () {
    this.loadedCalories = false
    this.loadedBodyMass = false
    var that = this
    axios
      .get('my-plan')
      .then(response => {
        if (response.data.noplan) {
          that.$router.push({ name: 'my_profile_path' })
        } else {
          that.plan = response.data.plan
          axios
            .get('measurements?page=' + this.page)
            .then(response => {
                that.measurements = response.data.measurements
                that.total = response.data.count
                that.isLoading = false
                this.loadCaloriesChartData()
                this.loadBodyMassChartData()
          })
        }
      })
  },
  methods: {
    loadMeasurements() {
      var that = this;
      this.isLoading;
      setTimeout(() => axios
        .get('measurements?page=' + this.page)
        .then(response => {
            that.measurements = response.data.measurements
            that.total = response.data.count
            that.isLoading = false
      }), 50);
    },
    loadBodyMassChartData() {
      var that = this;
      axios
      .post('chart-data', {
        dimension: that.currentDimension,
        id: that.$route.params.id,
        average_on: 'weight'
      })
      .then(response => {
        for (var idx in response.data[0]) {
          that.bodyMasssLabels.push(that.currentDimension + ' ' + idx) 
          that.bodyMassDatasets.push(response.data[0][idx]) 
        }
        for (var idx in response.data[1]) {
          that.leanBodyMassDatasets.push(response.data[1][idx]) 
        }
        that.loadedBodyMass = true
      })
    },
    openEditModal (measurement) {
      this.$modal.open({
        parent: this,
        component: editLogModal,
        hasModalCard: true,
        props: {
          originalMeasurement: measurement
        }
      })
    },
    confirmDelete(measurement) {
      this.$dialog.confirm({
        title: 'Confirm',
        message: `Are you sure you want to <strong>delete</strong> ${measurement.logDate} log? This action can't be undone!`,
        confirmText: `Delete`,
        type: 'is-danger',
        hasIcon: true,
        onConfirm: () => this.performDelete(measurement.id)
      })
    },
    performDelete(id) {
      var that = this;
      axios
        .delete('measurements/' + id)
        .then(response => {
            this.loadMeasurements();
            that.$toast.open({
              message: 'Log successfuly deleted',
              duration: 5000
            })
      })
    },
    imageModal(url) {
      this.$modal.open(
        `<p class="image">
            <img src="${url}">
        </p>`
      )
    }
  }
}

</script>
