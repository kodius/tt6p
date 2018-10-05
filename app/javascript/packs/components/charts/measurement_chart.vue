<script>
import { Bar, Line, mixins } from 'vue-chartjs'

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['labels', 'datasets', 'loaded', 'label', 'backgroundColor', 'stepSize'],
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
        lineTension: 1,
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
            gridLines: {
              display: true
            },
          ticks: {
           beginAtZero: false,
           stepSize: this.stepSize 
          }
        }]
      }})
    }
  }
}
</script>
