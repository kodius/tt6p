<template>
  <layout>
      <div class="tile is-ancestor">
        <div class="tile is-12 is-vertical is-parent">
          <article class="tile is-child notification is-warning box">
            <p class="title">Leader Board...</p>
            <p class="subtitle">Compare with your peers....</p>
                <b-message v-for="plan in plans" v-bind:key="plan.id">
                  <div class="columns is-size-7 has-text-weight-normal is-uppercase level" @click="$router.push({ name: 'show_profile_path', params: { id: plan.id }})">
                    <div class="column is-1">
                      <img :src="plan.avatar" alt="avatar" style="border-radius: 50%">
                    </div>
                    <div class="column is-2 is-level is-centered">
                      <span class="tag is-primary">
                        {{ plan.email }}
                      </span>
                    </div>
                    <div class="column is-7">
                      <div class="has-text-centered columns">
                        <div class="is-one-fifth column is-success">
                          <p>Weight</p>
                          <div class="button is-rounded has-text-weight-semibold is-success">
                            {{ plan.lastWeight }} kg
                          </div>
                        </div>
                        <div class="is-one-fifth column">
                          <p>BF%</p>
                          <div class="button is-rounded has-text-weight-semibold is-success">
                            {{ plan.lastBodyFat }} %
                          </div>
                        </div>
                        <div class="is-one-fifth column">
                          <p>Fat</p>
                          <div class="button has-text-weight-semibold is-rounded"
                            :class="{'is-danger': (plan.fatLost < 0), 'is-success': (plan.fatLost >= 0)}">
                              {{plan.fatLost > 0 ? `-${plan.fatLost}` : `+${plan.fatLost * (-1)}`}} kg
                        </div>
                        </div>
                        <div class="is-one-fifth column">
                          <p>LBM</p>
                          <a class="button has-text-weight-semibold is-rounded"
                            :class="{'is-danger': (plan.lbmDiff < 0), 'is-success': (plan.lbmDiff >= 0)}">
                              {{plan.lbmDiff > 0 ? '+' : ''}}{{plan.lbmDiff}} kg
                          </a>
                        </div>
                        <div class="is-one-fifth column">
                          <p>Streak</p>
                          <a class="button has-text-weight-semibold is-success is-rounded">{{plan.daysStreak}} {{plan.daysStreak | pluralize('day')}}</a>
                        </div>
                      </div>
                    </div>
                    <div class="column has-text-weight-semibold tags is-2">
                      <span v-for="award in plan.awards" v-bind:key="award" class="tag is-light">
                        {{ award }}
                      </span>
                    </div>
                  </div>
                </b-message>
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
    })
  }
}
</script>
