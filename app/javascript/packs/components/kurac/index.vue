<template>
  <layout>
    <div class="col-xs-12">
      <h2>Plan</h2>
      <div v-if="loaded">
        Weight: {{ plan.weight }}
        <br/>
        Body Fat: {{ plan.body_fat }}
        <br/>
        Target Body Fat: {{ plan.target_body_fat }}
      </div>
      <div v-else>
        Loading... {{ loaded}}
      </div>
      <br />
    </div>
  </layout>
</template>

<script>
import Layout from '../shared/layout';

export default {
  components: {
    Layout
  },
  data: function () {
    return {
      loaded: false,
      plan: null
    }
  },
  mounted: function () {
    var self = this;
    $.ajax({
          url: `plans`,
          type: 'get',
          success: function(data) {
            self.plan = data[0]
            self.loaded = true
          }
    })
  }

}

</script>
