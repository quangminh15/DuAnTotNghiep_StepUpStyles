app.controller("totalproductrating-ctrl", function ($scope, $http) {
    $scope.chartData = {}
    $scope.monthss = [];
    var currentYear = new Date().getFullYear();
    $scope.years = [];
    for (var i = 2020; i <= currentYear; i++) {
        $scope.years.push(i);
    }

    for (var i = 1; i <= 12; i++) {
        $scope.monthss.push(i);
    }

    $scope.selectedYear = currentYear;

    // Khởi tạo biểu đồ
    var ctx = document.getElementById('area-chart').getContext('2d');
    var chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: []
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    stepSize: 1,
                    title: {
                        display: true,
                        text: 'Lượt đánh giá' // Nhãn trục y
                    }
                },
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            var label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                label += context.parsed.y + ' đánh giá';
                            }
                            return label;
                        },
                    }
                }
            },
        }
    });

    // Hàm cập nhật biểu đồ dựa trên năm được chọn
    $scope.updateChartData = function () {
        $http.get('/api/total-product-rating?year=' + $scope.selectedYear)
            .then(function (response) {
                $scope.chartData = response.data;

                // Lấy danh sách các tháng có đánh giá từ dữ liệu biểu đồ
            var ratedMonths = $scope.chartData.map(function (item) {
                return parseInt(item.month);
            });

            // Lọc và cập nhật danh sách các tháng có đánh giá vào select box
            $scope.ratedMonths = $scope.monthss.filter(function (month) {
                return ratedMonths.includes(month);
            });
            if ($scope.ratedMonths.length > 0) {
                $scope.selectedMonth = $scope.ratedMonths[0];
                $scope.getMonthDetails($scope.selectedMonth);
            }

                var labels = [];
                var datasets = [];

                var ratingColors = [
                    'rgba(255, 0, 0, 0.2)',   // Đỏ cho 1 sao
                    'rgba(0, 0, 255, 0.2)',   // Xanh cho 2 sao
                    'rgba(0, 255, 0, 0.2)',   // Xanh lá cho 3 sao
                    'rgba(255, 165, 0, 0.2)', // Cam cho 4 sao
                    'rgba(128, 0, 128, 0.2)'  // Tím cho 5 sao
                ];

                // Tạo labels và datasets dựa trên dữ liệu số sao và màu tương ứng
                ratingColors.forEach(function (color, index) {
                    var rating = (index + 1) + " sao";
                    labels.push(rating);
                    var dataByRating = $scope.chartData.map(function (item) {
                        return item.ratings[rating] || 0;
                    });
                    var dataset = {
                        label: rating,
                        data: dataByRating,
                        backgroundColor: color,
                        borderColor: color.replace('0.2', '1'), // Điều này là để chỉ định màu viền
                        borderWidth: 1,
                        fill: true,
                        tension: 0.4
                    };
                    datasets.push(dataset);
                });

                // Lấy tên tháng từ dữ liệu và chỉ hiển thị 12 tháng
                var monthLabels = $scope.chartData.map(function (item) {
                    return 'Tháng ' + item.month;
                }).slice(0, 12);

                // Cập nhật dữ liệu cho biểu đồ
                chart.data.labels = monthLabels;
                $scope.months = chart.data.labels.map(function (label) {
                    return parseInt(label.substring(6)); // Lấy ký tự từ vị trí thứ 6 trong chuỗi và chuyển về kiểu int
                });
                chart.data.datasets = datasets;
                chart.update();
            });
    }

    // Cập nhật biểu đồ ban đầu
    $scope.updateChartData();

    $scope.getMonthDetails = function (month) {
        $http.get(`/rest/reviews/month-year?month=${month}&year=${$scope.selectedYear}`)
            .then((res) => {
                $scope.monthYear = res.data;
            }).catch((err) => {

            });
        $scope.month = month
    };
});
