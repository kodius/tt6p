<template>
  <div class="tile is-ancestor">
    <div class="tile is-parent">
      <div class="tile is-child box is-12 notification">
        <div class="has-text-weight-semibold tags">
          <span class="tag is-primary">
            {{ plan.email }}
          </span>
          <span v-for="award in plan.awards" v-bind:key="award" class="tag is-light is-rounded">
            {{ award }}
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: ['plan'],
    data: function () {
      return {}
    }
  }

</script>
