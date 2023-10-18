app.controller("favorite-ctrl", function($scope, $http) {
	// quangminh bắt đầu
	$scope.productitems = [];

	$scope.initialize = function() {
		//load product
		$http.get("/rest/products/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.productitems = resp.data;
			$scope.pager.first();
		});

		//load category
		$http.get("/rest/categories/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.cates = resp.data;
			$scope.pager.first();
		});

		//load brand
		$http.get("/rest/brands/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.brans = resp.data;
			$scope.pager.first();
		});

		//load color
		$http.get("/rest/colors/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.colors = resp.data;
			$scope.pager.first();
		});

		//load size
		$http.get("/rest/sizes/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.sizes = resp.data;
			$scope.pager.first();
		});

		//load image
		$http.get("/rest/productimages/loadall").then(resp => {
			$scope.images = resp.data;
			console.log($scope.images)
			$scope.pager.first();
		});
	}

	//	Khởi đầu
	$scope.initialize();

	//phân trang
	$scope.pager = {
		page: 0,
		size: 9,
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
		get productitems() {
			var start = this.page * this.size;
			return $scope.productitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productitems.length / this.size);
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

	$scope.goToSinglePage = function(productID) {
		window.location.href = `/single_product/${productID}`; 
	};

	// quangminh kết thúc
});
