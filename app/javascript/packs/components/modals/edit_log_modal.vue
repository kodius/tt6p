<template>
  <div class="modal-card">
    <header class="modal-card-head">
      <p class="modal-card-title">Edit log <em>{{measurement.logDate}}</em></p>
    </header>
    <section class="modal-card-body">
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
    </section>
    <footer class="modal-card-foot">
      <button class="button is-primary" @click="updateLog">
        Update log
      </button>
      <button class="button" @click="$parent.close()">
        Cancel
      </button>
    </footer>
    <b-loading :is-full-page="false" :active.sync="isLoading" :can-cancel="false"></b-loading>
  </div>
</template>

<script> // TODO: Get rid of `SyntaxError: Unexpected token ')'` error
  import axios from 'axios';

  export default {
    props: ['originalMeasurement'],
    data: function() {
      return {
        measurement: {
          logDate: this.originalMeasurement.logDate,
          weight: this.originalMeasurement.weight,
          bodyFat: this.originalMeasurement.bodyFat,
          calories: this.originalMeasurement.calories,
        },
        errors: {
          date: null,
          weight: null,
          bodyFat: null,
          calories: null
        },
        isLoading: false
      }
    },
    methods: {
      updateLog() {
        if (this.checkRequired() == false)  
        {
          var that = this;
          this.isLoading = true;
          axios.post('/measurements', {
            measurement: this.measurement
          }).then(function(response) {
            that.$toast.open({
                      message: 'Log updated successfuly',
                      position: 'is-bottom',
                      type: 'is-success'
                  });
            that.$parent.close();
            that.originalMeasurement.weight = that.measurement.weight;
            that.originalMeasurement.bodyFat = that.measurement.bodyFat;
            that.originalMeasurement.calories = that.measurement.calories;
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