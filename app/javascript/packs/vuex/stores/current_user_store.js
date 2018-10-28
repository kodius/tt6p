import axios from 'axios';

const CurrentUserStore = {
  namespaced: true,
  state: {
    plan: {},
  },
  mutations: {
    setPlan(state, plan) {
      state.plan = plan
      return state
    }
  },
  actions: {
    getPlan({ commit }) {
       axios
         .get(`my-plan`)
         .then(response => {
           commit('setPlan', response.data.plan)
         })
    }
  }
};

export default CurrentUserStore;
