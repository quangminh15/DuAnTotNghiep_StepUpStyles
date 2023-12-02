app.controller("prodofcate-ctrl", function($scope, $http) {
	// Khởi tạo mảng dữ liệu ban đầu (trống)
	$scope.products = [];
	$scope.categories = [];
	$scope.brands = [];

	$scope.selectedCategory = '';
	$scope.selectedBrand = '';
	$scope.filteredProducts = [];
	$scope.filteredProductsBrand = [];

	//	Phân trang danh mục bắt đầu
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
	//	Phân trang danh mục kết thúc

	//	Phân trang thương hiệu bắt đầu
	$scope.RestorePager = {
		page: 0,
		size: 7,
		getRestorePageNumbers: function() {
			var RestorePageCount = this.count;
			var RestoreCurrentPage = this.page + 1;
			var RestoreVisiblePages = [];

			if (RestorePageCount <= 3) {
				for (var i = 1; i <= RestorePageCount; i++) {
					RestoreVisiblePages.push({ value: i });
				}
			} else {
				if (RestoreCurrentPage <= 2) {
					RestoreVisiblePages.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
				} else if (RestoreCurrentPage >= RestorePageCount - 1) {
					RestoreVisiblePages.push({ value: '...' }, { value: RestorePageCount - 2 }, { value: RestorePageCount - 1 }, { value: RestorePageCount });
				} else {
					RestoreVisiblePages.push({ value: '...' }, { value: RestoreCurrentPage - 1 }, { value: RestoreCurrentPage }, { value: RestoreCurrentPage + 1 }, { value: '...' });
				}
			}
			return RestoreVisiblePages;
		},
		get filteredProductsBrand() {
			var start = this.page * this.size;
			return $scope.filteredProductsBrand.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.filteredProductsBrand.length / this.size);
		},
		first() {
			this.page = 0;
			$scope.RestoreVisiblePages = this.getRestorePageNumbers();
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
			$scope.RestoreVisiblePages = this.getRestorePageNumbers();
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
			$scope.RestoreVisiblePages = this.getRestorePageNumbers();
		},
		last() {
			this.page = this.count - 1;
			$scope.RestoreVisiblePages = this.getRestorePageNumbers();
		},
		RestoreGoto(RestorePageNumber) {
			if (RestorePageNumber >= 1 && RestorePageNumber <= this.count) {
				this.page = RestorePageNumber - 1;
				$scope.RestoreVisiblePages = this.getRestorePageNumbers();
			}
		},
	};
	//	Phân trang thương hiệu kết thúc

	// Hàm khởi đầu
	function init() {
		$http.get("/rest/categories/loadall").then(function(response) {
			$scope.categories = response.data;
			if ($scope.categories.length > 0) {
				$scope.selectedCategory = $scope.categories[0].categoryID;
				$scope.loadProductsByCategory();
			}
			$scope.pager.first();
		});

		$http.get("/rest/brands/loadall").then(function(response) {
			$scope.brands = response.data;
			if ($scope.brands.length > 0) {
				$scope.selectedBrand = $scope.brands[0].brandID;
				$scope.loadProductsByBrand();
			}
			$scope.pager.first();
		});

		// Gọi API để lấy dữ liệu cho biểu đồ danh mục bắt đầu
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
		// Gọi API để lấy dữ liệu cho biểu đồ danh mục kết thúc
		
		// Gọi API để lấy dữ liệu cho biểu đồ thương hiệu bắt đầu
		$http.get("/api/brand-product-count").then(function(response) {
			var dataFromApiBrand = response.data;
			console.log(dataFromApiBrand, "đây là data từ api dataFromApiBrand");

			// Cấu trúc lại dữ liệu thành dạng phù hợp cho biểu đồ Polar Chart
			$scope.productData = dataFromApiBrand;

			// Cấu hình biểu đồ
			var options = {
				responsive: true,
			};

			// Lấy thẻ canvas để vẽ biểu đồ
			var ctx = document.getElementById("polar-chart-Brand").getContext("2d");

			// Vẽ biểu đồ Polar Chart
			var myPolarChartBrand = new Chart(ctx, {
				type: "polarArea",
				data: {
					datasets: [
						{
							data: dataFromApiBrand.map(function(brand) {
								return brand.productCount;
							}),
							backgroundColor: ["red", "blue", "green", "orange", "purple"],
							label: "Số lượng sản phẩm",
						},
					],
					labels: dataFromApiBrand.map(function(brand) {
						return brand.brandName;
					}),
				},
				options: options,
			});
		});
		// Gọi API để lấy dữ liệu cho biểu đồ danh mục kết thúc
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
	
	$scope.loadProductsByBrand = function() {
		console.log("Calling loadProductsByBrand");
		$http
			.get(
				"/rest/productdetails/byBrand/" +
				$scope.selectedBrand +
				"?page=" +
				$scope.RestorePager.page +
				"&size=" +
				$scope.RestorePager.size
			)
			.then(function(response) {
				// Kiểm tra xem dữ liệu từ API có hợp lệ không
				if (Array.isArray(response.data) && response.data.length > 0) {
					$scope.filteredProductsBrand = response.data;
				} else {
					$scope.filteredProductsBrand = [];
				}
				$scope.RestorePager.first();
			})
			.catch(function(error) {
				console.error("Error loading products:", error);
			});
	};


	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})
});
