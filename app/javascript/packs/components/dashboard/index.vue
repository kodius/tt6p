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
                <strong>Target Weight: </strong>{{ plan.targetWeight }}kg
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
    <div v-if="loaded">
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
          <td class="level">
            <span v-if="measurement.success" class="icon has-text-success level-left">
              <i class="fas fa-check-square"></i>
            </span>
            <span v-if="!measurement.success" class="icon has-text-danger level-left">
              <i class="fas fa-minus-square"></i>
            </span>
            <a class="level-right has-text-danger" @click="confirmDelete(measurement)" href="javascript:void();">Delete</a>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </layout>
</template>

<script>
import axios from 'axios';
import Buefy from 'buefy'
import Layout from '../shared/layout';
import CommitChart from './commit_chart';
import Vue from 'vue/dist/vue.esm';
import humanizeString from 'humanize-string';

Vue.component('commit-chart', CommitChart);
Vue.use(Buefy)

export default {
  components: {
    Layout
  },
  data () {
    return {
      loaded: false,
      plan: null,
      measurements: []
    }
  },
  filters: {
    humanize(text) {
      return humanizeString(text);
    }
  },
  mounted () {
    var that = this
    axios
      .get('my-plan')
      .then(response => {
        that.plan = response.data.plan
        axios
          .get('measurements')
          .then(response => {
              that.measurements = response.data.measurements
              that.loaded = true
        })
      })
  },
  methods: {
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
            that.measurements = response.data.measurements
            console.log(response)
            that.$toast.open({
              message: 'Log successfuly deleted',
              duration: 5000
            })
      })
    }
  }
}

</script>
