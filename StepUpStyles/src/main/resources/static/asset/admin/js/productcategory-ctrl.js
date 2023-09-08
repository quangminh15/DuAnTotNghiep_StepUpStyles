app.controller("productcategory-ctrl", function($scope, $http) {
	$scope.productcategoryitems = [];
	$scope.prodgroups = [];
	$scope.form = {};
	$scope.form.productGroup = {};
	$scope.errorMessage = '';
	
	$scope.sortableColumns = [
		{ name: 'productCategoryID', label: 'Mã nhóm' },
		{ name: 'productGroup.productGroupName', label: 'Tên nhóm sản phẩm' },
		{ name: 'productCategoryName', label: 'Tên danh mục' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.productcategoryitems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'productGroup.productGroupName') {
				aValue = a.productGroup.productGroupName;
				bValue = b.productGroup.productGroupName;
			}
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
		get productcategoryitems() {
			var start = this.page * this.size;
			return $scope.productcategoryitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productcategoryitems.length / this.size);
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
		//load productcategories
		$http.get("/rest/productcategories/loadall").then(resp => {
			$scope.productcategoryitems = resp.data;
			$scope.pager.first();
		});

		//load productgroups
		$http.get("/rest/productgroups/loadall").then(resp => {
			$scope.prodgroups = resp.data;
			$scope.pager.first();
		});
	}
	
	//Mở modal tìm kiếm
	$scope.openSearchForm = function() {
		// Reset searchKeyword
		$scope.searchKeyword = '';
		$('#searchModal').modal('show');
	};

	// Tìm kiếm màu 
	$scope.searchProductCateByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/productcategories/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.productcategoryitems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					$scope.errorMessage = `Không tìm thấy danh mục có tên "${$scope.searchKeyword}"`;
					$('#errorModal').modal('show');
				}
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tìm kiếm danh mục sản phẩm!";
				$('#errorModal').modal('show'); // Hiển thị modal lỗi
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			$scope.errorMessage = "Không tìm thấy danh mục mà bạn mong muốn!";
			$('#errorModal').modal('show'); // Hiển thị modal lỗi
		}
		$('#searchModal').modal('hide');
	};

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {

		};
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(productcategoryitem) {
		$scope.form = angular.copy(productcategoryitem);
	}

	function checkDuplicateCategory(productcategoryitem) {
		// Kiểm tra sự trùng lặp dựa trên productGroupID, productCategoryID 
		var isDuplicate = $scope.productcategoryitems.some(function(item) {
			return (
				item.productCategoryName === productcategoryitem.productCategoryName &&
				item.productGroup.productGroupID === productcategoryitem.productGroup.productGroupID
			);
		});

		return isDuplicate;
	}
	//	Thêm mới 
	$scope.create = function() {
		//Không chọn nhóm sản phẩm
		if (!$scope.form.productGroup || !$scope.form.productGroup.productGroupID) {
			$scope.errorMessage = "Vui lòng chọn nhóm sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.productCategoryName) {
			$scope.errorMessage = "Vui lòng nhập tên danh mục sản phẩm!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		// Kiểm tra sự trùng lặp
		var isDuplicate = checkDuplicateCategory($scope.form);
		if (isDuplicate) {
			$scope.errorMessage = "Tên danh mục này đã tồn tại với nhóm mà bạn đã chọn!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}


		var productcategoryitem = angular.copy($scope.form);
		$http.post('/rest/productcategories/create', productcategoryitem).then(resp => {
			$scope.productcategoryitems.push(resp.data);
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
		//Không chọn nhóm sản phẩm
		if (!$scope.form.productGroup || !$scope.form.productGroup.productGroupID) {
			$scope.errorMessage = "Vui lòng chọn nhóm sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.productCategoryName) {
			$scope.errorMessage = "Vui lòng nhập tên danh mục sản phẩm!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var productcategoryitem = angular.copy($scope.form);
		$http.put('/rest/productcategories/update/' + productcategoryitem.productCategoryID, productcategoryitem).then(resp => {
			var index = $scope.productcategoryitems.findIndex(p => p.productCategoryID == productcategoryitem.productCategoryID);
			$scope.productcategoryitems[index] = productcategoryitem;
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

	$scope.confirmDeleteModal1 = function(productcategoryitem) {
		$scope.form = angular.copy(productcategoryitem);
		$('#confirmDeleteModal').modal('show');
	}


	//sau khi xác nhận thành công thì xóa
	$scope.confirmDelete = function() {
		// Thực hiện xóa 
		$http.delete('/rest/productcategories/delete/' + $scope.form.productCategoryID).then(resp => {
			var index = $scope.productcategoryitems.findIndex(p => p.productCategoryID == $scope.form.productCategoryID);
			$scope.productcategoryitems.splice(index, 1);
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
});