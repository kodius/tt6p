<template>
  <div v-if="measurements.loaded">
    <br>
    <table class="table is-bordered is-striped is-fullwidth">
      <thead>
        <tr>
          <th>Date</th>
          <th>Weight</th>
          <th>Calories</th>
          <th>BF%</th>
          <th>LBM</th>
          <th>Status</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="measurement in measurements.data" v-bind:key="measurement.id">
          <td>{{ measurement.logDate }} </td>
          <td>{{ measurement.weight }} kg</td>
          <td>
            <span v-if="measurement.calories">
              {{ measurement.calories }} kcal
            </span>
            <span v-else>
              -
            </span>
          </td>
          <td>
            <span v-if="measurement.bodyFat">
              {{ measurement.bodyFat }}%
            </span>
            <span v-else>
              -
            </span>
          </td>
          <td>
            <span v-if="measurement.lbm">
              {{ measurement.lbm }} kg
            </span>
            <span v-else>
              -
            </span>
          </td>
          <td>
            <span v-if="measurement.success != false" class="icon has-text-success">
              <i class="fas fa-check-square"></i>
            </span>
            <span v-if="measurement.success == false" class="icon has-text-danger">
              <i class="fas fa-minus-square"></i>
            </span>
          </td>
          <td class="has-text-right">
            <a class="has-text-white" @click="imageModal(measurement.image)" v-if="measurement.image" href="javascript:void();"><i
                class="far fa-image"></i></a>
            <a class="has-text-white" @click="openEditModal(measurement)" href="javascript:void();">Edit</a>
            <a class="has-text-danger" @click="confirmDelete(measurement)" href="javascript:void();">Delete</a>
          </td>
        </tr>
      </tbody>
    </table>
    <div v-if="measurements.count > 20">
      <b-pagination :total="measurements.count" :current.sync="currentPage" :per-page="20" order="is-centered">
      </b-pagination>
    </div>
  </div>
</template>

<script>
  import editLogModal from '../modals/edit_log_modal';

  export default {
    data: function () {
      return {
          currentPage: 1
      }
    },
    methods: {
        openEditModal (measurement) {
            this.$modal.open({
                parent: this,
                component: editLogModal,
                hasModalCard: true,
                props: {
                originalMeasurement: measurement
                }
            })
        },
        confirmDelete(measurement) {
            this.$dialog.confirm({
                title: 'Confirm',
                message: `Are you sure you want to <strong>delete</strong> ${measurement.logDate} log? This action can't be undone!`,
                confirmText: `Delete`,
                type: 'is-danger',
                hasIcon: true,
                onConfirm: () => this.performDelete(measurement.id)
            })
        },
        performDelete(id) {
            var that = this;
            axios
                .delete('measurements/' + id)
                .then(response => {
                    this.loadMeasurements();
                    that.$toast.open({
                    message: 'Log successfuly deleted',
                    duration: 5000
                    })
            })
        },
        imageModal(url) {
            this.$modal.open(
                `<p class="image">
                    <img src="${url}">
                </p>`
            )
        },
        loadMeasurements() {
           this.$store.dispatch('currentUser/loadMeasurements', { page: this.currentPage })
        }
    },
    computed: {
      measurements() {
        return this.$store.state.currentUser.measurements
      }
    },
    mounted () {
        this.$store.dispatch('currentUser/loadMeasurements', { page: this.currentPage })
    },
    watch: {
        currentPage: function (newCurrentPage, oldCurrentPage) {
            this.$store.dispatch('currentUser/loadMeasurements', { page: newCurrentPage })
        }
    }
  }

</script>
