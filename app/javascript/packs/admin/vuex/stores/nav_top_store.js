import axios from 'axios';

const NavTopStore = {
  namespaced: true,
  state: {
    locale: window.I18n.locale,
    availableLocales: window.I18n.availableLocales
  },
  actions: {
    logout(context) {
      return new Promise((resolve, reject) => {
        axios
        .delete(`sign_out`)
        .then(response => {
          resolve();
        })
      });
    }
  }
};

export default NavTopStore;
