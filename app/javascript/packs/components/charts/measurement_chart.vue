<script>
import { Bar, mixins } from 'vue-chartjs'

export default {
  extends: Bar,
  mixins: [mixins.reactiveProp],
  props: ['labels', 'datasets', 'loaded', 'chartData'],
  computed: {
    chartData: function () {
      return {
        labels: this.labels,
        datasets: this.datasets
      }
    }
  },
  mounted () {

    if (this.chartData) {
      this.renderChart({
        labels: this.labels,
        datasets: [{
          label: 'Calories blabla',
          backgroundColor: '#f87979',
          data: this.datasets
        }],
      }, {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
            gridLines: {
              display: true
            },
          ticks: {
           min: 0,
           max: 500 * Math.ceil(Math.max.apply(null, this.datasets) / 500)
          }
        }]
      }})
    }
  }
}
</script>
