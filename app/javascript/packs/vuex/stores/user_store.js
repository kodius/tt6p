import axios from 'axios';

const MusicianStore = {
  namespaced: true,
  state: {
    musicians: [],
    musician: {}
  },
  mutations: {
    one(state, data) {
      state.musician = data.musician;
      return state;
    },
    many(state, data) {
      state.musicians= data.musicians;
      return state;
    }
  },
  actions: {
    index(context, query) {
      axios
        .get(`musicians`, {
          data: query
        })
        .then(response => {
          context.commit('many', response.data)
        })
    },
    show(context, id) {
      axios
        .get(`musicians/${id}`)
        .then(response => {
          context.commit('one', response.data)
        })
    },
  }
};

export default MusicianStore;
