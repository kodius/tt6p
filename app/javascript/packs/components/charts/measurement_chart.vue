<script>
import { Bar, Line, mixins } from 'vue-chartjs'

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['labels', 'datasets', 'loaded', 'label', 'backgroundColor', 'stepSize', 'label1', 'datasets1', 'backgroundColor1'],
  mounted () {
    if (this.labels && this.datasets) {
      this.renderChart({
        labels: this.labels,
        datasets: [{
          label: this.label1,
          backgroundColor: this.backgroundColor1,
          data: this.datasets1
        },{
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
           stepSize: this.stepSize,
           padding: 25
          }
        }]
      }})
    }
  }
}
</script>
