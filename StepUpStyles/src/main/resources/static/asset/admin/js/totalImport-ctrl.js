app.controller("totalImport-ctrl", function($scope, $http) {

    var currentYear = new Date().getFullYear();
    $scope.years = [];
    for (var i = 2023; i <= currentYear; i++) {
        $scope.years.push(i);
    }

    $scope.months = [];
    for (var i = 1; i <= 12; i++) {
        $scope.months.push(i);
    }

    $scope.selectedYear = currentYear;
    $scope.selectedMonth = new Date().getMonth() + 1;
    // $scope.selectedMonth = 9;

    // Khởi tạo biểu đồ
    var ctx = document.getElementById('column-chart').getContext('2d');
    var chart = new Chart(ctx, {
        type: 'bar',  // Thay đổi type thành 'bar' cho biểu đồ cột
        data: {
            labels: [],
            datasets: []
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true   
                    
                }
            }
        }
    });

    function getRandomColor() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }

    // Hàm cập nhật biểu đồ dựa trên năm được chọn
    $scope.updateChartData = function () {
        $http.get('rest/importReceipt/productQuantity?month=' + $scope.selectedMonth + '&year=' + $scope.selectedYear)
        .then(function (response) {
            var data = response.data;
            console.log(data);

            var productNames = data.map(function (item) {
                return item.productName;
            });

            var productQuantities = data.map(function (item) {
                return item.totalQuantity; // Giả sử dữ liệu của bạn có thuộc tính 'quantity'
            });
            console.log(productQuantities)

            var dataset = {
                label: 'Số lượng',
                data: productQuantities,
                backgroundColor: getRandomColor(),
                borderColor: getRandomColor(),
                borderWidth: 1
            };

            chart.data.labels = productNames;
            chart.data.datasets = [dataset]; // Sử dụng một mảng cho datasets
            chart.options.scales = {
                y: {
                    beginAtZero: true,
                    suggestedMax: Math.max.apply(Math, productQuantities) + 1
                }
            };
            
            chart.update();
        });
    };

    // Cập nhật biểu đồ ban đầu
    $scope.updateChartData();

});
