<template>
  <div class='row'>
    <div class='col-xs-12'>
      <select class="pull-right" v-model="locale" style="margin-top: 10px;">
        <option v-for="locale in availableLocales" :value="locale">{{ locale | uppercase }}</option>
      </select>

      <h1>{{ $t('title') }}</h1>

      <ul class="nav nav-pills">
        <li :class="activeOn(['dashboard_path'])">
          <router-link :to="{ name: 'dashboard_path' }">{{ $t('nav.dashboard') }}</router-link>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {

  data: function() {
    return {
      locale: window.I18n.locale,
      availableLocales: window.I18n.availableLocales
    }
  },

  methods: {
    activeOn: function(paths) {
      if(paths.includes(this.$route.name)) {
        return 'active';
      } else {
        return '';
      }
    }
  },

  watch: {
    locale: function(locale) {
      let redirectTo = `/${locale}${this.$route.path}`;
      if(locale == this.availableLocales[0]) {
        redirectTo = `${this.$route.path}`
      }

      window.location.href = redirectTo;
    }
  }
}
</script>
