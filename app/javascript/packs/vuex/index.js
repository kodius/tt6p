import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
Vue.use(Vuex);

import UserStore from './stores/user_store';

const store = new Vuex.Store({
  modules: {
    UserStore
  }
});

export default store;
