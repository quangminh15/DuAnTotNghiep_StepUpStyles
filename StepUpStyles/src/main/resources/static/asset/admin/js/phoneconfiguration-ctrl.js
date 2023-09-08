app.controller("phoneconfiguration-ctrl", function($scope, $http) {
	$scope.phoneconfigitems = [];
	$scope.prods = [];
	$scope.form = {};
	$scope.form.products = {};
	$scope.errorMessage = '';

	$scope.sortableColumns = [
		{ name: 'phoneID', label: 'Mã cấu hình' },
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		{ name: 'screen', label: 'Màn hình' },
		{ name: 'internalMemory', label: 'Bộ nhớ trong' },
		{ name: 'camera', label: 'Camera' },
		{ name: 'cpu', label: 'CPU' },
		{ name: 'ram', label: 'RAM' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.phoneconfigitems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'product.productName') {
				aValue = a.product.productName;
				bValue = b.product.productName;
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
		get phoneconfigitems() {
			var start = this.page * this.size;
			return $scope.phoneconfigitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.phoneconfigitems.length / this.size);
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
		//load phoneconfigurations
		$http.get("/rest/phoneconfigurations/loadall").then(resp => {
			$scope.phoneconfigitems = resp.data;
			$scope.pager.first();
		});

		//load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
			$scope.prods.forEach(productitem => {
				productitem.createDate = new Date(productitem.createDate)
			})
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
	$scope.searchPhoneConFigByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/phoneconfigurations/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.phoneconfigitems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					$scope.errorMessage = `Không tìm thấy sản phẩm có tên "${$scope.searchKeyword}"`;
					$('#errorModal').modal('show');
				}
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tìm kiếm sản phẩm!";
				$('#errorModal').modal('show'); // Hiển thị modal lỗi
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			$scope.errorMessage = "Không tìm thấy sản phẩm mà bạn mong muốn!";
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
	$scope.edit = function(phoneconfigitem) {
		$scope.form = angular.copy(phoneconfigitem);
	}

	function checkDuplicateProductName(phoneconfigitem) {
		// Kiểm tra sự trùng lặp dựa trên productID
		var isDuplicate = $scope.phoneconfigitems.some(function(item) {
			return (
				item.product.productID === phoneconfigitem.product.productID
			);
		});

		return isDuplicate;
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
		var isDuplicate = checkDuplicateProductName($scope.form);
		if (isDuplicate) {
			$scope.errorMessage = "Sản phẩm này đã tồn tại với một cấu hình trước đó!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.screen) {
			$scope.errorMessage = "Vui lòng nhập kích cỡ màn hình!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.internalMemory) {
			$scope.errorMessage = "Vui lòng nhập bộ nhớ trong!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.camera) {
			$scope.errorMessage = "Vui lòng nhập thông số của camera!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.cpu) {
			$scope.errorMessage = "Vui lòng nhập CPU!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.ram) {
			$scope.errorMessage = "Vui lòng nhập RAM!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}


		var phoneconfigitem = angular.copy($scope.form);
		$http.post('/rest/phoneconfigurations/create', phoneconfigitem).then(resp => {
			$scope.phoneconfigitems.push(resp.data);
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
		//Không chọn sản phẩm
		if (!$scope.form.product || !$scope.form.product.productID) {
			$scope.errorMessage = "Vui lòng chọn sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.screen) {
			$scope.errorMessage = "Vui lòng nhập kích cỡ màn hình!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.internalMemory) {
			$scope.errorMessage = "Vui lòng nhập bộ nhớ trong!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.camera) {
			$scope.errorMessage = "Vui lòng nhập thông số của camera!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.cpu) {
			$scope.errorMessage = "Vui lòng nhập CPU!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.ram) {
			$scope.errorMessage = "Vui lòng nhập RAM!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var phoneconfigitem = angular.copy($scope.form);
		$http.put('/rest/phoneconfigurations/update/' + phoneconfigitem.phoneID, phoneconfigitem).then(resp => {
			var index = $scope.phoneconfigitems.findIndex(p => p.phoneID == phoneconfigitem.phoneID);
			$scope.phoneconfigitems[index] = phoneconfigitem;
			$scope.messageSuccess = "Cập nhật thành công";
			$('#errorModal1').modal('show'); // Show the modal
			$scope.initialize();
		}).catch(error => {
			$scope.errorMessage = "Cập nhật thất bại";
			$('#errorModal').modal('show'); // Show the modal
			$scope.initialize();
			console.log("Error", error);
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
		$http.delete('/rest/phoneconfigurations/delete/' + $scope.form.phoneID).then(resp => {
			var index = $scope.phoneconfigitems.findIndex(p => p.phoneID == $scope.form.phoneID);
			$scope.phoneconfigitems.splice(index, 1);
			$scope.reset();
			$scope.initialize();
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