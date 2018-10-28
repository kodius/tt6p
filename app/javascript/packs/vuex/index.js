import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
Vue.use(Vuex);

import CurrentUserStore from './stores/current_user_store';

const store = new Vuex.Store({
  modules: {
    currentUser : CurrentUserStore
  }
});

export default store;
