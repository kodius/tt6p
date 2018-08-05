import helpers from '../../helpers';
import axios from 'axios';

const MusicianStore = {
  namespaced: true,
  state: {
    musicians: [],
    musician: {},
    errors: {},
    bands: [],
    progress: '',
    pagination: {}
  },
  mutations: {
    one(state, data) {
      state.errors = {}
      state.musician = data.musician;
      return state;
    },
    many(state, data) {
      state.bands = data.bands;
      state.musicians= data.musicians;
      state.pagination = data.pagination;
      return state;
    },
    progress(state, step) {
      state.progress = step;
      return state.progress;
    },
    errors(state, data) {
      state.errors = helpers.showErrors(data);
      return state.errors;
    }
  },
  actions: {
    index(context, query) {
      axios
        .get(`musicians?${query}`, {
          params: query
        })
        .then(response => {
          context.commit('many', response.data)
        })
    },
    new(context, id) {
      axios
        .get(`musicians/new`)
        .then(response => {
          context.commit('one', response.data)
        })
    },
    create(context, form) {
      context.commit('progress', 'loading')
      return new Promise((resolve, reject) => {
        axios
          .post(`musicians`, {
            musician: form
          })
          .then(response => {
            context.commit('progress', 'success')
            resolve(response.data);
          })
          .catch(function (response) {
            context.commit('progress', 'failed')
            context.commit('errors', response.errors)
          })
      })
    },
    edit(context, id) {
      axios
        .get(`musicians/${id}/edit`)
        .then(response => {
          context.commit('one', response.data)
        })
    },
    update(context, musician) {
      context.commit('progress', 'loading')
      axios
        .put(`musicians/${musician.id}`, {
          musician: musician
        })
        .then(response => {
          context.commit('progress', 'success')
          context.commit('one', response.data)
        })
        .catch(function (response) {
          context.commit('progress', 'failed')
          context.commit('errors', response.errors)
        })
    },
    destroy(context, musician_id) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`musicians/${musician.id}`)
          .then(response => {
            resolve(response.data);
          })
          .catch(function (error) {
            reject(response.data);
          })
      });
    }
  }
};

export default MusicianStore;
