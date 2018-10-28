import axios from 'axios';

const CurrentUserStore = {
  namespaced: true,
  state: {
    plan: {},
    bodyMass: {
      labels: [],
      totalBodyMass: [],
      leanBodyMass: [],
      loaded: false
    }
  },
  mutations: {
    setPlan(state, plan) {
      state.plan = plan
      return state
    },
    setBodyMass(state, data) {
      state.bodyMass.labels = data.bodyMasssLabels
      state.bodyMass.totalBodyMass = data.bodyMassDatasets
      state.bodyMass.leanBodyMass = data.leanBodyMassDatasets
      state.bodyMass.loaded = true
      return state
    }
  },
  actions: {
    loadPlan({ commit }) {
       axios
         .get(`my-plan`)
         .then(response => {
           commit('setPlan', response.data.plan)
         })
    },
    loadBodyMassData({ commit }, query) {
      axios.post('chart-data', {
          dimension: query.dimension,
          id: query.id,
          average_on: 'weight'
        }).then(response => {
            var bodyMasssLabels = []
            var leanBodyMassDatasets = []
            var bodyMassDatasets = []
            for (var idx in response.data[0]) {
              bodyMasssLabels.push('week' + ' ' + idx)
              bodyMassDatasets.push(response.data[0][idx])
            }
            for (var idx in response.data[1]) {
              leanBodyMassDatasets.push(response.data[1][idx])
            }
            commit('setBodyMass', { bodyMasssLabels, bodyMassDatasets, leanBodyMassDatasets })
       })
    }
  }
};

export default CurrentUserStore;
