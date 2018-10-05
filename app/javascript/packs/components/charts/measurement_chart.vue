<script>
import { Bar, Line, mixins } from 'vue-chartjs'

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['labels', 'datasets', 'loaded', 'label', 'backgroundColor', 'ticksAmount'],
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
           min: this.ticksAmount * (Math.ceil(Math.min.apply(null, this.datasets) * 0.95)  / this.ticksAmount),
           max: this.ticksAmount * Math.ceil(Math.max.apply(null, this.datasets) / this.ticksAmount)
          }
        }]
      }})
    }
  }
}
</script>
