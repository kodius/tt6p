import axios from 'axios';

const CurrentUserStore = {
  namespaced: true,
  state: {
    plan: {},
    initialLoad: false,
    bodyMass: {
      labels: [],
      totalBodyMass: [],
      leanBodyMass: [],
      loaded: false
    },
    calories: {
      labels: [],
      allowedCalories: [],
      totalCalories: [],
      loaded: false
    }
  },
  mutations: {
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
    },
    setCalories(state, data) {
      state.calories.labels = data.labels
      state.calories.allowedCalories = data.allowedCalories
      state.calories.totalCalories = data.totalCalories
      state.calories.loaded = true
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
    loadBodyMass({ commit }, query) {
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
    },
    loadCalories({ commit }, query) {
       axios.post('chart-data', {
         dimension: query.dimension,
         id: query.id,
         average_on: 'calories'
       }).then(response => {
         var labels = []
         var allowedCalories = []
         var totalCalories = []
         for (var idx in response.data[0]) {
           labels.push('week' + ' ' + idx)
           totalCalories.push(response.data[0][idx])
         }
         for (var idx in response.data[1]) {
           allowedCalories.push(response.data[1][idx])
         }
         commit('setCalories', {
           labels,
           allowedCalories,
           totalCalories
         })
       })
     }
  }
};

export default CurrentUserStore;
