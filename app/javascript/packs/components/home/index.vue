<template>
  <layout>
      <div class="tile is-ancestor">
        <div class="tile is-12 is-vertical is-parent">
          <article class="tile is-child notification is-warning box">
            <p class="title">Board...</p>
            <p class="subtitle">Compare with your peers....</p>
                <b-message v-for="plan in plans" v-bind:key="plan.id">
                  <div class="columns has-text-weight-normal is-uppercase level" @click="$router.push({ name: 'show_profile_path', params: { id: plan.id }})">
                    <div class="column is-1">
                      <img :src="plan.avatar" alt="avatar" style="border-radius: 50%">
                    </div>
                    <div class="column is-8 is-level is-centered">
                      <div class="has-text-weight-semibold tags">
                        <span class="tag is-primary">
                          {{ plan.email }}
                        </span>
                        <span v-for="award in plan.awards" v-bind:key="award" class="tag is-light is-rounded">
                          {{ award }}
                        </span>
                      </div>
                    </div>
                    <div class="column is-3 is-level is-centered">
                        <div class="tag has-text-weight-semibold is-rounded"
                          :class="{'is-danger': (plan.fatLost < 0), 'is-success': (plan.fatLost >= 0)}">
                            Fat: {{plan.fatLost > 0 ? `-${plan.fatLost}` : `+${plan.fatLost * (-1)}`}} kg
                        </div>
                        <span class="tag has-text-weight-semibold is-rounded"
                          :class="{'is-danger': (plan.lbmDiff < 0), 'is-success': (plan.lbmDiff >= 0)}">
                        Lean: {{plan.lbmDiff > 0 ? '+' : ''}}{{plan.lbmDiff}} kg
                        </span>
                    </div>
                  </div>
                  <div class="columns">
                    <div class="column">
                      <div>
                        Weight: {{ plan.lastWeight }} kg
                      </div>
                    </div>
                    <div class="column">
                      <div>
                        Body Fat: {{ plan.lastBodyFat }}%
                      </div>
                    </div>
                    <div class="column">
                      <span>Streak: {{plan.daysStreak}} {{plan.daysStreak | pluralize('day')}}</span>
                    </div>
                    <div class="column">
                      <span>Tracking: {{plan.daysTracked}} {{plan.daysTracked | pluralize('day')}}</span>
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
