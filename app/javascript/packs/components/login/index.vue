<template>
  <section class="place-at-v-centar">
    <h1 class="title">
      Time to Six Pack 
    </h1>
    <h2 class="subtitle">
      Getting it for real
    </h2>
    <b-field label="E-mail">
      <b-input v-model="email"
            type="email"
            @keyup.native.enter="logIn"></b-input>
    </b-field>
    <b-field label="Password">
      <b-input v-model="password"
              type="password"
              password-reveal
              @keyup.native.enter="logIn"></b-input>
    </b-field>
    <b-field>
      <b-checkbox v-model="rememberMe">Remember me</b-checkbox>
    </b-field>
    <b-message v-if="error" type="is-danger">{{ error }}</b-message>
    <b-field>
      <button class="button is-primary" @click="logIn">Login</button>
      <button class="button is-text">Forgot your password?</button>
    </b-field>
  </section>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        email: null,
        password: null,
        rememberMe: false,
        isLoading: false,
        error: null
      }
    },

    methods: {
      logIn() {
        this.isLoading = true;
        axios.post('/auth', {  email: this.email, 
                                    password: this.password, 
                                    remember_me: this.rememberMe })
                      .then(request => this.loginSuccessful(request))
                      .catch(() => this.loginFailed());
      },

      loginSuccessful(req) {
        this.isLoading = false;
        if (!req.data.token) {
          this.loginFailed();
          return;
        }
        this.error = false;
        localStorage.auth_key_secret = req.data.token;
        this.$router.push({name: 'root_path'})
      },
      
      loginFailed() {
        this.isLoading = false;
        this.error = 'Your email or password are incorect';
        delete localStorage.token;
      }
    }
  }
</script>