app.controller("subcategory-ctrl", function($scope, $http) {
	$scope.subcategoryitems = [];
	$scope.prodcates = [];
	$scope.form = {};
	$scope.form.productCategory = {};
	$scope.errorMessage = '';
	$scope.initialize = function() {
		//load subcategories
		$http.get("/rest/subcategories/loadall").then(resp => {
			$scope.subcategoryitems = resp.data;
		});

		//load productcategories
		$http.get("/rest/productcategories/loadall").then(resp => {
			$scope.prodcates = resp.data;
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
	$scope.edit = function(subcategoryitem) {
		$scope.form = angular.copy(subcategoryitem);
	}


	//	Thêm mới 
	$scope.create = function() {
		//Không chọn nhóm sản phẩm
		if (!$scope.form.productCategory || !$scope.form.productCategory.productCategoryID) {
			$scope.errorMessage = "Vui lòng chọn nhóm sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.subCategoryName) {
			$scope.errorMessage = "Vui lòng nhập tên danh mục con!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var subcategoryitem = angular.copy($scope.form);
		$http.post('/rest/subcategories/create', subcategoryitem).then(resp => {
			$scope.subcategoryitems.push(resp.data);
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
		//Không chọn nhóm sản phẩm
		if (!$scope.form.productCategory || !$scope.form.productCategory.productCategoryID) {
			$scope.errorMessage = "Vui lòng chọn nhóm sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.subCategoryName) {
			$scope.errorMessage = "Vui lòng nhập tên danh mục con!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var subcategoryitem = angular.copy($scope.form);
		$http.put('/rest/subcategories/update/' + subcategoryitem.subCategoryID, subcategoryitem).then(resp => {
			var index = $scope.subcategoryitems.findIndex(p => p.subCategoryID == subcategoryitem.subCategoryID);
			$scope.subcategoryitems[index] = subcategoryitem;
			$scope.messageSuccess = "Cập nhật thành công";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Cập nhật thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})
	}
	
	//Gọi đến modal xác nhận để xóa
	$scope.confirmDeleteModal = function() {
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDeleteModal1 = function(subcategoryitem) {
		$scope.form = angular.copy(subcategoryitem);
		$('#confirmDeleteModal').modal('show');
	}


	//sau khi xác nhận thành công thì xóa
	$scope.confirmDelete = function() {
		// Thực hiện xóa 
		$http.delete('/rest/subcategories/delete/' + $scope.form.subCategoryID).then(resp => {
			var index = $scope.subcategoryitems.findIndex(p => p.subCategoryID == $scope.form.subCategoryID);
			console.log(subcategoryitem.subCategoryID);
			$scope.subcategoryitems.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		});

		// Đóng modal xác nhận xóa
		$('#confirmDeleteModal').modal('hide');
	}

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 10,
		get subcategoryitems() {
			var start = this.page * this.size;
			return $scope.subcategoryitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.subcategoryitems.length / this.size);
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