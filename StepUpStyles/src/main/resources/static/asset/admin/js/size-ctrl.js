app.controller("size-ctrl", function($scope, $http) {
	$scope.sizeitems = [];
	$scope.sizeitemss = [];
	$scope.sizeitemsLoadAll = [];
	$scope.prods = [];
	$scope.form = {};
	$scope.form.products = {};
	$scope.errorMessage = '';
	$scope.selectedActivity = "all";

	$scope.sortableColumns = [
		{ name: 'sizeID', label: 'Mã cấu hình' },
		{ name: 'sizeNumber', label: 'Tên sản phẩm' },
		{ name: 'modifyDate', label: 'Ngày điều chỉnh' },
		{ name: 'activities', label: 'Trạng thái' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.sizeitems.sort(function(a, b) {
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
		get sizeitems() {
			var start = this.page * this.size;
			return $scope.sizeitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.sizeitems.length / this.size);
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
		get sizeitemss() {
			var start = this.page * this.size;
			return $scope.sizeitemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.sizeitemss.length / this.size);
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
		//load sizeitems hết luôn
		$http.get("/rest/sizes/loadall").then(resp => {
			$scope.sizeitemsLoadAll = resp.data;
			$scope.sizeitemsLoadAll.forEach(sizeitem => {
				sizeitem.modifyDate = new Date(sizeitem.modifyDate)
			})
			$scope.sizeitemsLoadAll.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load sizeitems chưa xóa
		$http.get("/rest/sizes/loadallNoDeleted").then(resp => {
			$scope.sizeitems = resp.data;
			$scope.sizeitems.forEach(sizeitem => {
				sizeitem.modifyDate = new Date(sizeitem.modifyDate)
			})
			$scope.sizeitems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load sizeitems đã xóa
		$http.get("/rest/sizes/loadallDeleted").then(resp => {
			$scope.sizeitemss = resp.data;
			$scope.sizeitemss.forEach(sizeitem => {
				sizeitem.modifyDate = new Date(sizeitem.modifyDate)
			})
			$scope.sizeitemss.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

	$scope.filterByActivities = function() {
		if ($scope.selectedActivity === "all") {
			$http.get("/rest/sizes/loadallNoDeleted").then(resp => {
				$scope.sizeitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách size!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/sizes/loadallNoDeleted").then(resp => {
				const selectedStatus = $scope.selectedActivity === "true";
				const filteredSizes = resp.data.filter(size => size.activities === selectedStatus);
				$scope.sizeitems = filteredSizes;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách size theo trạng thái!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};

	//Mở modal tìm kiếm
	$scope.openSearchForm = function() {
		// Reset searchKeyword
		searchValue = '';
		$('#searchModal').modal('show');
	};

	// Tìm kiếm  
	$scope.searchSizeNumber = function() {
		var searchValue = parseFloat($scope.searchKeyword); // Chuyển đổi searchKeyword sang kiểu số thực
		if (!isNaN(searchValue) && searchValue !== null && searchValue !== undefined) {
			$http.get("/rest/sizes/search", {
				params: { keyword: searchValue }
			}).then(resp => {
				$scope.sizeitems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					$scope.errorMessage = `Không tìm thấy size "${searchValue}"`;
					$('#errorModal').modal('show');
				}
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tìm kiếm size!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả size
			$scope.initialize();
			$scope.errorMessage = "Không tìm thấy size mà bạn mong muốn!";
			$('#errorModal').modal('show');
		}
		$('#searchModal').modal('hide');
	};



	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			activities: false,
			deleted: false,
		};
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(sizeitem) {
		$scope.form = angular.copy(sizeitem);
	}

	//	Thêm mới 
	$scope.create = function() {
		//Lỗi bỏ trống 
		if (!$scope.form.sizeNumber) {
			$scope.errorMessage = "Vui lòng số size!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi trùng tên nhóm sản phẩm
		let existingsizeitemNumber = $scope.sizeitemsLoadAll.find(sizeitem => sizeitem.sizeNumber === $scope.form.sizeNumber);
		if (existingsizeitemNumber) {
			$scope.errorMessage = "size đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi sizeitem < 0
		if ($scope.form.sizeitemNumber < 0) {
			$scope.errorMessage = "Vui lòng nhập size lớn hơn 0!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi sizeitem > 100
		if ($scope.form.sizeitemNumber > 100) {
			$scope.errorMessage = "Vui lòng nhập size nhỏ hơn 100!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var sizeitem = angular.copy($scope.form);
		sizeitem.deleted = false;
		sizeitem.modifyDate = new Date();
		$http.post('/rest/sizes/create', sizeitem).then(resp => {
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.sizeitems.push(resp.data);
			$scope.reset();
			$scope.errorMessage = ''; // Xóa thông báo lỗi khi thành công
			$scope.messageSuccess = "Thêm mới thành công";
			$('#errorModal1').modal('show');
			$scope.initialize();
		}).catch(error => {
			if (error.status === 400) {
				$scope.errorMessage = error.data;
				$scope.initialize();
			} else {
				$scope.errorMessage = "Thêm mới thất bại";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.initialize();
			}
		});
	}

	//	Cập nhật  
	$scope.update = function() {
		//Lỗi bỏ trống 
		if (!$scope.form.sizeNumber) {
			$scope.errorMessage = "Vui lòng số size!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi trùng tên nhóm sản phẩm
		//		let existingsizeitemNumber = $scope.sizeitems.find(sizeitem => sizeitem.sizeitemNumber === $scope.form.sizeitemNumber);
		//		if (existingsizeitemNumber) {
		//			$scope.errorMessage = "sizeitem đã tồn tại!!";
		//			$('#errorModal').modal('show'); // Show the modal
		//			return;
		//		}

		//Lỗi sizeitem < 0
		if ($scope.form.sizeNumber < 0) {
			$scope.errorMessage = "Vui lòng nhập size lớn hơn 0!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi sizeitem > 100
		if ($scope.form.sizeNumber > 100) {
			$scope.errorMessage = "Vui lòng nhập size nhỏ hơn 100!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var sizeitem = angular.copy($scope.form);
		sizeitem.modifyDate = new Date();
		$http.put('/rest/sizes/update/' + sizeitem.sizeID, sizeitem).then(resp => {
			var index = $scope.sizeitems.findIndex(p => p.sizeID == sizeitem.sizeID);
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.sizeitems[index] = sizeitem;
			$scope.messageSuccess = "Cập nhật thành công";
			$('#errorModal1').modal('show');
			$scope.initialize();
			$scope.reset();
		}).catch(error => {
			$scope.errorMessage = "Cập nhật thất bại";
			$('#errorModal').modal('show');
			$scope.initialize();
			console.log("Error", error);
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
	$scope.confirmHideModal1 = function(sizeitem) {
		$scope.form = angular.copy(sizeitem);
		$('#confirmHideModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa vào thùng rác
	$scope.confirmHide = function() {
		var sizeitem = angular.copy($scope.form);
		sizeitem.deleted = true;
		sizeitem.modifyDate = new Date();
		$http.put('/rest/sizes/update/' + sizeitem.sizeID, sizeitem).then(resp => {
			var index = $scope.sizeitems.findIndex(p => p.sizeID == sizeitem.sizeID);
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.sizeitems[index] = sizeitem;
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show');
			$scope.initialize();
			$scope.reset();
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show');
			$scope.initialize();
			$scope.reset();
			console.log("Error", error);
		})

		// Đóng modal thùng rác
		$('#confirmHideModal').modal('hide');
	}

	//Gọi đến modal xác nhận để khôi phục item từ thùng rác
	$scope.confirmRestoreModal1 = function(sizeitem) {
		$scope.form = angular.copy(sizeitem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmRestoreModal').modal('show');
	}

	//Khôi phục item từ thùng rác
	$scope.restore = function() {
		var sizeitem = angular.copy($scope.form);
		sizeitem.deleted = false;
		sizeitem.modifyDate = new Date();
		$http.put('/rest/sizes/update/' + sizeitem.sizeID, sizeitem).then(resp => {
			var index = $scope.sizeitemsLoadAll.findIndex(p => p.sizeID == sizeitem.sizeID);
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.sizeitemsLoadAll[index] = sizeitem;

			// Đóng modal thùng rác
			$('#recycleBinModal').modal('hide');

			$scope.messageSuccess = "khôi phục thành công";
			$('#errorModal1').modal('show');
			$scope.initialize();
			$scope.reset();
		}).catch(error => {
			// Đóng modal thùng rác
			$('#recycleBinModal').modal('hide');

			$scope.errorMessage = "Khôi phục thất bại";
			$('#errorModal').modal('show');
			$scope.initialize();
			$scope.reset();
			console.log("Error", error);
		})

		// Đóng modal thùng rác
		$('#confirmRestoreModal').modal('hide');
	}

	//Gọi đến modal xác nhận để xóa luôn
	$scope.confirmDeleteModal1 = function(sizeitem) {
		$scope.form = angular.copy(sizeitem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa
		$http.delete('/rest/sizes/delete/' + $scope.form.sizeID).then(resp => {
			var index = $scope.sizeitems.findIndex(p => p.sizeID == $scope.form.sizeID);
			$scope.sizeitems.splice(index, 1);
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