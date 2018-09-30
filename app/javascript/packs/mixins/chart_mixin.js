import axios from 'axios';

var chartMixin = {
  data () {
    return {
      currentDimension: 'week',
      labels: [],
      datasets: []
    }
  },
  methods: {
    loadChartData() {
      var that = this;
      axios
      .post('chart-data', {
        dimension: that.currentDimension,
        id: that.$route.params.id
      })
      .then(response => {
        for (var idx in response.data) {
          that.labels.push(that.currentDimension + ' ' + idx) // week/month/year
          that.datasets.push(response.data[idx]) // calories
        }
      })
    }
  }
}

export default chartMixin;