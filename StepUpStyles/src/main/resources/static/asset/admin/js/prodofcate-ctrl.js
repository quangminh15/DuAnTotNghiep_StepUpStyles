app.controller("prodofcate-ctrl", function ($scope, $http, $interval) {
    // Khởi tạo mảng dữ liệu ban đầu (trống)
    $scope.productData = [];

    // Hàm để cập nhật dữ liệu và vẽ lại biểu đồ
    function updateChart() {
        $http.get("/sql-category-product-count").then(function (response) {
            // Dữ liệu trả về từ câu truy vấn SQL
            var dataFromSql = response.data;

            // Cấu trúc lại dữ liệu thành dạng phù hợp cho biểu đồ Polar Chart
            $scope.productData = {
                datasets: [{
                    data: dataFromSql.map(function (category) {
                        return category.productCount;
                    }),
                    backgroundColor: ["red", "blue", "green", "orange", "purple"],
                    label: 'Số lượng sản phẩm'
                }],
                labels: dataFromSql.map(function (category) {
                    return category.categoryName;
                })
            };

            // Lấy thẻ canvas để vẽ biểu đồ
            var ctx = document.getElementById("polar-chart").getContext("2d");

            // Vẽ lại biểu đồ Polar Chart
            if ($scope.myPolarChart) {
                // Nếu biểu đồ đã tồn tại, hủy nó trước khi vẽ lại
                $scope.myPolarChart.destroy();
            }
            $scope.myPolarChart = new Chart(ctx, {
                type: 'polarArea',
                data: $scope.productData,
                options: {
                    responsive: false
                }
            });
        });
    }

    // Gọi hàm updateChart ban đầu
    updateChart();

    // Định kỳ gọi hàm updateChart mỗi 5 phút
    $interval(updateChart, 300000); // 300000 milliseconds = 5 minutes
});
