app.controller("review-ctrl", function($scope, $http){
	$scope.reviewitems = [];
	$scope.prods = [];
	$scope.users = [];
	$scope.form = {};
	$scope.form.user = {};
	$scope.errorMessage = '';
	$scope.initialize = function() {
		//load product
		$http.get("/rest/reviews/loadall").then(resp => {
			$scope.reviewitems = resp.data;
			$scope.reviewitems.forEach(reviewitem => {
				reviewitem.reviewDate = new Date(reviewitem.reviewDate)
			})
			$scope.reviewitems.sort((a, b) => b.reviewDate - a.reviewDate);
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

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			
		};
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(reviewitem) {
		$scope.form = angular.copy(reviewitem);
	}

	//	Xóa
	$scope.delete = function(reviewitem) {
		$http.delete('/rest/reviews/delete/' + reviewitem.reviewID).then(resp => {
			var index = $scope.reviewitems.findIndex(p => p.reviewID == reviewitem.reviewID);
			console.log(reviewitem.reviewID);
			$scope.reviewitems.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
			$scope.initialize();
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})
	}

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 5,
		get reviewitems() {
			var start = this.page * this.size;
			return $scope.reviewitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.reviewitems.length / this.size);
		},
		first() {
			this.page = 0;
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
		},
		last() {
			this.page = this.count - 1;
		},
	}


})