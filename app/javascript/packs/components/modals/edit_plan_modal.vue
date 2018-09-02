<template>
  <div class="modal-card">
    <header class="modal-card-head">
      <p class="modal-card-title">Enter your plan</p>
    </header>
    <section class="modal-card-body">
        <span v-if="errors.weight !== null" class="help is-danger">{{ errors.weight }}</span>
        <b-field
            :type="errors.weight ? 'is-danger' : ''">
          <b-input
              placeholder="Weight"
              v-model="plan.weight"
              @focus="errors.weight = null"
              expanded>
          </b-input>
          <p class="control">
            <span class="button is-static">kg</span>
          </p>
        </b-field>
        <span v-if="errors.body_fat !== null" class="help is-danger">{{ errors.body_fat }}</span>
        <b-field
            :type="errors.body_fat ? 'is-danger' : ''">
          <b-input
              placeholder="Body fat"
              v-model="plan.body_fat"
              @focus="errors.body_fat = null"
              expanded>
          </b-input>
          <p class="control">
            <span class="button is-static">%</span>
          </p>
        </b-field>
        <span v-if="errors.target_fat !== null" class="help is-danger">{{ errors.target_fat }}</span>
        <b-field
            :type="errors.target_fat ? 'is-danger' : ''">
          <b-input
              placeholder="Target body fat"
              v-model="plan.target_body_fat"
              @focus="errors.target_fat = null"
              expanded>
          </b-input>
          <p class="control">
            <span class="button is-static">%</span>
          </p>
        </b-field>
        <span v-if="errors.height !== null" class="help is-danger">{{ errors.height }}</span>
        <b-field
            :type="errors.height ? 'is-danger' : ''">
          <b-input
              placeholder="Height"
              v-model="plan.height"
              @focus="errors.height = null"
              expanded>
          </b-input>
          <p class="control">
            <span class="button is-static">cm</span>
          </p>
        </b-field>
        <span v-if="errors.age !== null" class="help is-danger">{{ errors.age }}</span>
        <b-field
          :type="errors.age ? 'is-danger' : ''">
          <b-input
            placeholder="Age"
            v-model="plan.age"
            @focus="errors.age = null"
            expanded>
          </b-input>
          <p class="control">
            <span class="button is-static">Years</span>
          </p>
        </b-field>
        <span v-if="errors.gender !== null" class="help is-danger">{{ errors.gender }}</span>
        <b-field
          :type="errors.age ? 'is-danger' : ''">
          <b-select 
            placeholder="Gender"
            v-model="plan.gender"
            @focus="errors.gender = null"
            expanded>
            <option value="man">Male</option>
            <option value="woman">Female</option>
          </b-select>
        </b-field>
        <span v-if="errors.activity !== null" class="help is-danger">{{ errors.activity }}</span>
        <b-field
          :type="errors.activity ? 'is-danger' : ''">
          <b-select 
            placeholder="Activity"
            v-model="plan.activity_level"
            @focus="errors.activity = null"
            expanded>
            <option value="sedentary">Sedentary</option>
            <option value="lightly_active">Lightly Active</option>
            <option value="moderatly_active">Moderatly Active</option>
            <option value="very_active">Very Active</option>
            <option value="extremely_active">Extremely Active</option>
          </b-select>
        </b-field>
    </section>
    <footer class="modal-card-foot">
      <button class="button is-primary" @click="updatePlan()">
        Submit
      </button>
      <button class="button" @click="$parent.close()">
        Cancel
      </button>
    </footer>
    <b-loading :is-full-page="false" :active.sync="isLoading" :can-cancel="false"></b-loading>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    props: ['originalPlan'],
    data: function () {
      return {
        errors: {
          weight: null,
          body_fat: null,
          target_fat: null,
          height: null,
          age: null,
          gender: null,
          activity: null
        },
        plan: {
          weight: this.originalPlan ? this.originalPlan.weight : null,
          body_fat: this.originalPlan ? this.originalPlan.bodyFat : null,
          target_body_fat: this.originalPlan ? this.originalPlan.targetBodyFat : null,
          height: this.originalPlan ? this.originalPlan.height : null,
          age: this.originalPlan ? this.originalPlan.age : null,
          gender: this.originalPlan ? this.originalPlan.gender : null,
          activity_level: this.originalPlan ? this.originalPlan.activityLevel : null
        },
        isLoading: false
      }
    },
    methods: {
      updatePlan() {
        var that = this;
        this.isLoading = true;
        
        axios
          .post('update-plan', {
            plan: this.plan
          }).then(response => {
            that.$parent.close();
            that.isLoading = false;
            that.$toast.open({
              message: 'Plan successfuly updated',
              duration: 5000,
              position: 'is-bottom',
              type: 'is-success'
            })
          });
      }
    }
  }
</script>