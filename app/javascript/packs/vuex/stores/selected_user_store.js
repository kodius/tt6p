import axios from 'axios';
import {
  stat
} from 'fs';

const SelectedUserStore = {
  namespaced: true,
  state: {
    plan: {},
    initialLoad: false,
    bodyMass: {
      labels: [],
      totalBodyMass: [],
      leanBodyMass: [],
      loaded: false
    }
  },
  mutations: {
    reloadUser(state) {
      state.initialLoad = false
      state.bodyMass.loaded = false
      return state
    },
    setPlan(state, plan) {
      state.plan = plan
      state.initialLoad = true
      return state
    },
    setBodyMass(state, data) {
      state.bodyMass.labels = data.labels
      state.bodyMass.totalBodyMass = data.totalBodyMass
      state.bodyMass.leanBodyMass = data.leanBodyMass
      state.bodyMass.loaded = true
      return state
    }
  },
  actions: {
    reloadUser({
      commit
    }) {
       commit('reloadUser')
    },
    loadPlan({
      commit
    }, query) {
      axios
        .get(`public-profile/${query.id}`)
        .then(response => {
          commit('setPlan', response.data.plan)
        })
    },
    loadBodyMass({
      commit
    }, query) {
      axios.post('chart-data', {
        dimension: query.dimension,
        id: query.id,
        average_on: 'weight'
      }).then(response => {
        var labels = []
        var leanBodyMass = []
        var totalBodyMass = []
        for (var idx in response.data[0]) {
          labels.push('week' + ' ' + idx)
          totalBodyMass.push(response.data[0][idx])
        }
        for (var idx in response.data[1]) {
          leanBodyMass.push(response.data[1][idx])
        }
        commit('setBodyMass', {
          labels,
          totalBodyMass,
          leanBodyMass
        })
      })
    }
  }
};

export default SelectedUserStore;
