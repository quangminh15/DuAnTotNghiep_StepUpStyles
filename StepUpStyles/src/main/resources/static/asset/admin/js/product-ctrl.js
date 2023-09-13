app.controller("product-ctrl", function($scope, $http) {
	$scope.productitems = [];
	$scope.cates = [];
	$scope.brans = [];
	$scope.orderdetails = [];
	$scope.form = {};
	$scope.form.category = {};
	$scope.form.brand = {};
	$scope.errorMessage = '';
	$scope.userDetails = null;

	$scope.sortableColumns = [
		{ name: 'productID', label: 'Mã sản phẩm' },
		{ name: 'createdDate', label: 'Thời gian' },
		{ name: 'productName', label: 'Tên sản phẩm' },
		{ name: 'price', label: 'Giá' },
		{ name: 'category.categoryName', label: 'Danh mục' },
		{ name: 'brand.brandName', label: 'Thương hiệu' },
		{ name: 'activities', label: 'Trạng thái' },
		{ name: 'featured', label: 'Nổi bật' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.productitems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'category.categoryName') {
				aValue = a.category.categoryName;
				bValue = b.category.categoryName;
			}
			if (columnName === 'brand.brandName') {
				aValue = a.brand.brandName;
				bValue = b.brand.brandName;
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
		get productitems() {
			var start = this.page * this.size;
			return $scope.productitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productitems.length / this.size);
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

	//Mở modal tìm kiếm
	$scope.openSearchForm = function() {
		// Reset searchKeyword
		$scope.searchKeyword = '';
		$('#searchModal').modal('show');
	};

	// Tìm kiếm màu 
	$scope.searchProductByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/products/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.productitems = resp.data;
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

	$scope.initialize = function() {
		//load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.productitems = resp.data;
			$scope.productitems.forEach(productitem => {
				productitem.createdDate = new Date(productitem.createdDate)
			})
			$scope.productitems.sort((a, b) => b.createdDate - a.createdDate);
			$scope.pager.first();
		});

		//load category
		$http.get("/rest/categories/loadall").then(resp => {
			$scope.cates = resp.data;
			$scope.pager.first();
		});

		//load brand
		$http.get("/rest/brands/loadall").then(resp => {
			$scope.brans = resp.data;
			$scope.pager.first();
		});
	}

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			createDate: new Date(),
			activities: false,
			deleted: false,
			featured: false,
		};
	}

	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(productitem) {
		$scope.form = angular.copy(productitem);
	}

	//	function checkDuplicateProduct(productitem) {
	//		var isDuplicate = $scope.productitems.some(function(item) {
	//			return (
	//				item.category.categoryID === productitem.category.categoryID &&
	//				item.productName === productitem.productName
	//			);
	//		});
	//
	//		return isDuplicate;
	//	}

	//	Thêm sản phẩm mới 
	$scope.create = function() {
		//Không chọn danh mục
		if (!$scope.form.category || !$scope.form.category.categoryID) {
			$scope.errorMessage = "Vui lòng chọn danh mục!";
			$('#errorModal').modal('show');
			return;
		}

		//Không chọn thương hiệu
		if (!$scope.form.brand || !$scope.form.brand.brandID) {
			$scope.errorMessage = "Vui lòng chọn thương hiệu!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi bỏ trống tên sản phẩm 
		if (!$scope.form.productName) {
			$scope.errorMessage = "Vui lòng nhập tên sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		// Kiểm tra sự trùng lặp
		//		var isDuplicate = checkDuplicateProduct($scope.form);
		//		if (isDuplicate) {
		//			$scope.errorMessage = "Đã tồn tại sản phẩm trong danh mục này rồi. Vui lòng đặt tên khác cho sản phẩm!";
		//			$('#errorModal').modal('show');
		//			return;
		//		}

		//Lỗi bỏ trống giá sản phẩm 
		if (!$scope.form.price) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi giá sản phẩm < 0
		if ($scope.form.price < 0) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm lớn hơn 0!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi giá sản phẩm > 100.000.000
		if ($scope.form.price > 100000000) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm nhỏ hơn 100.000.000đ!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi bỏ trống mô tả
		if (!$scope.form.description) {
			$scope.errorMessage = "Vui lòng nhập mô tả sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lấy thông tin người dùng từ API /api/user (email)
		$http.get("/api/user").then(resp => {
			const email = resp.data.username; // Lấy email từ userDetails
			// Truy vấn cơ sở dữ liệu để lấy userID từ email
			$http.get("/rest/users/by-email/" + email).then(userResp => {
				var userID = userResp.data.userID;
				$scope.form.user = { userID: userID }; // Gán userID cho sản phẩm

				var currentDate = new Date(); // Lấy ngày hiện tại
				$scope.form.createdDate = currentDate; // Gán ngày hiện tại cho createdDate

				var productitem = angular.copy($scope.form);
				productitem.user.userID = userID;
				productitem.createdDate = currentDate;
				$http.post('/rest/products/create', productitem).then(resp => {
					resp.data.createdDate = new Date(resp.data.createdDate);
					$scope.productitems.push(resp.data);
					$scope.reset();
					$scope.errorMessage = ''; // Xóa thông báo lỗi khi thành công
					$scope.messageSuccess = "Thêm mới thành công";
					$scope.initialize();
					$('#errorModal1').modal('show');
				}).catch(error => {
					if (error.status === 400) {
						$scope.errorMessage = error.data;
					} else {
						$scope.messageSuccess = "Thêm mới thành công";
						$('#errorModal1').modal('show');
						//$scope.errorMessage = "Thêm mới thất bại";
						$scope.initialize();
						//$('#errorModal').modal('show');
						console.log("Error", error);
					}
				});
			}).catch(error => {
				console.log("Lỗi không tìm thấy người dùng có email", error);
				$scope.initialize();
				// Xử lý lỗi khi không lấy được userID từ email
			});
		}).catch(error => {
			console.log("Lỗi khi không lấy được dữ liệu người dùng", error);
			$scope.initialize();
		});
	}

	//	Cập nhật sản phẩm 
	$scope.update = function() {
		//Không chọn danh mục
		if (!$scope.form.category || !$scope.form.category.categoryID) {
			$scope.errorMessage = "Vui lòng chọn danh mục!";
			$('#errorModal').modal('show');
			return;
		}

		//Không chọn thương hiệu
		if (!$scope.form.brand || !$scope.form.brand.brandID) {
			$scope.errorMessage = "Vui lòng chọn thương hiệu!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi bỏ trống tên sản phẩm 
		if (!$scope.form.productName) {
			$scope.errorMessage = "Vui lòng nhập tên sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		// Kiểm tra sự trùng lặp
		//		var isDuplicate = checkDuplicateProduct($scope.form);
		//		if (isDuplicate) {
		//			$scope.errorMessage = "Đã tồn tại sản phẩm trong danh mục này rồi. Vui lòng đặt tên khác cho sản phẩm!";
		//			$('#errorModal').modal('show');
		//			return;
		//		}

		//Lỗi bỏ trống giá sản phẩm 
		if (!$scope.form.price) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi giá sản phẩm < 0
		if ($scope.form.price < 0) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm lớn hơn 0!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi giá sản phẩm > 100.000.000
		if ($scope.form.price > 100000000) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm nhỏ hơn 100.000.000đ!!";
			$('#errorModal').modal('show');
			return;
		}

		//Lỗi bỏ trống mô tả
		if (!$scope.form.description) {
			$scope.errorMessage = "Vui lòng nhập mô tả sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lấy thông tin người dùng từ API /api/user (email)
		$http.get("/api/user").then(resp => {
			const email = resp.data.username; // Lấy email từ userDetails
			// Truy vấn cơ sở dữ liệu để lấy userID từ email
			$http.get("/rest/users/by-email/" + email).then(userResp => {
				var userID = userResp.data.userID;
				$scope.form.user = { userID: userID }; // Gán userID cho sản phẩm

				var currentDate = new Date(); // Lấy ngày hiện tại
				$scope.form.createdDate = currentDate; // Gán ngày hiện tại cho createdDate

				var productitem = angular.copy($scope.form);
				productitem.user.userID = userID;
				productitem.createdDate = currentDate;
				$http.put('/rest/products/update/' + productitem.productID, productitem).then(resp => {
					var index = $scope.productitems.findIndex(p => p.productID == productitem.productID);
					resp.data.createdDate = new Date(resp.data.createdDate);
					$scope.productitems[index] = productitem;
					$scope.messageSuccess = "Cập nhật thành công";
					$scope.initialize();
					$('#errorModal1').modal('show');
				}).catch(error => {
					$scope.errorMessage = "Cập nhật thất bại";
					$('#errorModal').modal('show');
					$scope.initialize();
					console.log("Error", error);
				})
			}).catch(error => {
				console.log("Error fetching userID from email", error);
				// Xử lý lỗi khi không lấy được userID từ email
			});
		}).catch(error => {
			console.log("Error fetching user data", error);
			// Xử lý lỗi khi không lấy được dữ liệu người dùng
		});
	}

	//Gọi đến modal xác nhận để xóa
	$scope.confirmDeleteModal = function() {
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDeleteModal1 = function(productitem) {
		$scope.form = angular.copy(productitem);
		$('#confirmDeleteModal').modal('show');
	}


	//sau khi xác nhận thành công thì xóa
	$scope.confirmDelete = function() {
		// Thực hiện xóa 
		$http.delete('/rest/products/delete/' + $scope.form.productID).then(resp => {
			var index = $scope.productitems.findIndex(p => p.productID == $scope.form.productID);
			$scope.productitems.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
			$scope.initialize();
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