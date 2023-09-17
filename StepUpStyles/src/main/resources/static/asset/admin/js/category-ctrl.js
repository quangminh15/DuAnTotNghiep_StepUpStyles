app.controller("category-ctrl", function($scope, $http) {
	$scope.categoryitems = [];
	$scope.categoryitemss = [];
	$scope.categoryitemsLoadAll = [];
	$scope.prodgroups = [];
	$scope.form = {};
	$scope.form.productGroup = {};
	$scope.errorMessage = '';
	$scope.selectedActivity = "all";

	$scope.sortableColumns = [
		{ name: 'categoryID', label: 'Mã danh mục' },
		{ name: 'categoryName', label: 'Tên danh mục' },
		{ name: 'categoryImage', label: 'Hình ảnh' },
		{ name: 'activities', label: 'Trang thái' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.categoryitems.sort(function(a, b) {
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
		get categoryitems() {
			var start = this.page * this.size;
			return $scope.categoryitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.categoryitems.length / this.size);
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
		get categoryitemss() {
			var start = this.page * this.size;
			return $scope.categoryitemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.categoryitemss.length / this.size);
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

	// Tải ảnh lên Firebase	
	$scope.uploadImages = function() {
		var ref = firebase.storage().ref();
		var folder = 'Brand';
		var file = document.querySelector('#photo').files[0];
		var metadata = {
			contentType: file.type
		};
		var name = folder + '/' + file.name; // Tạo tên file với thư mục

		var uploadIMG = ref.child(name).put(file, metadata);

		return uploadIMG.then(snapshot => snapshot.ref.getDownloadURL())
			.then(url => {
				$scope.form.categoryImage = url;
				console.log($scope.form.categoryImage)
			});
	};

	$scope.initialize = function() {
		//load categoryitems hết luôn
		$http.get("/rest/categories/loadall").then(resp => {
			$scope.categoryitemsLoadAll = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load categoryitems 
		$http.get("/rest/categories/loadallNoDeleted").then(resp => {
			$scope.categoryitems = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load categoryitems đã xóa
		$http.get("/rest/categories/loadallDeleted").then(resp => {
			$scope.categoryitemss = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

	$scope.filterByActivities = function() {
		if ($scope.selectedActivity === "all") {
			$http.get("/rest/categories/loadallNoDeleted").then(resp => {
				$scope.categoryitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách danh mục sản phẩm màu sắc!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/categories/loadallNoDeleted").then(resp => {
				const selectedStatus = $scope.selectedActivity === "true";
				const filteredCategories = resp.data.filter(category => category.activities === selectedStatus);
				$scope.categoryitems = filteredCategories;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách danh mục sản phẩm theo trạng thái!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};

	//Mở modal tìm kiếm
	$scope.openSearchForm = function() {
		// Reset searchKeyword
		$scope.searchKeyword = '';
		$('#searchModal').modal('show');
	};

	// Tìm kiếm màu 
	$scope.searchProductCateByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/categories/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.categoryitems = resp.data;
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
			activities: false,
			deleted: false,
		};
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(categoryitem) {
		$scope.form = angular.copy(categoryitem);
	}


	//	Thêm mới 
	$scope.create = async function() {
		//Lỗi bỏ trống 
		if (!$scope.form.categoryName) {
			$scope.errorMessage = "Vui lòng nhập tên danh mục sản phẩm!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi không chọn ảnh
		if (!document.querySelector('#photo').files[0]) {
			$scope.errorMessage = "Bạn chưa chọn ảnh";
			$('#errorModal').modal('show');
			return; // Dừng tiến trình nếu không chọn ảnh
		};

		try {
			await $scope.uploadImages(); // Tải ảnh lên Firebase

			// Thực hiện việc lưu vào db
			var categoryitem = angular.copy($scope.form);
			categoryitem.categoryImage = $scope.form.categoryImage;
			categoryitem.deleted = false;
			$http.post('/rest/categories/create', categoryitem).then(resp => {
				$scope.categoryitems.push(resp.data);
				$scope.reset();
				$scope.errorMessage = '';
				$scope.messageSuccess = "Thêm mới thành công";
				$('#errorModal1').modal('show');
				$scope.initialize();
				console.log(resp)
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
		} catch (error) {
			$scope.errorMessage = "Tải ảnh lên firebase thất bại";
			$('#errorModal').modal('show');
			$scope.initialize();
		}
	}

	//	Cập nhật  
	$scope.update = async function() {
		//Lỗi bỏ trống 
		if (!$scope.form.categoryName) {
			$scope.errorMessage = "Vui lòng nhập tên danh mục sản phẩm!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi không chọn ảnh 
		if (!document.querySelector('#photo').files[0]) {
			$scope.errorMessage = "Bạn chưa chọn ảnh";
			$('#errorModal').modal('show');
			return; // Dừng tiến trình nếu không chọn ảnh
		}

		try {
			await $scope.uploadImages(); // Tải ảnh lên Firebase

			var categoryitem = angular.copy($scope.form);
			categoryitem.categoryImage = $scope.form.categoryImage;
			$http.put('/rest/categories/update/' + categoryitem.categoryID, categoryitem).then(resp => {
				var index = $scope.categoryitems.findIndex(p => p.categoryID == categoryitem.categoryID);
				$scope.categoryitems[index] = categoryitem;
				$scope.messageSuccess = "Cập nhật thành công";
				$('#errorModal1').modal('show');
				$scope.initialize();
				console.log("categoryitem", categoryitem);
			}).catch(error => {
				$scope.errorMessage = "Cập nhật thất bại";
				$('#errorModal').modal('show');
				$scope.initialize();
				console.log("Error", error);
			})
		} catch (error) {
			$scope.errorMessage = "Tải ảnh lên firebase thất bại";
			$('#errorModal').modal('show');
			$scope.initialize();
		}
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
	$scope.confirmHideModal1 = function(categoryitem) {
		$scope.form = angular.copy(categoryitem);
		$('#confirmHideModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa vào thùng rác
	$scope.confirmHide = function() {
		var categoryitem = angular.copy($scope.form);
		categoryitem.deleted = true;
		$http.put('/rest/categories/update/' + categoryitem.categoryID, categoryitem).then(resp => {
			var index = $scope.categoryitems.findIndex(p => p.categoryID == categoryitem.categoryID);
			$scope.categoryitems[index] = categoryitem;
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
	$scope.confirmRestoreModal1 = function(categoryitem) {
		$scope.form = angular.copy(categoryitem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmRestoreModal').modal('show');
	}

	//Khôi phục item từ thùng rác
	$scope.restore = function() {
		var categoryitem = angular.copy($scope.form);
		categoryitem.deleted = false;
		$http.put('/rest/categories/update/' + categoryitem.categoryID, categoryitem).then(resp => {
			var index = $scope.categoryitemsLoadAll.findIndex(p => p.categoryID == categoryitem.categoryID);
			$scope.categoryitemsLoadAll[index] = categoryitem;

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
	$scope.confirmDeleteModal1 = function(categoryitem) {
		$scope.form = angular.copy(categoryitem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa
		$http.delete('/rest/categories/delete/' + $scope.form.categoryID).then(resp => {
			var index = $scope.categoryitems.findIndex(p => p.categoryID == $scope.form.categoryID);
			$scope.categoryitems.splice(index, 1);
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