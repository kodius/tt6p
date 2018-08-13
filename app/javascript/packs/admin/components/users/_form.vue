<template>
  <section>
    <b-field
      type="is-danger"
      message="This email is invalid">
      <label for="">{{ $t('activerecord.models.user.email') }}</label>
      <span class='error'>{{errors.email}}</span>
      <b-input type="email"
        v-model="user.email"
        maxlength="30">
      </b-input>
    </b-field>
    <b-field>
      <label for="">{{ $t('activerecord.models.user.password') }}</label>
      <span class='error'>{{errors.password}}</span>
      <b-input type="password"
        v-model="user.password" 
        password-reveal>
      </b-input>
    </b-field>
    <b-field>
      <label for="">{{ $t('activerecord.models.user.password_confirmation') }}</label>
      <span class='error'>{{errors.password_confirmation}}</span>
      <b-input type="password"
        v-model="user.password_confirmation" 
        password-reveal>
      </b-input>
    </b-field>
    <router-link :to="{ name: 'users_path' }" class="btn btn-default pull-left">{{ $t('cancel')}}</router-link>
    <submit-tag :value="$t('save')" klass="btn btn-warning pull-right" :progress="progress"></submit-tag>
  </section>
</template>

<script>
export default {
  data: function() {
    return this.$store.state.UserStore;
  }
}
</script>
