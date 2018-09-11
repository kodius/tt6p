<template>
  <layout>
    <div class="container">
      <div class="tile is-ancestor" v-if="plan">
        <div class="tile is-12 is-vertical is-parent">
          <article class="tile is-child notification is-transparent box">
            <div class="columns">
              <div class="column is-1"></div>
              <div class="column is-2 is-1by1 sui-avatar">
                <img id="profile-image" v-if="user" :src="user.avatar.url"/>
              </div>
              <div class="column">
                <p class="title">{{ plan.email }}</p>
                <b-field>
                  <p class="control"><button class="button small" @click="openChangeProfileModal()">Change profile image</button></p>
                  <p class="control"><button class="button small" @click="openEditPlanModal()">Change your plan</button></p>
                </b-field>
              </div>
            </div>
          </article>
        </div>
      </div>
    </div>
    <b-loading :is-full-page="true" :active.sync="isLoading" :can-cancel="false"></b-loading>
  </layout>
</template>

<script>
  import Layout from '../shared/layout';
  import editPlanModal from '../modals/edit_plan_modal'
  import changeAvatarModal from '../modals/change_avatar_modal'
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
      },
      openChangeProfileModal() {
        this.$modal.open({
            parent: this,
            component: changeAvatarModal,
            hasModalCard: true,
            props: {
              originalPlan: this.plan ? this.plan : null
            }
          });
      }
    }
  }
</script>