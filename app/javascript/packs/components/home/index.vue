<template>
  <layout>
      <div class="tile is-ancestor">
        <div class="tile is-12 is-vertical is-parent">
          <article class="tile is-child notification is-warning box">
            <p class="title">Leader Board...</p>
            <p class="subtitle">Compare with your peers....</p>
            <p>
              <div v-if="loaded">
                  <table class="table is-bordered is-striped is-fullwidth">
                    <thead>
                      <tr>
                        <th>Email</th>
                        <th>Weight</th>
                        <th>Fat</th>
                        <th>LBM</th>
                        <th>Streak</th>
                        <th>Day of Glory</th>
                        <th>Awards</th>
                      </tr>
                    </thead>
                    <tbody>
                    <tr v-for="plan in plans" 
                        v-bind:key="plan.id">
                      <td>
                        <router-link :to="{ name: 'show_profile_path', params: { id: plan.id }}">
                          {{ plan.email }}
                        </router-link>

                      </td>
                      <td>{{ plan.lastWeight }} kg</td>
                      <td>
                          {{ plan.lastBodyFat }}% </br>
                          {{ plan.fatMass }}kg ({{ plan.fatLost }}kg)
                      </td>
                      <td>{{ plan.lastLbm }}kg ({{ plan.lbmDiff }}kg)</td>
                      <td>{{ plan.daysStreak }} days</td>
                      <td>{{ plan.dayOfSixpack }}</td>
                      <td>{{ plan.awards }}</td>
                    </tr>
                    </tbody>
                  </table>
              </div>
            </p>
          </article>
        </div>
      </div>
  </layout>
</template>

<script>
import axios from 'axios';
import Layout from '../shared/layout';

export default {
  components: {
    Layout
  },
  data () {
    return {
      loaded: false,
      plans: []
    }
  },
  mounted () {
    var that = this
    axios
      .get('plans')
      .then(response => {
        that.plans = response.data.plans
        that.loaded = true
    })
  }
}
</script>

