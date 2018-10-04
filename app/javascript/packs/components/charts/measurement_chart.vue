<script>
import { Bar, mixins } from 'vue-chartjs'

export default {
  extends: Bar,
  mixins: [mixins.reactiveProp],
  props: ['labels', 'datasets', 'loaded', 'label', 'backgroundColor'],
  mounted () {
    if (this.labels && this.datasets) {
      this.renderChart({
        labels: this.labels,
        datasets: [{
          label: this.label,
          backgroundColor: this.backgroundColor,
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
