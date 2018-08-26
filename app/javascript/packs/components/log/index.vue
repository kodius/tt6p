<template>
  <layout>
    <div class="notification">
      <div class="columns">
        <div class="column is-half">
          <span v-if="errors.date" class="help is-danger">{{ errors.date }}</span>
          <b-field
                  :type="errors.date ? 'is-danger' : ''">
              <b-datepicker
                  placeholder="Select date"
                  v-model="measurement.logDate"
                  @focus="errors.date = null"
                  :events="events"
                  icon="calendar-today">
              </b-datepicker>
          </b-field>
          <span v-if="errors.weight !== null" class="help is-danger">{{ errors.weight }}</span>
          <b-field
                :type="errors.weight ? 'is-danger' : ''">
            <b-input
                placeholder="Weight"
                v-model="measurement.weight"
                @focus="errors.weight = null"
                expanded>
            </b-input>
            <p class="control">
              <span class="button is-static">kg</span>
            </p>
          </b-field>
          <span v-if="errors.bodyFat" class="help is-danger">{{ errors.bodyFat }}</span>
          <b-field
                :type="errors.bodyFat ? 'is-danger' : ''">
              <b-input
                  placeholder="Body fat"
                  v-model="measurement.bodyFat"
                  @focus="errors.bodyFat = null"
                  expanded>
              </b-input>
              <p class="control">
                <span class="button is-static">%</span>
              </p>
            </b-field>
          <b-field>
            <b-input
                placeholder="Calories"
                v-model="measurement.calories"
                @focus="errors.calories = null"
                expanded>
            </b-input>
            <p class="control">
              <span class="button is-static">kcal</span>
            </p>
          </b-field>
        </div><div class="column is-half">
        </div>
        <hr>
      </div>
      <button class="button is-primary" @click="save">
        Log data
      </button>
      <router-link :to="{ name: 'dashboard_path' }" class="button">{{ $t('cancel')}}</router-link>
     </div>
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
      measurement: {
        logDate: null,
        weight: null,
        bodyFat: null,
        calories: null,
      },
      errors: {
        date: null,
        weight: null,
        bodyFat: null,
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
  mounted () {
    var that = this
    axios
      .get('measurements/new')
      .then(response => {
        that.measurement = response.data["measurement"]
        that.measurement.logDate = new Date(response.data["measurement"]["logDate"])
      })
  },
  methods: {
    save() {
      if (this.checkRequired() == false)  
      {
        axios.post('/measurements', {
           measurement: this.measurement
        }).then(function(response) {
          self.$router.push({ name: 'dashboard_path' })
        });
      }
    },
    checkRequired() {
      var hasError = false;
      if (this.measurement.logDate == null)
        { this.errors.date = this.$t('errors.required'); hasError = true; }
      if (this.measurement.weight == null)
        { this.errors.weight = this.$t('errors.required'); hasError = true; }
      if (this.measurement.bodyFat == null)
        { this.errors.bodyFat = this.$t('errors.required'); hasError = true; }

      return hasError;
    }
  }
}
</script>
