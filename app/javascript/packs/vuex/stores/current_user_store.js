import axios from 'axios';
import { stat } from 'fs';

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
    },
    measurements: {
      data: [],
      count: 0,
      loaded: false
    }
  },
  mutations: {
     reloadUser(state) {
       state.bodyMass.loaded = false
       state.calories.loaded = false
       state.measurements.loaded = false
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
    },
    setCalories(state, data) {
      state.calories.labels = data.labels
      state.calories.allowedCalories = data.allowedCalories
      state.calories.totalCalories = data.totalCalories
      state.calories.loaded = true
      return state
    },
    setMeasurements(state, data){
      state.measurements.data = data.measurements
      state.measurements.count = data.count
      state.measurements.loaded = true
    }
  },
  actions: {
    reloadUser({
       commit
    }) {
       commit('reloadUser')
    },
    loadPlan({ commit }) {
       axios
         .get(`my-plan`)
         .then(response => {
           commit('setPlan', response.data.plan)
         })
    },
    loadMeasurements({ commit }, query) {
      axios.get('measurements?page=' + query.page)
       .then(response => {
         commit('setMeasurements', {
           measurements: response.data.measurements,
           count: response.data.count
         })
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
