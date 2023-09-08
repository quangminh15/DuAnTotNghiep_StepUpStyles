app.controller("productgroup-ctrl", function($scope, $http) {
	$scope.productgroupitems = [];
	$scope.form = {};
	$scope.errorMessage = '';
	
	$scope.sortableColumns = [
		{ name: 'productGroupID', label: 'Mã nhóm' },
		{ name: 'productGroupName', label: 'Tên nhóm sản phẩm' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.productgroupitems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (typeof aValue === 'string') {
				aValue = aValue.toLowerCase();
			}
			if (typeof bValue === 'string') {
				bValue = bValue.toLowerCase();
			}

			if (aValue < bValue) {
				return $scope.sortReverse ? 1 : -1;
			} else if (aValue > bValue) {
				return $scope.sortReverse ? -1 : 1;
			}
			return 0;
		});
	};

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 5,
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
		get productgroupitems() {
			var start = this.page * this.size;
			return $scope.productgroupitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productgroupitems.length / this.size);
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

	$scope.initialize = function() {
		//load productgroups
		$http.get("/rest/productgroups/loadall").then(resp => {
			$scope.productgroupitems = resp.data;
			$scope.pager.first();
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
	$scope.edit = function(productgroupitem) {
		$scope.form = angular.copy(productgroupitem);
	}

	//Mở modal tìm kiếm
	$scope.openSearchForm = function() {
		// Reset searchKeyword
		$scope.searchKeyword = '';
		$('#searchModal').modal('show');
	};

	// Tìm kiếm màu 
	$scope.searchProductGroupByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/productgroups/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.productgroupitems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					$scope.errorMessage = `Không tìm thấy nhóm sản phẩm có tên "${$scope.searchKeyword}"`;
					$('#errorModal').modal('show');
				}
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tìm kiếm nhóm sản phẩm!";
				$('#errorModal').modal('show'); // Hiển thị modal lỗi
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			$scope.errorMessage = "Không tìm thấy tên nhóm sản phẩm mà bạn mong muốn!";
			$('#errorModal').modal('show'); // Hiển thị modal lỗi
		}
		$('#searchModal').modal('hide');
	};


	//	Thêm mới 
	$scope.create = function() {
		//Lỗi trùng tên nhóm sản phẩm
		let existingProductGroupName = $scope.productgroupitems.find(productgroupitem => productgroupitem.productGroupName === $scope.form.productGroupName);
		if (existingProductGroupName) {
			$scope.errorMessage = "Tên nhóm sản phẩm đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.productGroupName) {
			$scope.errorMessage = "Vui lòng nhập tên nhóm sảm phẩm!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var productgroupitem = angular.copy($scope.form);
		$http.post('/rest/productgroups/create', productgroupitem).then(resp => {
			$scope.productgroupitems.push(resp.data);
			$scope.reset();
			$scope.errorMessage = ''; // Xóa thông báo lỗi khi thành công
			$scope.messageSuccess = "Thêm mới thành công";
			$('#errorModal1').modal('show'); // Show the modal
			$scope.initialize();
		}).catch(error => {
			if (error.status === 400) {
				$scope.errorMessage = error.data;
				$scope.initialize();
			} else {
				$scope.errorMessage = "Thêm mới thất bại";
				$('#errorModal').modal('show'); // Show the modal
				console.log("Error", error);
				$scope.initialize();
			}
		});
	}

	//	Cập nhật  
	$scope.update = function() {
		//Lỗi bỏ trống 
		if (!$scope.form.productGroupName) {
			$scope.errorMessage = "Vui lòng nhập tên nhóm sảm phẩm!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var productgroupitem = angular.copy($scope.form);
		$http.put('/rest/productgroups/update/' + productgroupitem.productGroupID, productgroupitem).then(resp => {
			var index = $scope.productgroupitems.findIndex(p => p.productGroupID == productgroupitem.productGroupID);
			$scope.productgroupitems[index] = productgroupitem;
			$scope.messageSuccess = "Cập nhật thành công";
			$('#errorModal1').modal('show'); // Show the modal
			$scope.initialize();
		}).catch(error => {
			$scope.errorMessage = "Cập nhật thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
			$scope.initialize();
		})
	}

	//Gọi đến modal xác nhận để xóa
	$scope.confirmDeleteModal = function() {
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDeleteModal1 = function(productgroupitem) {
		$scope.form = angular.copy(productgroupitem);
		$('#confirmDeleteModal').modal('show');
	}


	//sau khi xác nhận thành công thì xóa
	$scope.confirmDelete = function() {
		// Thực hiện xóa 
		$http.delete('/rest/productgroups/delete/' + $scope.form.productGroupID).then(resp => {
			var index = $scope.productgroupitems.findIndex(p => p.productGroupID == $scope.form.productGroupID);
			$scope.productgroupitems.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show'); // Hiển thị modal thành công
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Hiển thị modal lỗi
			console.log("Error", error);
		});

		// Đóng modal xác nhận xóa
		$('#confirmDeleteModal').modal('hide');
	}

});

