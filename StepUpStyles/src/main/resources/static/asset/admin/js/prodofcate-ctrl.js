app.controller("prodofcate-ctrl", function($scope, $http) {
	// Khởi tạo mảng dữ liệu ban đầu (trống)
	$scope.products = [];
	$scope.categories = [];

	$scope.selectedCategory = '';
	$scope.filteredProducts = [];

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 7,
		getPageNumbers: function() {
			var pageCount = this.count;
			var currentPage = this.page + 1;
			var visiblePages = [];

			if (pageCount <= 3) {
				for (var i = 1; i <= pageCount; i++) {
					visiblePages.push({ value: i });
				}
			} else {
				if (currentPage <= 2) {
					visiblePages.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
				} else if (currentPage >= pageCount - 1) {
					visiblePages.push({ value: '...' }, { value: pageCount - 2 }, { value: pageCount - 1 }, { value: pageCount });
				} else {
					visiblePages.push({ value: '...' }, { value: currentPage - 1 }, { value: currentPage }, { value: currentPage + 1 }, { value: '...' });
				}
			}
			return visiblePages;
		},
		get filteredProducts() {
			var start = this.page * this.size;
			return $scope.filteredProducts.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.filteredProducts.length / this.size);
		},
		first() {
			this.page = 0;
			$scope.visiblePages = this.getPageNumbers();
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
			$scope.visiblePages = this.getPageNumbers();
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
			$scope.visiblePages = this.getPageNumbers();
		},
		last() {
			this.page = this.count - 1;
			$scope.visiblePages = this.getPageNumbers();
		},
		goto(pageNumber) {
			if (pageNumber >= 1 && pageNumber <= this.count) {
				this.page = pageNumber - 1;
				$scope.visiblePages = this.getPageNumbers();
			}
		},
	};

	// Hàm khởi đầu
	function init() {
		$http.get("/rest/categories/loadall").then(function(response) {
			$scope.categories = response.data;

			// Chọn danh mục đầu tiên nếu có ít nhất một danh mục
			if ($scope.categories.length > 0) {
				$scope.selectedCategory = $scope.categories[0].categoryID;
				$scope.loadProductsByCategory(); // Load sản phẩm theo danh mục đầu tiên
			}

			$scope.pager.first();
		});

		// Gọi API để lấy dữ liệu cho biểu đồ
		$http.get("/api/category-product-count").then(function(response) {
			var dataFromApi = response.data;
			console.log(dataFromApi, "đây là data từ api");

			// Cấu trúc lại dữ liệu thành dạng phù hợp cho biểu đồ Polar Chart
			$scope.productData = dataFromApi;

			// Cấu hình biểu đồ
			var options = {
				responsive: true,
			};

			// Lấy thẻ canvas để vẽ biểu đồ
			var ctx = document.getElementById("polar-chart").getContext("2d");

			// Vẽ biểu đồ Polar Chart
			var myPolarChart = new Chart(ctx, {
				type: "polarArea",
				data: {
					datasets: [
						{
							data: dataFromApi.map(function(category) {
								return category.productCount;
							}),
							backgroundColor: ["red", "blue", "green", "orange", "purple"],
							label: "Số lượng sản phẩm",
						},
					],
					labels: dataFromApi.map(function(category) {
						return category.categoryName;
					}),
				},
				options: options,
			});
		});
	}

	// Gọi hàm khởi đầu
	init();

	$scope.loadProductsByCategory = function() {
		console.log("Calling loadProductsByCategory");
		$http
			.get(
				"/rest/productdetails/byCategory/" +
				$scope.selectedCategory +
				"?page=" +
				$scope.pager.page +
				"&size=" +
				$scope.pager.size
			)
			.then(function(response) {
				// Kiểm tra xem dữ liệu từ API có hợp lệ không
				if (Array.isArray(response.data) && response.data.length > 0) {
					$scope.filteredProducts = response.data;
				} else {
					$scope.filteredProducts = []; // Gán một mảng rỗng nếu dữ liệu không hợp lệ
				}
				$scope.pager.first();
			})
			.catch(function(error) {
				console.error("Error loading products:", error);
			});
	};


	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})
});
