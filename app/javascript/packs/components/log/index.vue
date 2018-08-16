<template>
  <layout>
    <div class="columns">
      <div class="column is-half">
        <label class="label">New entry</label>
        <span v-if="errors.date" class="help is-danger">{{ errors.date }}</span>
        <b-field
                :type="errors.date ? 'is-danger' : ''">
            <b-datepicker
                placeholder="Select a date"
                v-model="date"
                @focus="errors.date = null"
                @input="dateSelected()"
                :events="events"
                icon="calendar-today">
            </b-datepicker>
        </b-field>
        <span v-if="errors.weight !== null" class="help is-danger">{{ errors.weight }}</span>
        <b-field
              :type="errors.weight ? 'is-danger' : ''">
          <b-input
              placeholder="Weight"
              v-model="weight"
              @focus="errors.weight = null"
              expanded>
          </b-input>
          <p class="control">
            <span class="button is-static">KG</span>
          </p>
        </b-field>
        <span v-if="errors.bodyfat" class="help is-danger">{{ errors.bodyfat }}</span>
        <b-field
              :type="errors.bodyfat ? 'is-danger' : ''">
            <b-input
                placeholder="Body fat"
                v-model="bodyfat"
                @focus="errors.bodyfat = null"
                expanded>
            </b-input>
            <p class="control">
              <span class="button is-static">%</span>
            </p>
          </b-field>
        <span v-if="errors.calories" class="help is-danger">{{ errors.calories }}</span>
        <b-field
              :type="errors.calories ? 'is-danger' : ''">
          <b-input
              placeholder="Calories"
              v-model="calories"
              @focus="errors.calories = null"
              expanded>
          </b-input>
          <p class="control">
            <span class="button is-static">cal</span>
          </p>
        </b-field>
      </div><div class="column is-half">
          <b-field label="Aditional info">
              
          </b-field>
      </div>
      <hr>
    </div>
    <button class="button is-primary" @click="save">
      {{ $t('save') }}
    </button>
    <router-link :to="{ name: 'dashboard_path' }" class="button">{{ $t('cancel')}}</router-link>
  </layout>
</template>

<script>
import Layout from '../shared/layout';
import axios from 'axios';

export default {
  components: {
    Layout
  },
  data: function() {
    return {
      date: null,
      weight: null,
      bodyfat: null,
      calories: null,
      errors: {
        date: null,
        weight: null,
        bodyfat: null,
        calories: null
      },
      events: [
        {
          date: new Date(2018, new Date().getMonth(), 1),
          type: 'is-success'
        }
      ]
    }
  },
  methods: {
    save() {
      if (this.checkRequired() == false)
      {
        
      }
    },
    checkRequired() {
      var hasError = false;
      if (this.date == null)
        { this.errors.date = this.$t('errors.required'); hasError = true; }
      if (this.weight == null)
        { this.errors.weight = this.$t('errors.required'); hasError = true; }
      if (this.bodyfat == null)
        { this.errors.bodyfat = this.$t('errors.required'); hasError = true; }
      if (this.calories == null)
        { this.errors.calories = this.$t('errors.required'); hasError = true; }

      return hasError;
    },
    dateSelected() {
      console.log('Kurac');
      // Testing
      axios.post('/entry', {
        params: {
          date: this.date
        }
      }).then(function(response) {
        console.log(response)
      });
    }
  }
}
</script>
