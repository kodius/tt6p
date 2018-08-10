import helpers from '../../helpers';
import axios from 'axios';

const UserStore = {
  namespaced: true,
  state: {
    users: [],
    user: {},
    errors: {},
    progress: '',
    pagination: {}
  },
  mutations: {
    one(state, data) {
      state.errors = {}
      state.user = data.user;
      return state;
    },
    many(state, data) {
      state.users= data.users;
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
        .get(`users`, {
          params: query
        })
        .then(response => {
          context.commit('many', response.data)
        })
    },
    new(context, id) {
      axios
        .get(`users/new`)
        .then(response => {
          context.commit('one', response.data)
        })
    },
    create(context, form) {
      context.commit('progress', 'loading')
      return new Promise((resolve, reject) => {
        axios
          .post(`users`, {
            user: form
          })
          .then(response => {
            context.commit('progress', 'success')
            resolve(response.data);
          })
          .catch(function (response) {
            context.commit('progress', 'failed')
            context.commit('errors', response.errors);
          })
      })
    },
    edit(context, id) {
      axios
        .get(`users/${id}/edit`)
        .then(response => {
          context.commit('one', response.data)
        })
    },
    update(context, user) {
      context.commit('progress', 'loading')
      return new Promise((resolve, reject) => {
        axios
          .put(`users/${user.id}`, {
            user: user
          })
          .then(response => {
            context.commit('progress', 'success')
            resolve(response.data);
          })
          .catch(function (response) {
            context.commit('progress', 'failed')
            context.commit('errors', response.errors);
            reject(data);
          })
      })
    },
    destroy(context, user_id) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`users/${user_id}`)
          .then(response => {
            resolve(response.data);
          })
          .catch(function (error) {
            reject(data);
          })
      });
    }
  }
};

export default UserStore;
