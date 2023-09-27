app.controller("totalproductrating-ctrl", function($scope, $http) {

	var myPolarChart;
	// Khởi tạo mảng dữ liệu ban đầu (trống)
	var currentYear = new Date().getFullYear();

    // Tạo một mảng các năm từ năm hiện tại đến năm cụ thể (ví dụ: 2030)
    $scope.years = [];
    for (var i = 2015; i <= currentYear; i++) {
        $scope.years.push(i);
    }
    $scope.months = [];
    for (var i = 1; i <= 12; i++) {
        $scope.months.push(i);
    }

	function updateChart() {
		// Kiểm tra xem biểu đồ đã được khởi tạo chưa
		if (myPolarChart) {
			myPolarChart.destroy(); // Hủy biểu đồ hiện tại
		}
	
		// Gọi hàm vẽ biểu đồ lại với các giá trị mới
		drawChart();
	}
	//	Phân trang
	// $scope.pager = {
	// 	page: 0,
	// 	size: 10,
	// 	getPageNumbers: function() {
	// 		var pageCount = this.count;
	// 		var currentPage = this.page + 1;
	// 		var visiblePages = [];

	// 		if (pageCount <= 3) {
	// 			for (var i = 1; i <= pageCount; i++) {
	// 				visiblePages.push({ value: i });
	// 			}
	// 		} else {
	// 			if (currentPage <= 2) {
	// 				visiblePages.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
	// 			} else if (currentPage >= pageCount - 1) {
	// 				visiblePages.push({ value: '...' }, { value: pageCount - 2 }, { value: pageCount - 1 }, { value: pageCount });
	// 			} else {
	// 				visiblePages.push({ value: '...' }, { value: currentPage - 1 }, { value: currentPage }, { value: currentPage + 1 }, { value: '...' });
	// 			}
	// 		}
	// 		return visiblePages;
	// 	},
	// 	get filteredProducts() {
	// 		var start = this.page * this.size;
	// 		return $scope.filteredProducts.slice(start, start + this.size);
	// 	},
	// 	get count() {
	// 		return Math.ceil(1.0 * $scope.filteredProducts.length / this.size);
	// 	},
	// 	first() {
	// 		this.page = 0;
	// 		$scope.visiblePages = this.getPageNumbers();
	// 	},
	// 	prev() {
	// 		this.page--;
	// 		if (this.page < 0) {
	// 			this.last();
	// 		}
	// 		$scope.visiblePages = this.getPageNumbers();
	// 	},
	// 	next() {
	// 		this.page++;
	// 		if (this.page >= this.count) {
	// 			this.first();
	// 		}
	// 		$scope.visiblePages = this.getPageNumbers();
	// 	},
	// 	last() {
	// 		this.page = this.count - 1;
	// 		$scope.visiblePages = this.getPageNumbers();
	// 	},
	// 	goto(pageNumber) {
	// 		if (pageNumber >= 1 && pageNumber <= this.count) {
	// 			this.page = pageNumber - 1;
	// 			$scope.visiblePages = this.getPageNumbers();
	// 		}
	// 	},
	// };

	// Hàm khởi đầu
	function init() {
		var currentDate = new Date();
        $scope.month = currentDate.getMonth() + 1; // Lấy tháng (từ 0 đến 11, nên cộng thêm 1)
        $scope.year = currentDate.getFullYear();
		// Gọi API để lấy danh sách tất cả các danh mục
		// $http.get("/rest/categories/loadall").then(function(response) {
		// 	$scope.categories = response.data;
		// 	$scope.RestorePager.first();
		// 	$scope.loadProductsByCategory();

		// });
		updateChart();
		$scope.$watchGroup(['year', 'month'], function(newValues, oldValues) {
			// Gọi hàm vẽ biểu đồ lại khi có thay đổi giá trị
			drawChart();
		});
	}

	// Gọi hàm khởi đầu
	init();

	// Hàm để load sản phẩm dựa trên danh mục đã chọn
	// $scope.loadProductsByCategory = function() {
	// 	// Gọi API để lấy danh sách sản phẩm dựa trên danh mục đã chọn và trang hiện tại
	// 	$http
	// 		.get(
	// 			"/rest/productdetails/byCategory/" +
	// 			$scope.selectedCategory +
	// 			"?page=" +
	// 			$scope.pager.page +
	// 			"&size=" +
	// 			$scope.pager.size
	// 		)
	// 		.then(function(response) {
	// 			$scope.filteredProducts = response.data;
	// 		});
	// };

	function drawChart() {
		// Gọi API để lấy dữ liệu cho biểu đồ
		$http.get("/api/total-product-rating?month=" + $scope.month + "&year=" + $scope.year).then(function(response) {
			// Dữ liệu trả về từ API
			var dataFromApi = response.data;
			console.log(dataFromApi, "đây là data từ api của linh");
	
			// Cấu trúc lại dữ liệu thành dạng phù hợp cho biểu đồ Polar Chart
			$scope.productData = dataFromApi;
	
			// Cấu hình biểu đồ
			var options = {
				responsive: true,
			};
	
			// Nếu biểu đồ đã được khởi tạo, chỉ cập nhật dữ liệu và cấu hình
			if (myPolarChart) {
				myPolarChart.data.datasets[0].data = dataFromApi.map(function(rv) {
					return rv.productCount;
				});
				myPolarChart.data.labels = dataFromApi.map(function(rv) {
					return rv.rating + " sao";
				});
				myPolarChart.update(); // Cập nhật biểu đồ
			} else {
				// Nếu biểu đồ chưa được khởi tạo, tạo một biểu đồ mới
				var ctx = document.getElementById("polar-chart").getContext("2d");
				myPolarChart = new Chart(ctx, {
					type: "polarArea",
					data: {
						datasets: [
							{
								data: dataFromApi.map(function(rv) {
									return rv.productCount;
								}),
								backgroundColor: ["red", "blue", "green", "orange", "purple"],
								label: "Số lượng sản phẩm",
							},
						],
						labels: dataFromApi.map(function(rv) {
							return rv.rating + " sao";
						}),
					},
					options: options,
				});
			}
		});
	}
	
});
