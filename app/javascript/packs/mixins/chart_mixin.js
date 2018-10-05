import axios from 'axios';

var chartMixin = {
  data () {
    return {
      currentDimension: 'week',
      labels: [],
      datasets: [],
      targetCalories: []
    }
  },
  methods: {
    loadChartData() {
      var that = this;
      axios
      .post('chart-data', {
        dimension: that.currentDimension,
        id: that.$route.params.id,
        average_on: 'calories'
      })
      .then(response => {
        for (var idx in response.data[0]) {
          that.labels.push(that.currentDimension + ' ' + idx) 
          that.datasets.push(response.data[0][idx]) 
        }
        for (var idx in response.data[1]) {
          that.targetCalories.push(response.data[1][idx]) 
        }
      })
    }
  }
}

export default chartMixin;