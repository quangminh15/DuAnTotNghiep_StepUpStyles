app.controller("review-ctrl", function($scope, $http){
	$scope.reviewitems = [];
	$scope.prods = [];
	$scope.users = [];
	$scope.form = {};
	$scope.reviewdetails = {}
	$scope.showSelectBoxEmptyWarning = false;
	$scope.initialize = function() {
		//load review
		$http.get("/rest/reviews/loadall").then(resp => {
			$scope.reviewitems = resp.data;
			$scope.reviewitems.forEach(reviewitem => {
				reviewitem.reviewDate = new Date(reviewitem.reviewDate)
			})
			$scope.reviewitems.sort((a, b) => b.reviewDate - a.reviewDate);
			$scope.pager.first();
		});

		//load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
		});
		
		//load User
		$http.get("/rest/users/loadall").then(resp => {
			$scope.users = resp.data;
		});
	}
	//	Khởi đầu
	$scope.initialize();

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 8,
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
		get reviewitems() {
			var start = this.page * this.size;
			return $scope.reviewitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.reviewitems.length / this.size);
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

	$scope.showReview = function(reviewId){
		$http.get("/rest/reviews/" + reviewId).then(resp => {
			$scope.reviewdetails =  resp.data;
			$('#orderModal').modal('show');
			console.log($scope.reviewdetails);
			console.log("Success", resp);
		}).catch(error => {
			console.log("ẻroorrr", error);
		});
	}

	$scope.hideReview = function (reviewId) {
		$http.put('/rest/reviews/' + reviewId + '/hide')
			.then(function (response) {
				if (response.status === 200) {
				}
				$scope.initialize();
			})
			.catch(function (error) {
				console.log('Error hiding review:', error);
			});
	};

	$scope.filterByProduct = function() {
		if ($scope.selectedProduct) {
			$http.get("/rest/reviews/loadbyproducts/" + $scope.selectedProduct).then(resp => {
				$scope.reviewitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};

	$scope.filterByUser = function() {
		if ($scope.selectedUser) {
			$http.get("/rest/reviews/loadbyusers/" + $scope.selectedUser).then(resp => {
				$scope.reviewitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};

	$scope.searchReviews = function() {
		if ($scope.productId || $scope.usersId || $scope.rating) {
			// Sử dụng template string để chèn biến vào URL
			$http.get(`/rest/reviews/search?productId=${$scope.productId}&usersId=${$scope.usersId}&rating=${$scope.rating}`)
			.then(function(response) {
				$scope.reviewitems = response.data;
				console.log("Dữ liệu");
				console.log(response.data);
				$scope.pager.first();
			});
		} else {
			// Gọi hàm khởi tạo khi không có tham số tìm kiếm
			$scope.initialize();
		}
	}

	$scope.reset = function(){
		$scope.initialize();
		$scope.productId = "";
        $scope.usersId = "";
  		$scope.rating = "";
	}
	
})