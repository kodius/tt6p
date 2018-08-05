import axios from 'axios';

const DashboardStore = {
  namespaced: true,
  state: {
    metrics: {}
  },
  mutations: {
    one(state, data) {
      state.metrics = data.metrics;
      return state;
    }
  },
  actions: {
    index(context, query) {
      axios
        .get(`dashboard`, {
          data: query
        })
        .then(response => {
          context.commit('one', response.data)
        })
    }
  }
};

export default DashboardStore;
