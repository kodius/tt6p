<template>
  <layout>
      <div class="tile is-ancestor">
        <div class="tile is-12 is-vertical is-parent">
          <article class="tile is-child notification is-warning box">
            <p class="title">Leader Board...</p>
            <p class="subtitle">Compare with your peers....</p>
                <b-message v-for="plan in plans">
                  <div class="columns" @click="$router.push({ name: 'show_profile_path', params: { id: plan.id }})">
                    <div class="column is-1">
                      <img :src="plan.avatar" alt="avatar" style="border-radius: 50%">
                    </div>
                    <div class="column is-2" style="line-height: 100%; vertical-align: middle;">
                      {{ plan.email }}
                    </div>
                    <div class="column is-7">
                      <div class="has-text-centered columns">
                        <div class="is-one-fifth column is-success">
                          <p>Weight</p>
                          <div class="button is-rounded is-success">
                            {{ plan.lastWeight }} kg
                          </div>
                        </div>
                        <div class="is-one-fifth column">
                          <p>BF%</p>
                          <div class="button is-rounded is-success">
                            {{ plan.lastBodyFat }} %
                          </div>
                        </div>
                        <div class="is-one-fifth column">
                          <p>Fat</p>
                          <div class="button is-rounded" 
                            :class="{'is-danger': (plan.fatLost < 0), 'is-success': (plan.fatLost >= 0)}">
                              {{plan.fatLost > 0 ? `-${plan.fatLost}` : `+${plan.fatLost * (-1)}`}} kg
                        </div>
                        </div>
                        <div class="is-one-fifth column">
                          <p>LBM</p>
                          <a class="button is-rounded" 
                            :class="{'is-danger': (plan.lbmDiff < 0), 'is-success': (plan.lbmDiff >= 0)}">
                              {{plan.lbmDiff > 0 ? '+' : ''}}{{plan.lbmDiff}} kg
                          </a>
                        </div>
                        <div class="is-one-fifth column">
                          <p>Streak</p>
                          <a class="button is-success is-rounded">{{plan.daysStreak}} days</a>
                        </div>
                      </div>
                    </div>
                    <div class="column is-2">
                      {{ plan.awards }}
                    </div>
                  </div>
                </b-message>
                  <!-- <table class="table is-bordered is-striped is-fullwidth">
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
                  </table> -->
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
      .get('active-plans')
      .then(response => {
        that.plans = response.data.plans;
        that.loaded = true;
        console.warn(that.plans);
    })
  }
}
</script>

