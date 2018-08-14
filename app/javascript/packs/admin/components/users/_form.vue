<template>
  <section>
    <div class="column is-half">
      <b-field label="Email"
              :type="errors.email ? 'is-danger' : ''"
              :message="errors.email ? errors.email : ''">
        <b-input v-model="user.email" type="email"></b-input>
      </b-field>
      <b-field label="Password"
              :type="errors.password ? 'is-danger' : ''"
              :message="errors.password ? errors.password : ''">
        <b-input v-model="user.password" type="password"></b-input>
      </b-field>
      <b-field label="Confirm password"
              :type="errors.password_confirmation ? 'is-danger' : ''"
              :message="errors.password_confirmation ? errors.password_confirmation : ''">
        <b-input v-model="user.password_confirmation" type="password"></b-input>
      </b-field>
      <!-- <submit-tag :value="$t('save')" klass="btn btn-warning pull-right" :progress="progress"></submit-tag> -->
      <button class="button is-primary" :progress="progress">
        {{ $t('save') }}
      </button>
      <router-link :to="{ name: 'users_path' }" class="button">{{ $t('cancel')}}</router-link>
    </div>
  </section>
</template>

<script>
export default {
  data: function() {
    return this.$store.state.UserStore;
  }
}
</script>