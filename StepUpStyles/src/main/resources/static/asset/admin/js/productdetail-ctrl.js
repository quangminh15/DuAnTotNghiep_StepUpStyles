app.controller("productdetail-ctrl", function($scope, $http) {
	$scope.productdetailitems = [];
	$scope.productdetailitemss = [];
	$scope.productdetailitemsLoadAll = [];
	$scope.prods = [];
	$scope.cols = [];
	$scope.sizs = [];
	$scope.form = {};
	$scope.form.product = {};
	$scope.form.color = {};
	$scope.errorMessage = '';
	
	$scope.sortableColumns = [
		{ name: 'productDetailID', label: 'Mã chi tiết' },
		{ name: 'modifyDate', label: 'Ngày điều chỉnh' },
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		{ name: 'color.colorName', label: 'Tên màu' },
		{ name: 'size.sizeNumber', label: 'Size' },
		{ name: 'quantity', label: 'Số lượng' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.productdetailitems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'product.productName') {
				aValue = a.product.productName;
				bValue = b.product.productName;
			}
			
			if (columnName === 'color.colorName') {
				aValue = a.color.colorName;
				bValue = b.color.colorName;
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
		get productdetailitems() {
			var start = this.page * this.size;
			return $scope.productdetailitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productdetailitems.length / this.size);
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
		get productdetailitemss() {
			var start = this.page * this.size;
			return $scope.productdetailitemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productdetailitemss.length / this.size);
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
	
	$scope.initialize = function() {
		//load productdetailitems hết luôn
		$http.get("/rest/productdetails/loadall").then(resp => {
			$scope.productdetailitemsLoadAll = resp.data;
			$scope.productdetailitemsLoadAll.forEach(productdetailitem => {
				productdetailitem.modifyDate = new Date(productdetailitem.modifyDate)
			})
			$scope.productdetailitemsLoadAll.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load productdetailitems 
		$http.get("/rest/productdetails/loadallNoDeleted").then(resp => {
			$scope.productdetailitems = resp.data;
			$scope.productdetailitems.forEach(productdetailitem => {
				productdetailitem.modifyDate = new Date(productdetailitem.modifyDate)
			})
			$scope.productdetailitems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load productdetailitems đã xóa
		$http.get("/rest/productdetails/loadallDeleted").then(resp => {
			$scope.productdetailitemss = resp.data;
			$scope.productdetailitemss.forEach(productdetailitem => {
				productdetailitem.modifyDate = new Date(productdetailitem.modifyDate)
			})
			$scope.productdetailitemss.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load product
		$http.get("/rest/products/loadallNoDeleted").then(resp => {
			$scope.prods = resp.data;
			console.log($scope.prods)
			$scope.prods.forEach(productitem => {
				productitem.modifyDate = new Date(productitem.modifyDate)
			})
			$scope.pager.first();
		});

		//load color
		$http.get("/rest/colors/loadallNoDeleted").then(resp => {
			$scope.cols = resp.data;
			$scope.cols.forEach(coloritem => {
				coloritem.modifyDate = new Date(coloritem.modifyDate)
			})
			$scope.pager.first();
		});
		
		//load size
		$http.get("/rest/sizes/loadallNoDeleted").then(resp => {
			$scope.sizs = resp.data;
			$scope.sizs.forEach(sizeitem => {
				sizeitem.modifyDate = new Date(sizeitem.modifyDate)
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
	$scope.searchProductDetailByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/productdetails/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.productdetailitems = resp.data;
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
	
	$scope.filterByProduct = function() {
		if ($scope.selectedProduct) {
			$http.get("/rest/productdetails/loadbyproduct/" + $scope.selectedProduct).then(resp => {
				$scope.productdetailitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách sản phẩm!";
				$('#errorModal').modal('show'); // Show the modal
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có sản phẩm được chọn, hiển thị tất cả màu sắc
			$scope.initialize();
		}
	};

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			deleted: false,
		};
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(productdetailitem) {
		$scope.form = angular.copy(productdetailitem);
	}

	function checkDuplicateProductDetail(productdetailitem) {
		// Kiểm tra sự trùng lặp dựa trên productID, colorID
		var isDuplicate = $scope.productdetailitems.some(function(item) {
			return (
				item.product.productID === productdetailitem.product.productID &&
				item.color.colorID === productdetailitem.color.colorID
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

		//Không chọn màu sản phẩm
		if (!$scope.form.color || !$scope.form.color.colorID) {
			$scope.errorMessage = "Vui lòng chọn màu cho sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		// Kiểm tra sự trùng lặp
		var isDuplicate = checkDuplicateProductDetail($scope.form);
		if (isDuplicate) {
			$scope.errorMessage = "Đã tồn tại sản phẩm chi tiết có tên và màu này rồi!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.quantity) {
			$scope.errorMessage = "Vui lòng nhập số lượng!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi số lượng sản phẩm < 0
		if ($scope.form.quantity < 0) {
			$scope.errorMessage = "Vui lòng nhập số lượng sản phẩm lớn hơn 0!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi số lượng sản phẩm > 10.000
		if ($scope.form.quantity > 10000) {
			$scope.errorMessage = "Số lượng quá lớn. Vui lòng nhập nhỏ hơn 10.000 !!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var productdetailitem = angular.copy($scope.form);
		productdetailitem.deleted = false;
		productdetailitem.modifyDate = new Date();
		$http.post('/rest/productdetails/create', productdetailitem).then(resp => {
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.productdetailitems.push(resp.data);
			$scope.reset();
			$scope.errorMessage = ''; // Xóa thông báo lỗi khi thành công
			$scope.messageSuccess = "Thêm mới thành công";
			$('#errorModal1').modal('show'); // Show the modal
			$scope.initialize();
			$scope.reset();
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

		//Không chọn màu sản phẩm
		if (!$scope.form.color || !$scope.form.color.colorID) {
			$scope.errorMessage = "Vui lòng chọn màu cho sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.quantity) {
			$scope.errorMessage = "Vui lòng nhập số lượng!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi số lượng sản phẩm < 0
		if ($scope.form.quantity < 0) {
			$scope.errorMessage = "Vui lòng nhập số lượng sản phẩm lớn hơn 0!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi số lượng sản phẩm > 10.000
		if ($scope.form.quantity > 10000) {
			$scope.errorMessage = "Số lượng quá lớn. Vui lòng nhập nhỏ hơn 10.000 !!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}


		var productdetailitem = angular.copy($scope.form);
		$http.put('/rest/productdetails/update/' + productdetailitem.productDetailID, productdetailitem).then(resp => {
			var index = $scope.productdetailitems.findIndex(p => p.productDetailID == productdetailitem.productDetailID);
			$scope.productdetailitems[index] = productdetailitem;
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

	//Mở modal thùng rác
	$scope.openRecycleBinForm = function() {
		// Reset searchKeyword
		searchValue = '';
		$('#recycleBinModal').modal('show');
	};

	//Gọi đến modal xác nhận để xóa vào thùng rác
	$scope.confirmHideModal = function() {
		$('#confirmHideModal').modal('show');
	}

	//Gọi đến modal xác nhận để xóa vào thùng rác
	$scope.confirmHideModal1 = function(productdetailitem) {
		$scope.form = angular.copy(productdetailitem);
		$('#confirmHideModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa vào thùng rác
	$scope.confirmHide = function() {
		var productdetailitem = angular.copy($scope.form);
		productdetailitem.deleted = true;
		$http.put('/rest/productdetails/update/' + productdetailitem.productDetailID, productdetailitem).then(resp => {
			var index = $scope.productdetailitems.findIndex(p => p.productDetailID == productdetailitem.productDetailID);
			$scope.productdetailitems[index] = productdetailitem;
			$scope.messageSuccess = "Xóa thành công";
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

	//Gọi đến modal xác nhận để khôi phục item từ thùng rác
	$scope.confirmRestoreModal1 = function(productdetailitem) {
		$scope.form = angular.copy(productdetailitem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmRestoreModal').modal('show');
	}

	//Khôi phục item từ thùng rác
	$scope.restore = function() {
		var productdetailitem = angular.copy($scope.form);
		productdetailitem.deleted = false;
		$http.put('/rest/productdetails/update/' + productdetailitem.productDetailID, productdetailitem).then(resp => {
			var index = $scope.productdetailitemsLoadAll.findIndex(p => p.productDetailID == productdetailitem.productDetailID);
			$scope.productdetailitemsLoadAll[index] = productdetailitem;

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

	//Gọi đến modal xác nhận để xóa luôn
	$scope.confirmDeleteModal1 = function(productdetailitem) {
		$scope.form = angular.copy(productdetailitem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa
		$http.delete('/rest/productdetails/delete/' + $scope.form.productDetailID).then(resp => {
			var index = $scope.productdetailitems.findIndex(p => p.productDetailID == $scope.form.productDetailID);
			$scope.productdetailitems.splice(index, 1);
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
});