
app.controller("product", function($scope, $http) {
  $scope.form = {};
  $scope.items = [];
    $scope.productOptions = [];
    
  $scope.products = []; // Lưu trữ dữ liệu từ API
  var myChart; // Biến lưu trữ biểu đồ

	$scope.loadall = function() {
    $http.get("http://localhost:8080/rest/OrderDetail/loadproduct")
    .then(resp => {
         $scope.productOptions = resp.data;
    })
    .catch(error => console.log("Error", error));
}
	$scope.loadall();


  $scope.find = function(name) {
    $http.get(`http://localhost:8080/rest/OrderDetail/findproduct/${name}`)
      .then(resp => {
        $scope.products = resp.data; // Gán dữ liệu từ API
        createChartForProducts();
      })
      .catch(error => console.log("Error", error));
  }

 

  function createChartForProducts() {
    const uniqueYears = [...new Set($scope.products.map(item => item[0]))];
    const uniqueMonths = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];

    const datasets = uniqueYears.map(year => {
      const dataValues = uniqueMonths.map((month, index) => {
        const matchingData = $scope.products.find(item => item[0] === year && item[1] === index + 1);
        return matchingData ? matchingData[4] : 0;
      });

      return {
        label: year,
        data: dataValues,
        backgroundColor: getRandomColor(),
        borderColor: getRandomColor(),
        borderWidth: 1
      };
    });

    const ctx = document.getElementById('productChart').getContext('2d');
    if (myChart) {
      myChart.destroy(); // Hủy bỏ biểu đồ cũ nếu tồn tại
    }
    myChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: uniqueMonths,
        datasets: datasets
      },
      options: {
        scales: {
          y: {
            beginAtZero: true,
             ticks: {
          callback: function (value, index, values) {
            return value.toLocaleString('en-US') + ' VND';
          }
        }
          }
        }
      }
    });
  }

  function getRandomColor() {
    const letters = '0123456789ABCDEF';
    let color = '#';
    for (let i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }
});