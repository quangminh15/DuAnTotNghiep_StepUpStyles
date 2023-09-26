app.controller("supplier-ctrl", function($scope, $http){
    $scope.items = [];
	$scope.itemss = [];
	$scope.itemsss = [];
	$scope.form = {
        supplierName: '',
        phone: '',
        email: '',
		addresss: '',
        display: true,
		deleted: false
    };

	$scope.sortableColumns = [
		{ name: 'supplierId', label: 'Mã nhà cung cấp' },
		// { name: 'modifyDate', label: 'Thời gian' },
		{ name: 'supplierName', label: 'Tên nhà cung cấp' },
		{ name: 'addresss', label: 'Địa chỉ' },
		{ name: 'phone', label: 'Số điện thoại' },
		{ name: 'email', label: 'Email' },
		{ name: 'display', label: 'Hiển thị' },
	];

	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.itemss.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			// if (columnName === 'category.categoryName') {
			// 	aValue = a.category.categoryName;
			// 	bValue = b.category.categoryName;
			// }
			// if (columnName === 'brand.brandName') {
			// 	aValue = a.brand.brandName;
			// 	bValue = b.brand.brandName;
			// }
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

    $scope.initialize = function () {
		//load all supplier
		$http.get("/rest/supplier").then(resp => {
			$scope.items = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
			
		});

		//load supplier deleted
		$http.get("/rest/supplier/deleted").then(resp => {
			$scope.itemsss = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
			
		});

		//load supplier no deleted
		$http.get("/rest/supplier/nodeleted").then(resp => {
			$scope.itemss = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

    $scope.initialize();

    //ham create
    $scope.create = function (){
		//bo trong ten
		if (!$scope.form.supplierName) {
			$scope.errorMessage = "Vui lòng nhập tên nhà cung cấp!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//loi trung
		let existingSupplier = $scope.items.find(item => item.supplierName === $scope.form.supplierName);
		if (existingSupplier) {
			$scope.errorMessage = "Tên nhà cung cấp đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong so dien thoai
		if (!$scope.form.phone) {
			$scope.errorMessage = "Vui lòng nhập số điện thoại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} else if (!/^0\d{9}$/.test($scope.form.phone)) {
			$scope.errorMessage = "Số điện thoại không hợp lệ!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		// Kiểm tra trùng số điện thoại
		let existingPhone = $scope.items.find(item => item.phone === $scope.form.phone);
		if (existingPhone) {
			$scope.errorMessage = "Số điện thoại đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong email va kiem tra email
		if (!$scope.form.email) {
			$scope.errorMessage = "Vui lòng nhập email!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} else if (!/\S+@\S+\.\S+/.test($scope.form.email)) {
			$scope.errorMessage = "Email không hợp lệ. Vui lòng nhập email chính xác!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		// Kiểm tra trùng email
		let existingEmail = $scope.items.find(item => item.email === $scope.form.email);
		if (existingEmail) {
			$scope.errorMessage = "Email đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

        let newItem = angular.copy($scope.form);
		newItem.deleted = false;
		$http.post(`/rest/supplier/createSupp`, newItem).then(response => {
			let data = response.data;
			$scope.items.push(data);
			$scope.reset();
			$scope.initialize();
			$scope.messageSuccess = "Thêm thành công nhà cung cấp";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			alert("Lỗi");
			console.log("Error", error);
		});
    }

    //ham update
    $scope.update = function () {
		//bo trong ten
		if (!$scope.form.supplierName) {
			$scope.errorMessage = "Vui lòng nhập tên nhà cung cấp!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong so dien thoai
		if (!$scope.form.phone) {
			$scope.errorMessage = "Vui lòng nhập số điện thoại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong email va kiem tra email
		if (!$scope.form.email) {
			$scope.errorMessage = "Vui lòng nhập email!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} else if (!/\S+@\S+\.\S+/.test($scope.form.email)) {
			$scope.errorMessage = "Email không hợp lệ. Vui lòng nhập email chính xác!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var item = angular.copy($scope.form);
		$http.put(`/rest/supplier/updateSupp/${item.supplierId}`, item).then(resp => {
			var index = $scope.items.findIndex(p => p.supplierId == item.supplierId);
			$scope.items[index] = item;
			$scope.messageSuccess = "Cập nhật thành công nhà cung cấp";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			alert("Loi cap nhat");
			console.log("Error", error);
		})
	}

	//Gọi đến modal xác nhận để xóa vào thùng rác
	$scope.confirmHideModal1 = function(item) {
		$scope.form = angular.copy(item);
		$('#confirmHideModal').modal('show');
	}
	//Xóa vào thùng rác
	$scope.confirmHide = function() {
		var item = angular.copy($scope.form);
		item.deleted = true;
		$http.put('/rest/supplier/updateSupp/' + item.supplierId, item).then(resp => {
			var index = $scope.itemss.findIndex(p => p.supplierId == item.supplierId);
			$scope.itemss[index] = item;
			$scope.messageSuccess = "Xóa thành công";
			$scope.reset();
			$('#errorModal1').modal('show');
			$scope.initialize();
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show');
			$scope.initialize();
			console.log("Error", error);
		})

		// Đóng modal thùng rác
		$('#confirmHideModal').modal('hide');
	}

	//Mở modal thùng rác
	$scope.openRecycleBinForm = function() {
		// Reset searchKeyword
		searchValue = '';
		$('#recycleBinModal').modal('show');
	};

	//Gọi đến modal xác nhận để khôi phục item từ thùng rác
	$scope.confirmRestoreModal1 = function(item) {
		$scope.form = angular.copy(item);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmRestoreModal').modal('show');
	}

	//Khôi phục item từ thùng rác
	$scope.restore = function() {
		var item = angular.copy($scope.form);
		item.deleted = false;
		$http.put('/rest/supplier/updateSupp/' + item.supplierId, item).then(resp => {
			var index = $scope.items.findIndex(p => p.supplierId == item.supplierId);
			$scope.items[index] = item;
			$scope.reset();
			// Đóng modal thùng rác
			$('#recycleBinModal').modal('hide');

			$scope.messageSuccess = "khôi phục thành công";
			$('#errorModal1').modal('show');
			$scope.initialize();

		}).catch(error => {
			// Đóng modal thùng rác
			$('#recycleBinModal').modal('hide');

			$scope.errorMessage = "Khôi phục thất bại";
			$('#errorModal').modal('show');
			$scope.initialize();
			console.log("Error", error);
		})

		// Đóng modal thùng rác
		$('#confirmRestoreModal').modal('hide');
	}

	//search
	$scope.searchByName = function(){
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/supplier/searchSupplier", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.itemss = resp.data;
				$scope.pager.first();
			}).catch(error => {
				console.log("Error", error);
				$scope.pager.first();
			});
		}else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
		}
	}
	
	//Gọi đến modal xác nhận
	$scope.confirmDeleteModal = function() {
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDeleteModal1 = function(item) {
		$scope.form = angular.copy(item); // Set form data for confirmation modal
		$('#confirmDeleteModal').modal('show'); // Show the confirmation modal
	}

	//sau khi xác nhận thành công thì xóa
	$scope.confirmDelete = function() {

		// Thực hiện xóa nhóm sản phẩm
		var supplierId = $scope.form.supplierId; // Lấy supplierId từ form
    	$scope.deleted(supplierId); // Gọi hàm deleted với supplierId

		// Đóng modal xác nhận xóa
		$('#confirmDeleteModal').modal('hide');
	}

	//Gọi đến modal xác nhận để xóa luôn
	$scope.confirmDeleteModal1 = function(item) {
		$scope.form = angular.copy(item);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa
		$http.delete('/rest/supplier/removeSupp/' + $scope.form.supplierId).then(resp => {
			var index = $scope.itemss.findIndex(p => p.supplierId == $scope.form.supplierId);
			$scope.itemss.splice(index, 1);
			$scope.reset();
			$scope.initialize();
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show');
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show');
			console.log("Error", error);
		});

		// Đóng modal xác nhận xóa
		$('#confirmDeleteModal').modal('hide');
	}

    //xoa form
    $scope.reset = function () {
		$scope.form = {
			display: true
		};
	}

    //hien thi len form
	$scope.edit = function (item) {
		$scope.form = angular.copy(item);
	}

    //Phân trang
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
		get itemss() {
			var start = this.page * this.size;
			return $scope.itemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.itemss.length / this.size);
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

	//	Phân trang đã xóa
	$scope.RestorePager = {
		page: 0,
		size: 5,
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
		get itemsss() {
			var start = this.page * this.size;
			return $scope.itemsss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.itemsss.length / this.size);
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
});