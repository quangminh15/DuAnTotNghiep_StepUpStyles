app.controller("totalproductrating-ctrl", function ($scope, $http) {
    $scope.chartData = {}
    var currentYear = new Date().getFullYear();
    $scope.years = [];
    for (var i = 2015; i <= currentYear; i++) {
        $scope.years.push(i);
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
            onClick: function (event, elements) {
                if (elements && elements.length > 0) {
                    var clickedElement = elements[0];
                    var monthIndex = clickedElement.index;
                    var selectedMonth = chart.data.labels[monthIndex];

                    console.log("click Month: ", clickedElement);
                    console.log(" Month index: ", monthIndex);
                    console.log("Selected Month: ", selectedMonth); // Log selected month

                    var selectedMonthData = $scope.chartData.find(function (data) {
                        return data.month === selectedMonth;
                    });

                    console.log("Selected Month Data: ", selectedMonthData); // Log selected month data

                    if (selectedMonthData) {
                        var productReviewsInSelectedMonth = selectedMonthData.productReviews;
                        console.log(productReviewsInSelectedMonth);
                    } else {
                        console.log("Không có dữ liệu cho tháng này");
                    }
                }
            }
        }
    });


    // Hàm cập nhật biểu đồ dựa trên năm được chọn
    $scope.updateChartData = function () {
        $http.get('/api/total-product-rating?year=' + $scope.selectedYear)
            .then(function (response) {
                $scope.chartData = response.data;
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
                chart.data.datasets = datasets;
                chart.update();
            });
    }

    // Cập nhật biểu đồ ban đầu
    $scope.updateChartData();

});
