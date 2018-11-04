import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
Vue.use(Vuex);

import CurrentUserStore from './stores/current_user_store';
import SelectedUserStore from './stores/selected_user_store';

const store = new Vuex.Store({
  modules: {
    currentUser : CurrentUserStore,
    selectedUser : SelectedUserStore
  }
});

export default store;
