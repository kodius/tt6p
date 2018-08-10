<template>
  <layout>
    <div class="col-xs-12 jumbotron">
      <h2>Plan</h2>
      <div v-if="loaded">
        <strong>Weight:</strong> {{ plan.weight }} kg
        <br/>
        <strong>Body Fat:</strong> {{ plan.bodyFat }}%
        <br/>
        <br/>
        <strong>Activity Level:</strong> {{ plan.activityLevel }}
        <br/>
        <strong>Target Body Fat: </strong>{{ plan.targetBodyFat }}%
        <br/>
        <strong>Target Weight: </strong>{{ plan.targetWeight }}kg
        <br/>
        <strong>Gender: </strong>{{ plan.gender }}
        <br/>
        <br/>
        <h4>LBM: {{ plan.lbm }} kg</h4>
        <h4>TDEE: {{ plan.tdee }} kcal</h4>
        <br/>
        <h4>Total Calories: {{ plan.totalCalories }} kcal (cutting 20%)</h4>
        <h2 class="alert alert-success">Sixpack in: {{ plan.daysTillSixpack }} days</h2>
        <p><a class="btn btn-primary btn-lg" href="#" role="button">Let's go</a></p>
      </div>
      <div v-else>
        Loading...
      </div>
      <br />
    </div>
    <div v-if="loaded">
      <div class="panel panel-default">
        <div class="panel-heading">Weight Log</div>
          <table class="table">
            <tr>
              <th>Date</th>
              <th>Weight</th>
            </tr>
            <tr v-for="measurement in measurements">
              <td>{{ measurement.logDate }} </td>
              <td>{{ measurement.weight }} kg</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </layout>
</template>

<script>
import axios from 'axios';
import Layout from '../shared/layout';
import CommitChart from './commit_chart';
import Vue from 'vue/dist/vue.esm';

Vue.component('commit-chart', CommitChart);

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
  mounted () {
    self = this
    axios
      .get('plans')
      .then(response => {
        self.plan = response.data.plans[0]
        axios
          .get('measurements')
          .then(response => {
              console.log(response)
              self.measurements = response.data.measurements
              self.loaded = true
        })
      })
  }
}

</script>
