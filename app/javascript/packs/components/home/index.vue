<template>
  <layout>
      <div class="tile is-ancestor">
        <div class="tile is-12 is-vertical is-parent">
          <article class="tile is-child notification is-warning box">
            <p class="title">Leader Board...</p>
            <p class="subtitle">Compare with your peers....</p>
            <p>
              <div v-if="loaded">
                {{ plans }}
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
    self = this
    axios
      .get('plans')
      .then(response => {
        self.plans = response.data.plans
        self.loaded = true
    })
  }
}
</script>

