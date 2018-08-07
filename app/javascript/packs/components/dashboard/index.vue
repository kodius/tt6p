<template>
  <layout>
    <div class="col-xs-12">
      <h2>Plan</h2>
      <div v-if="loaded">
        Weight: {{ plan.weight }}
        <br/>
        Body Fat: {{ plan.bodyFat }}
        <br/>
        Target Body Fat: {{ plan.targetBodyFat }}
        <br/>
        Target Weight: {{ plan.targetWeight }}kg
        <br/>
        Gender: {{ plan.gender }}
        <br/>
        Activity Level: {{ plan.activityLevel }}
        <br/>
        TDEE: {{ plan.tdee }} kcal
      </div>
      <div v-else>
        Loading...
      </div>
      <br />
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
      plan: null
    }
  },
  mounted () {
    self = this
    axios
      .get('plans')
      .then(response => {
        self.plan = response.data.plans[0]
        self.loaded = true
      })
  }
}

</script>
