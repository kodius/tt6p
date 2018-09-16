<template>
  <layout>

    <div class="container">

      <div class="notification">
        <div v-if="loaded">
          <div class="tile is-ancestor">
              <div class="tile is-parent">
                  <div class="tile is-child box is-12 notification">
                      <p class="title">{{ plan.email }} </p>
                      <p class="subtitle">{{ plan.awards }}</p>
                  </div>
              </div>
          </div>
          <div v-if="measurements">
            <measurement-chart :measurements="measurements"></measurement-chart>
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
                <br/>
                <strong>LBM Difference:</strong> {{ plan.lbmDiff }} kg
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
                <div class="tile">
                  <div class="tile is-child box is-6 notification is-danger">
                    <p class="title">Fat Lost</p>
                    <p class="subtitle">{{ plan.fatLost }} kg</p>
                  </div>
                  <div class="tile is-child box is-6  notification is-success">
                    <p class="title">Streak</p>
                    <p class="subtitle">{{plan.daysStreak}} {{plan.daysStreak | pluralize('day')}}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div v-else>
          Loading...
        </div>
        <br />
      </div>
    </div>
    <div v-if="loaded">
      <b-pagination
        :total="total"
        :current.sync="page"
        :per-page="20"
        order="is-centered"
        @change="loadMeasurements">
      </b-pagination>
      <table class="table is-bordered is-striped is-fullwidth">
        <thead>
          <tr>
            <th>Date</th>
            <th>Weight</th>
            <th>Calories</th>
            <th>BF%</th>
            <th>LBM</th>
            <th>Status</th>
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
            <span v-if="measurement.success" class="icon has-text-success">
              <i class="fas fa-check-square"></i>
            </span>
            <span v-if="measurement.success == false" class="icon has-text-danger">
              <i class="fas fa-minus-square"></i>
            </span>
          </td>
        </tr>
        </tbody>
      </table>
      <b-pagination
        :total="total"
        :current.sync="page"
        :per-page="20"
        order="is-centered"
        @change="loadMeasurements">
      </b-pagination>
    </div>
  </layout>
</template>

<script>
import axios from 'axios';
import Layout from '../shared/layout';
import Vue from 'vue/dist/vue.esm';
import humanizeString from 'humanize-string';
import MeasurementChart from '../charts/measurement_chart';

Vue.component('measurement-chart', MeasurementChart);

export default {
  components: {
    Layout,
    MeasurementChart
  },
  data () {
    return {
      loaded: false,
      plan: null,
      measurements: [],
      page: 1,
      total: 0
    }
  },
  filters: {
    humanize(text) {
      return humanizeString(text);
    }
  },
  mounted () {
    self = this
    axios
      .get('public-profile/' + this.$route.params.id)
      .then(response => {
        self.plan = response.data.plan
        axios
          .get(`public-measurements/${this.$route.params.id}/1`)
          .then(response => {
              self.measurements = response.data.measurements;
              self.total = response.data.count;
              self.loaded = true
        })
      })
  },
  methods: {
    loadMeasurements() {
      var that = this;
      setTimeout(() => axios
        .get(`public-measurements/${this.$route.params.id}/${this.page}`)
        .then(response => {
            that.measurements = response.data.measurements
            that.total = response.data.count
      }), 50);
    }
  }
}

</script>
