<script>
import { Bar, mixins } from 'vue-chartjs'

export default {
  extends: Bar,
  mixins: [mixins.reactiveProp],
  props: ['measurements', 'loaded'],
  computed: {
    'chartData': function () {
      return {
        labels: this.measurements.slice(-7).map(measurement => measurement.logDate),
        datasets: this.measurements.slice(-7).map(measurement => Math.trunc(measurement.calories))
      }
    }
  },
  mounted () {
    if (this.chartData) {
      this.renderChart({
        labels: this.chartData.labels,
        datasets: [{
          label: 'Calories blabla',
          backgroundColor: '#f87979',
          data: [this.chartData.datasets]
        }],
        },
      {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
            gridLines: {
              display: true
            },
          ticks: {
           min: 0,
           max: 500 * Math.ceil(Math.max.apply(null, this.chartData.datasets) / 500)
          }
        }]
      }})
    }
  }
}
</script>
