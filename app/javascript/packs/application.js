import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';
import store from './vuex';
import router from './routes.js';
import './filters/strings.js';
import axios from 'axios';
import NavTop from './components/shared/_nav_top';
import Buefy from 'buefy'
import Vue2Filters from 'vue2-filters'
 
Vue.component('nav-top', NavTop);

axios.defaults.baseURL = process.env.API_BASE_URL;
axios.defaults.transformRequest = [function (data, headers) {
  headers['Authorization'] = 'Bearer ' + localStorage.auth_key_secret;
  return JSON.stringify(data);
}];
axios.defaults.headers = {
  'Content-Type': 'application/json'
};

Vue.use(VueI18n);
Vue.use(Buefy);
Vue.use(Vue2Filters);

const i18n = new VueI18n({
  locale: 'current',
  messages: translations
})

const app = new Vue({
  i18n,
  router,
  store,
  mounted() {
    this.checkLogin();
  },
  methods: {
    checkLogin() {
      if (localStorage.auth_key_secret == null) { // It is important that it is == so ta it allows undefined and empty string
        this.$router.push({name: 'login_path'});
      }
    }
  },
  watch: {
    '$route' (to, from) {
      this.checkLogin();
    }
  }
}).$mount('#app')
