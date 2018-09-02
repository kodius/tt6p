<template>
  <layout>
    <div class="has-text-centered" style="margin-top: 18px">
      <img id="profile-image" v-if="user" :src="user.avatar.url"
            style="border-radius: 50%"/>
      <br/>
    </div>
    <b-field style="float: right;">
      <p class="control"><button class="button small">Change profile image</button></p>
      <p class="control"><button class="button small" @click="openEditPlanModal()">Change your plan</button></p>
    </b-field>
    <b-loading :is-full-page="true" :active.sync="isLoading" :can-cancel="false"></b-loading>
  </layout>
</template>

<script>
  import Layout from '../shared/layout';
  import editPlanModal from '../modals/edit_plan_modal'
  import axios from 'axios'

  export default {
    components: {
      Layout
    },
    data: function () {
      return {
        user: null,
        toLoad: 2,
        plan: null
      }
    },
    computed: {
      isLoading() {
        this.toLoad === 0 ? false : true
      }
    },
    mounted() {
      var that = this;

      axios.get('my-profile').then(response => {
        that.user = response.data.user;
        that.toLoad--;
        console.warn(response);
      });
      axios.get('my-plan').then(response => {
        that.toLoad--;

        if (response.data.noplan) {
          that.openEditPlanModal();
        } else {
          that.plan = response.data.plan;
        }
      });
    },
    methods: {
      openEditPlanModal() {
        this.$modal.open({
            parent: this,
            component: editPlanModal,
            hasModalCard: true,
            props: {
              originalPlan: this.plan ? this.plan : null
            }
          });
      }
    }
  }
</script>