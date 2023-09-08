app.controller("color-ctrl", function($scope, $http) {
	$scope.coloritems = [];
	$scope.prods = [];
	$scope.productNames = [];
	$scope.form = {};
	$scope.form.product = {};
	$scope.errorMessage = '';
	$scope.messageSuccess = '';

	$scope.sortableColumns = [
		{ name: 'colorID', label: 'Mã màu' },
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		{ name: 'colorName', label: 'Tên màu' },
		{ name: 'imagePath', label: 'Hình ảnh' },
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

	$scope.initialize = function() {
		//load colors
		$http.get("/rest/colors/loadall").then(resp => {
			$scope.coloritems = resp.data;
			console.log($scope.coloritems)
			$scope.pager.first();
		});

		//load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
			console.log($scope.prods)
			$scope.coloritems.forEach(productitem => {
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
	$scope.searchColorByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/colors/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.coloritems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					$scope.errorMessage = `Không tìm thấy sản phẩm có tên "${$scope.searchKeyword}"`;
					$('#errorModal').modal('show');
				}
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tìm kiếm màu sản phẩm!";
				$('#errorModal').modal('show'); // Hiển thị modal lỗi
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			$scope.errorMessage = "Không tìm thấy màu mà bạn mong muốn!";
			$('#errorModal').modal('show'); // Hiển thị modal lỗi
		}
		$('#searchModal').modal('hide');
	};


	$scope.filterByProduct = function() {
		if ($scope.selectedProduct) {
			$http.get("/rest/colors/loadbyproduct/" + $scope.selectedProduct).then(resp => {
				$scope.coloritems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tải danh sách màu sắc theo sản phẩm!";
				$('#errorModal').modal('show'); // Show the modal
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có sản phẩm được chọn, hiển thị tất cả màu sắc
			$scope.initialize();
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

	// Tải ảnh lên Firebase	
	$scope.uploadImages = function() {
		var ref = firebase.storage().ref();
		var folder = 'productColor';
		var file = document.querySelector('#photo').files[0];
		var metadata = {
			contentType: file.type
		};
		var name = folder + '/' + file.name; // Tạo tên file với thư mục

		var uploadIMG = ref.child(name).put(file, metadata);

		return uploadIMG.then(snapshot => snapshot.ref.getDownloadURL())
			.then(url => {
				// Lưu đường dẫn ảnh vào biến $scope.form.imagePath
				$scope.form.imagePath = url;
			});
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
	$scope.edit = function(coloritem) {
		$scope.form = angular.copy(coloritem);
	}

	function checkDuplicateColor(coloritem) {
		// Kiểm tra sự trùng lặp dựa trên productID, sizeID và colorID
		var isDuplicate = $scope.coloritems.some(function(item) {
			return (
				item.product.productID === coloritem.product.productID &&
				item.colorName === coloritem.colorName
			);
		});

		return isDuplicate;
	}

	//	Thêm mới 
	$scope.create = async function() {

		//Lỗi không chọn sản phẩm 
		if (!$scope.form.product.productID) {
			$scope.errorMessage = "Bạn chưa chọn sản phẩm";
			$('#errorModal').modal('show');
			return; // Dừng tiến trình nếu không chọn sản phẩm
		}

		//Lỗi bỏ trống tên màu
		if (!$scope.form.colorName) {
			$scope.errorMessage = "Vui lòng nhập tên màu!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		// Kiểm tra sự trùng lặp
		var isDuplicate = checkDuplicateColor($scope.form);
		if (isDuplicate) {
			$scope.errorMessage = "Sản phẩm mà bạn chọn đã có màu này rồi. Vui lòng nhập màu khác!";
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

			// Thực hiện việc lưu vào db
			var coloritem = angular.copy($scope.form);
			coloritem.imagePath = $scope.form.imagePath;
			$http.post('/rest/colors/create', coloritem).then(resp => {
				$scope.coloritems.push(resp.data);
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
					$scope.initialize();
					console.log("Error", error);
				}
			});
		} catch (error) {
			$scope.errorMessage = "Tải ảnh lên firebase thất bại";
			$('#errorModal').modal('show'); // Show the modal
			$scope.initialize();
		}
	}

	//	Cập nhật  
	$scope.update = async function() {
		//Lỗi không chọn sản phẩm 
		if (!$scope.form.product.productID) {
			$scope.errorMessage = "Bạn chưa chọn sản phẩm";
			$('#errorModal').modal('show');
			return; // Dừng tiến trình nếu không chọn sản phẩm
		}

		//Lỗi bỏ trống tên màu
		if (!$scope.form.colorName) {
			$scope.errorMessage = "Vui lòng nhập tên màu!!";
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

			var coloritem = angular.copy($scope.form);
			coloritem.imagePath = $scope.form.imagePath;
			$http.put('/rest/colors/update/' + coloritem.colorID, coloritem).then(resp => {
				var index = $scope.coloritems.findIndex(p => p.colorID == coloritem.colorID);
				$scope.coloritems[index] = coloritem;
				$scope.messageSuccess = "Cập nhật thành công";
				$('#errorModal1').modal('show'); // Show the modal
				$scope.initialize();
			}).catch(error => {
				$scope.errorMessage = "Cập nhật thất bại";
				$('#errorModal').modal('show'); // Show the modal
				$scope.initialize();
				console.log("Error", error);
			})
		} catch (error) {
			$scope.errorMessage = "Tải ảnh lên firebase thất bại";
			$('#errorModal').modal('show'); // Show the modal
			$scope.initialize();
		}
	}

	//Gọi đến modal xác nhận để xóa
	$scope.confirmDeleteModal = function() {
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDeleteModal1 = function(coloritem) {
		$scope.form = angular.copy(coloritem);
		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa
	$scope.confirmDelete = function() {
		// Thực hiện xóa 
		$http.delete('/rest/colors/delete/' + $scope.form.colorID).then(resp => {
			var index = $scope.coloritems.findIndex(p => p.colorID == $scope.form.colorID);
			$scope.coloritems.splice(index, 1);
			$scope.reset();
			$scope.initialize();
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
			$scope.initialize();
		});

		// Đóng modal xác nhận xóa
		$('#confirmDeleteModal').modal('hide');
	}
})