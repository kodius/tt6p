<script>
import { Bar, Line, mixins } from 'vue-chartjs'

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ['labels', 'datasets', 'loaded', 'label','stepSize', 'label1', 'datasets1'],
  mounted () {
    this.gradient = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)
    this.gradient2 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)

    this.gradient2.addColorStop(0, 'rgba(0, 231, 255, 0.9)')
    this.gradient2.addColorStop(0.5, 'rgba(0, 231, 255, 0.25)');
    this.gradient2.addColorStop(1, 'rgba(0, 231, 255, 0)');

    this.gradient.addColorStop(0, 'rgba(255, 0,0, 0.5)')
    this.gradient.addColorStop(0.5, 'rgba(255, 0, 0, 0.25)');
    this.gradient.addColorStop(1, 'rgba(255, 0, 0, 0)');


    if (this.labels && this.datasets) {
      this.renderChart({
        labels: this.labels,
        datasets: [{
          label: this.label1,
          borderColor: '#FC2525',
          pointBackgroundColor: 'white',
          borderWidth: 1,
          pointBorderColor: 'white',
          backgroundColor: this.gradient,
          data: this.datasets1
        },{
          label: this.label,
          borderColor: '#05CBE1',
          pointBackgroundColor: 'white',
          pointBorderColor: 'white',
          borderWidth: 1,
          backgroundColor: this.gradient2,
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
