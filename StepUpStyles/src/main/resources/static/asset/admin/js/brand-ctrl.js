app.controller("brand-ctrl", function($scope, $http) {
	$scope.branditems = [];
	$scope.branditemss = [];
	$scope.branditemsLoadAll = [];
	$scope.form = {};
	$scope.errorMessage = '';
	$scope.selectedActivity = "all";

	$scope.sortableColumns = [
		{ name: 'brandID', label: 'Mã thương hiệu' },
		{ name: 'brandName', label: 'Tên thương hiệu' },
		{ name: 'brandImage', label: 'Hình ảnh' },
		{ name: 'activities', label: 'Trạng thái' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.branditems.sort(function(a, b) {
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
		size: 2,
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
		get branditems() {
			var start = this.page * this.size;
			return $scope.branditems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.branditems.length / this.size);
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
		get branditemss() {
			var start = this.page * this.size;
			return $scope.branditemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.branditemss.length / this.size);
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
				$scope.form.brandImage = url;
				console.log($scope.form.brandImage)
			});
	};

	$scope.filterByActivities = function() {
		if ($scope.selectedActivity === "all") {
			$http.get("/rest/brands/loadallNoDeleted").then(resp => {
				$scope.branditems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách thương hiệu!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/brands/loadallNoDeleted").then(resp => {
				const selectedStatus = $scope.selectedActivity === "true";
				const filteredBrands = resp.data.filter(brand => brand.activities === selectedStatus);
				$scope.branditems = filteredBrands;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách thương hiệu theo trạng thái!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};

	$scope.initialize = function() {
		//load branditems hết luôn
		$http.get("/rest/brands/loadall").then(resp => {
			$scope.branditemsLoadAll = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load branditems 
		$http.get("/rest/brands/loadallNoDeleted").then(resp => {
			$scope.branditems = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load branditems đã xóa
		$http.get("/rest/brands/loadallDeleted").then(resp => {
			$scope.branditemss = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

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
	$scope.edit = function(branditem) {
		$scope.form = angular.copy(branditem);
	}

	//Mở modal tìm kiếm
	$scope.openSearchForm = function() {
		// Reset searchKeyword
		$scope.searchKeyword = '';
		$('#searchModal').modal('show');
	};

	// Tìm kiếm  
	$scope.searchProductGroupByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/brands/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.branditems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					$scope.errorMessage = `Không tìm thấy thương hiệu có tên "${$scope.searchKeyword}"`;
					$('#errorModal').modal('show');
				}
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tìm kiếm thương hiệu!";
				$('#errorModal').modal('show'); // Hiển thị modal lỗi
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			$scope.errorMessage = "Không tìm thấy tên thương hiệu mà bạn mong muốn!";
			$('#errorModal').modal('show'); // Hiển thị modal lỗi
		}
		$('#searchModal').modal('hide');
	};


	//	Thêm mới 
	$scope.create = async function() {
		//Lỗi trùng tên nhóm sản phẩm
		let existingBrandName = $scope.branditems.find(branditem => branditem.brandName === $scope.form.brandName);
		if (existingBrandName) {
			$scope.errorMessage = "Tên thương hiệu đã tồn tại!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.brandName) {
			$scope.errorMessage = "Vui lòng nhập tên thương hiệu!!";
			$('#errorModal').modal('show');
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
			var branditem = angular.copy($scope.form);
			branditem.brandImage = $scope.form.brandImage;
			branditem.deleted = false;
			$http.post('/rest/brands/create', branditem).then(resp => {
				$scope.branditems.push(resp.data);
				$scope.reset();
				$scope.errorMessage = ''; // Xóa thông báo lỗi khi thành công
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
		if (!$scope.form.brandName) {
			$scope.errorMessage = "Vui lòng nhập tên thương hiệu!!";
			$('#errorModal').modal('show');
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

			var branditem = angular.copy($scope.form);
			branditem.brandImage = $scope.form.brandImage;
			$http.put('/rest/brands/update/' + branditem.brandID, branditem).then(resp => {
				var index = $scope.branditems.findIndex(p => p.brandID == branditem.brandID);
				$scope.branditems[index] = branditem;
				$scope.messageSuccess = "Cập nhật thành công";
				$('#errorModal1').modal('show');
				$scope.initialize();
				console.log("branditem", branditem);
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
	$scope.confirmHideModal1 = function(branditem) {
		$scope.form = angular.copy(branditem);
		$('#confirmHideModal').modal('show');
	}
	
	//sau khi xác nhận thành công thì xóa vào thùng rác
	$scope.confirmHide = function() {
		var branditem = angular.copy($scope.form);
		branditem.deleted = true;
		$http.put('/rest/brands/update/' + branditem.brandID, branditem).then(resp => {
			var index = $scope.branditems.findIndex(p => p.brandID == branditem.brandID);
			$scope.branditems[index] = branditem;
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
	$scope.confirmRestoreModal1 = function(branditem) {
		$scope.form = angular.copy(branditem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmRestoreModal').modal('show');
	}
	
	//Khôi phục item từ thùng rác
	$scope.restore = function() {
		var branditem = angular.copy($scope.form);
		branditem.deleted = false;
		$http.put('/rest/brands/update/' + branditem.brandID, branditem).then(resp => {
			var index = $scope.branditemsLoadAll.findIndex(p => p.brandID == branditem.brandID);
			$scope.branditemsLoadAll[index] = branditem;

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
	$scope.confirmDeleteModal1 = function(branditem) {
		$scope.form = angular.copy(branditem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa 
		$http.delete('/rest/brands/delete/' + $scope.form.brandID).then(resp => {
			var index = $scope.branditems.findIndex(p => p.brandID == $scope.form.brandID);
			$scope.branditems.splice(index, 1);
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

