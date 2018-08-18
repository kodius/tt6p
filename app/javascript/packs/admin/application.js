import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';
import Buefy from 'buefy'
import 'buefy/lib/buefy.css'
import store from './vuex';
import router from './routes.js';
import './filters/strings.js';
import helpers from './helpers';
import EventBus from './event_bus';
import axios from 'axios';
// Expose EventBus to window for JQuery access (ActionCable)
window.EventBus = EventBus;

import NavTop from './components/shared/_nav_top';
Vue.component('nav-top', NavTop);

import SubmitTag from './components/shared/_submit_tag';
Vue.component('submit-tag', SubmitTag);

axios.defaults.baseURL = process.env.API_BASE_URL + 'admin/'
axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector("meta[name=csrf-token]").content


Vue.use(VueI18n);
const i18n = new VueI18n({
  locale: 'current',
  messages: translations
})

Vue.use(Buefy)

const app = new Vue({
  i18n,
  router,
  store
}).$mount('#app')
