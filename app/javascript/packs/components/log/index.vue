<template>
  <layout>
    <div class="notification" v-if="step == 0">
      <div class="columns">
        <div class="column is-half">
          <span v-if="errors.date" class="help is-danger">{{ errors.date }}</span>
          <b-field
                  :type="errors.date ? 'is-danger' : ''">
              <b-datepicker
                  placeholder="Select date"
                  v-model="measurement.logDate"
                  @focus="errors.date = null"
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
     <div class="notification" v-if="step == 1">
      <div class="columns">
        <div class="column is-half">
          <b-field>
            <b-upload v-model="dropFiles"
              drag-drop
              @input="imageSelected">
              <section class="section">
                <div class="content has-text-centered">
                  <p>
                    <b-icon
                      icon="upload"
                      size="is-large">
                    </b-icon>
                  </p>
                  <p>Drop your files here or click to upload</p>
                </div>
              </section>
            </b-upload>
          </b-field>
          <span>Upload your current image or go </span><router-link :to="{ name: 'dashboard_path' }" class="">back to dashboard</router-link>
        </div>
      </div>
     </div>
     <b-loading :is-full-page="true" :active.sync="isLoading" :can-cancel="false"></b-loading>
   </layout>
</template>

<script>
import Layout from '../shared/layout';
import axios from 'axios';
import editImageModal from '../modals/edit_image_modal'


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
      step: 0,
      dropFiles: [],
      imageSrc: null,
      isLoading: false
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
        var that = this;
        this.isLoading = true;
        axios.post('/measurements', {
           measurement: this.measurement
        }).then(function(response) {
          that.$toast.open({
                    message: 'Log saved successfuly',
                    position: 'is-bottom',
                    type: 'is-success'
                });
          that.step = 1;
          that.isLoading = false;
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
    },
    imageSelected(){
      var file    = this.dropFiles[0] //sames as here
      var reader  = new FileReader();
      var that = this;

      reader.onloadend = function () {
        that.imageSrc = reader.result;
        that.$modal.open({
          parent: that,
          component: editImageModal,
          hasModalCard: true,
          props: {
            originalImage: that.imageSrc,
            measurement: that.measurement,
            file: file
          }
        });
      }

      if (file) {
        reader.readAsDataURL(file); //reads the data as a URL
      } else {
        this.imageSrc = null;
      }
  }
  }
}
</script>
