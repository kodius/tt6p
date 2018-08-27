import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';
import store from './vuex';
import router from './routes.js';
import './filters/strings.js';
import axios from 'axios';
import NavTop from './components/shared/_nav_top';
import Buefy from 'buefy'
Vue.component('nav-top', NavTop);

axios.defaults.baseURL = process.env.API_BASE_URL
axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector("meta[name=csrf-token]").content

Vue.use(VueI18n);
Vue.use(Buefy);
const i18n = new VueI18n({
  locale: 'current',
  messages: translations
})

const app = new Vue({
  i18n,
  router,
  store
}).$mount('#app')
