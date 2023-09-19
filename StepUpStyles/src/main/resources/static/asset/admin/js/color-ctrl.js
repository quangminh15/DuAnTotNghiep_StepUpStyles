app.controller("color-ctrl", function($scope, $http) {
	$scope.coloritems = [];
	$scope.coloritemss = [];
	$scope.coloritemsLoadAll = [];
	$scope.prods = [];
	$scope.productNames = [];
	$scope.form = {};
	$scope.form.product = {};
	$scope.errorMessage = '';
	$scope.messageSuccess = '';
	$scope.selectedActivity = "all";

	$scope.sortableColumns = [
		{ name: 'colorID', label: 'Mã màu' },
		{ name: 'colorName', label: 'Tên màu' },
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

		$scope.coloritems.sort(function(a, b) {
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
		get coloritems() {
			var start = this.page * this.size;
			return $scope.coloritems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.coloritems.length / this.size);
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
		get coloritemss() {
			var start = this.page * this.size;
			return $scope.coloritemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.coloritemss.length / this.size);
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
		//load coloritems hết luôn
		$http.get("/rest/colors/loadall").then(resp => {
			$scope.coloritemsLoadAll = resp.data;
			$scope.coloritemsLoadAll.forEach(coloritem => {
				coloritem.modifyDate = new Date(coloritem.modifyDate)
			})
			$scope.coloritemsLoadAll.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load coloritems 
		$http.get("/rest/colors/loadallNoDeleted").then(resp => {
			$scope.coloritems = resp.data;
			$scope.coloritems.forEach(coloritem => {
				coloritem.modifyDate = new Date(coloritem.modifyDate)
			})
			$scope.coloritems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load coloritems đã xóa
		$http.get("/rest/colors/loadallDeleted").then(resp => {
			$scope.coloritemss = resp.data;
			$scope.coloritemss.forEach(coloritem => {
				coloritem.modifyDate = new Date(coloritem.modifyDate)
			})
			$scope.coloritemss.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

	//Mở modal tìm kiếm
	$scope.openSearchForm = function() {
		// Reset searchKeyword
		$scope.searchKeyword = '';
		$('#searchModal').modal('show');
	};

	// Tìm kiếm màu 
	$scope.searchColorByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/colors/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.coloritems = resp.data;
				$scope.pager.first();
				console.log("Kết quả tìm kiếm ", resp.data);

				if (resp.data.length === 0) {
					$scope.initialize();
					$scope.errorMessage = `Không tìm thấy màu có tên "${$scope.searchKeyword}"`;
					$('#errorModal').modal('show');
				}
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tìm kiếm màu!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			$scope.errorMessage = "Không tìm thấy màu mà bạn mong muốn!";
			$('#errorModal').modal('show');
		}
		$('#searchModal').modal('hide');
	};



	$scope.filterByActivities = function() {
		if ($scope.selectedActivity === "all") {
			$http.get("/rest/colors/loadallNoDeleted").then(resp => {
				$scope.coloritems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách màu sắc!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/colors/loadallNoDeleted").then(resp => {
				const selectedStatus = $scope.selectedActivity === "true";
				const filteredColors = resp.data.filter(color => color.activities === selectedStatus);
				$scope.coloritems = filteredColors;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách màu sắc theo trạng thái!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};


	// Hàm giới hạn độ dài của đường dẫn
	$scope.truncateUrl = function(url) {
		const maxLength = 50; // Độ dài tối đa bạn muốn hiển thị
		if (url.length > maxLength) {
			return url.substring(0, maxLength) + '...';
		} else {
			return url;
		}
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
	$scope.edit = function(coloritem) {
		$scope.form = angular.copy(coloritem);
	}

	//	Thêm mới 
	$scope.create = function() {

		//Lỗi bỏ trống tên màu
		if (!$scope.form.colorName) {
			$scope.errorMessage = "Vui lòng nhập tên màu!!";
			$('#errorModal').modal('show');
			return;
		}

		// Thực hiện việc lưu vào db
		var coloritem = angular.copy($scope.form);
		coloritem.deleted = false;
		coloritem.modifyDate = new Date();
		$http.post('/rest/colors/create', coloritem).then(resp => {
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.coloritems.push(resp.data);
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
				$scope.initialize();
				console.log("Error", error);
			}
		});
	}

	//Cập nhật
	$scope.update = function() {

		//Lỗi bỏ trống tên màu
		if (!$scope.form.colorName) {
			$scope.errorMessage = "Vui lòng nhập tên màu!!";
			$('#errorModal').modal('show');
			return;
		}

		var coloritem = angular.copy($scope.form);
		coloritem.modifyDate = new Date();
		$http.put('/rest/colors/update/' + coloritem.colorID, coloritem).then(resp => {
			var index = $scope.coloritems.findIndex(p => p.colorID == coloritem.colorID);
			resp.data.modifyDate = new Date(resp.data.modifyDate); $scope.coloritems[index] = coloritem;
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
	$scope.confirmHideModal1 = function(coloritem) {
		$scope.form = angular.copy(coloritem);
		$('#confirmHideModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa vào thùng rác
	$scope.confirmHide = function() {
		var coloritem = angular.copy($scope.form);
		coloritem.deleted = true;
		coloritem.modifyDate = new Date();
		$http.put('/rest/colors/update/' + coloritem.colorID, coloritem).then(resp => {
			var index = $scope.coloritems.findIndex(p => p.colorID == coloritem.colorID);
			resp.data.modifyDate = new Date(resp.data.modifyDate); $scope.coloritems[index] = coloritem;
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
	$scope.confirmRestoreModal1 = function(coloritem) {
		$scope.form = angular.copy(coloritem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmRestoreModal').modal('show');
	}

	//Khôi phục item từ thùng rác
	$scope.restore = function() {
		var coloritem = angular.copy($scope.form);
		coloritem.deleted = false;
		coloritem.modifyDate = new Date();
		$http.put('/rest/colors/update/' + coloritem.colorID, coloritem).then(resp => {
			var index = $scope.coloritemsLoadAll.findIndex(p => p.colorID == coloritem.colorID);
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.coloritemsLoadAll[index] = coloritem;

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
	$scope.confirmDeleteModal1 = function(coloritem) {
		$scope.form = angular.copy(coloritem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa
		$http.delete('/rest/colors/delete/' + $scope.form.colorID).then(resp => {
			var index = $scope.coloritems.findIndex(p => p.colorID == $scope.form.colorID);
			$scope.coloritems.splice(index, 1);
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
})