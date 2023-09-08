app.controller("laptopconfiguration-ctrl", function($scope, $http) {
	$scope.laptopconfigitems = [];
	$scope.prods = [];
	$scope.form = {};
	$scope.form.products = {};
	$scope.errorMessage = '';
	$scope.initialize = function() {
		//load laptopconfigurations
		$http.get("/rest/laptopconfigurations/loadall").then(resp => {
			$scope.laptopconfigitems = resp.data;
		});

		//load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
			$scope.productitems.forEach(productitem => {
				productitem.createDate = new Date(productitem.createDate)
			})
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
	$scope.edit = function(laptopconfigitem) {
		$scope.form = angular.copy(laptopconfigitem);
	}


	//	Thêm mới 
	$scope.create = function() {
		//Không chọn sản phẩm
		if (!$scope.form.product || !$scope.form.product.productID) {
			$scope.errorMessage = "Vui lòng chọn sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		// Kiểm tra sự trùng lặp
//		var isDuplicate = checkDuplicateVariant($scope.form);
//		if (isDuplicate) {
//			$scope.errorMessage = "Sản phẩm này đã tồn tại với một cấu hình. Bạn cui lòng chọn sản phẩm khác!";
//			$('#errorModal').modal('show'); // Show the modal
//			return;
//		}
		
		//Lỗi bỏ trống 
		if (!$scope.form.screen) {
			$scope.errorMessage = "Vui lòng nhập kích cỡ màn hình!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		if (!$scope.form.hardDrive) {
			$scope.errorMessage = "Vui lòng nhập ổ cứng!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		if (!$scope.form.ram) {
			$scope.errorMessage = "Vui lòng nhập ram!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		if (!$scope.form.graphicsCard) {
			$scope.errorMessage = "Vui lòng nhập card đồ họa!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		if (!$scope.form.cpu) {
			$scope.errorMessage = "Vui lòng nhập CPU!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		

		var laptopconfigitem = angular.copy($scope.form);
		$http.post('/rest/laptopconfigurations/create', laptopconfigitem).then(resp => {
			$scope.laptopconfigitems.push(resp.data);
			$scope.reset();
			$scope.errorMessage = ''; // Xóa thông báo lỗi khi thành công
			$scope.messageSuccess = "Thêm mới thành công";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			if (error.status === 400) {
				$scope.errorMessage = error.data;
			} else {
				$scope.errorMessage = "Thêm mới thất bại";
				$('#errorModal').modal('show'); // Show the modal
				console.log("Error", error);
			}
		});
	}

	//	Cập nhật  
	$scope.update = function() {
		//Không chọn sản phẩm
		if (!$scope.form.product || !$scope.form.product.productID) {
			$scope.errorMessage = "Vui lòng chọn sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		// Kiểm tra sự trùng lặp
//		var isDuplicate = checkDuplicateVariant($scope.form);
//		if (isDuplicate) {
//			$scope.errorMessage = "Sản phẩm này đã tồn tại với một cấu hình. Bạn cui lòng chọn sản phẩm khác!";
//			$('#errorModal').modal('show'); // Show the modal
//			return;
//		}
		
		//Lỗi bỏ trống 
		if (!$scope.form.screen) {
			$scope.errorMessage = "Vui lòng nhập kích cỡ màn hình!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		if (!$scope.form.hardDrive) {
			$scope.errorMessage = "Vui lòng nhập ổ cứng!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		if (!$scope.form.ram) {
			$scope.errorMessage = "Vui lòng nhập ram!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		if (!$scope.form.graphicsCard) {
			$scope.errorMessage = "Vui lòng nhập card đồ họa!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		if (!$scope.form.cpu) {
			$scope.errorMessage = "Vui lòng nhập CPU!!";
            $('#errorModal').modal('show'); // Show the modal
			return;
		}
		var laptopconfigitem = angular.copy($scope.form);
		$http.put('/rest/laptopconfigurations/update/' + laptopconfigitem.laptopID, laptopconfigitem).then(resp => {
			var index = $scope.laptopconfigitems.findIndex(p => p.laptopID == laptopconfigitem.laptopID);
			$scope.laptopconfigitems[index] = laptopconfigitem;
			$scope.messageSuccess = "Cập nhật thành công";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Cập nhật thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})
	}

	//	Xóa 
	$scope.delete = function(laptopconfigitem) {
		$http.delete('/rest/laptopconfigurations/delete/' + laptopconfigitem.laptopID).then(resp => {
			var index = $scope.laptopconfigitems.findIndex(p => p.laptopID == laptopconfigitem.laptopID);
			console.log(laptopconfigitem.laptopID); // Sửa laptopID thành laptopconfigitem.laptopID
			$scope.laptopconfigitems.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
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
		size: 10,
		get laptopconfigitems() {
			var start = this.page * this.size;
			return $scope.laptopconfigitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.laptopconfigitems.length / this.size);
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
});