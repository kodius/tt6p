<template>
  <layout>
    <div class="columns">
      <div class="column is-half">
        <b-field label="Required">
            <b-datepicker
                placeholder="Select a date"
                icon="calendar-today">
            </b-datepicker>
        </b-field>
        <b-field>
          <b-input
              placeholder="Weight"
              expanded>
          </b-input>
          <p class="control">
            <span class="button is-fullwidth">
              KG
            </span>
          </p>
        </b-field>
        <b-field>
            <b-input
                placeholder="Body fat"
                expanded>
            </b-input>
            <p class="control">
              <span class="button">
                %
              </span>
            </p>
          </b-field>
        <b-field>
          <b-input
              placeholder="Calories"
              expanded>
          </b-input>
          <p class="control">
            <span class="button">
              cal
            </span>
          </p>
        </b-field>
      </div><div class="column is-half">
          <b-field label="Aditional info">
              
          </b-field>
      </div>
      <hr>
    </div>
    <button class="button is-primary" :progress="progress">
      {{ $t('save') }}
    </button>
    <router-link :to="{ name: 'dashboard_path' }" class="button">{{ $t('cancel')}}</router-link>
  </layout>
</template>

<script>
import Layout from '../shared/layout';

export default {
  components: {
    Layout
  }
}
</script>
