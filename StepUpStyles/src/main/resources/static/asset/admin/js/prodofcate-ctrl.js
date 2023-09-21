app.controller("prodofcate-ctrl", function($scope, $http) {
    // Khởi tạo mảng dữ liệu ban đầu (trống)
    $scope.productData = [];

    // Gọi API để lấy dữ liệu từ máy chủ
    $http.get("/api/category-product-count").then(function(response) {
        // Dữ liệu trả về từ API
        var dataFromApi = response.data;

        // Cấu trúc lại dữ liệu thành dạng phù hợp cho biểu đồ Polar Chart
        $scope.productData = {
            datasets: [{
                data: dataFromApi.map(function(category) {
                    return category.productCount;
                }),
                backgroundColor: ["red", "blue", "green", "orange", "purple"],
                label: 'Số lượng sản phẩm'
            }],
            labels: dataFromApi.map(function(category) {
                return category.categoryName;
            })
        };

        // Cấu hình biểu đồ
        var options = {
            responsive: false
        };

        // Lấy thẻ canvas để vẽ biểu đồ
        var ctx = document.getElementById("polar-chart").getContext("2d");

        // Vẽ biểu đồ Polar Chart
        var myPolarChart = new Chart(ctx, {
            type: 'polarArea',
            data: $scope.productData,
            options: options
        });
    });
});
