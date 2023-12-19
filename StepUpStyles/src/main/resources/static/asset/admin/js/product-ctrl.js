
app.controller("product-ctrl", function($scope, $http) {
	$scope.productitems = [];
	$scope.productitemss = [];
	$scope.productitemsLoadAll = [];
	$scope.cates = [];
	$scope.brans = [];
	$scope.orderdetails = [];
	$scope.form = {};
	$scope.form.category = {};
	$scope.form.brand = {};
	$scope.userDetails = null;
	$scope.selectedActivity = "all";
	$scope.disableCreateButton = false;

	var checkImage = false;

	CKEDITOR.replace('description');

	$scope.sortableColumns = [
		{ name: 'productID', label: 'Mã sản phẩm' },
		{ name: 'modifyDate', label: 'Thời gian' },
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
		size: 10,
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
		get productitemss() {
			var start = this.page * this.size;
			return $scope.productitemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productitemss.length / this.size);
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

	// Tìm kiếm START 
	$scope.searchProductByName = async function() {
		const { value: searchKeyword } = await Swal.fire({
			title: 'Tìm kiếm tên sản phẩm',
			input: 'text',
			inputLabel: 'Nhập tên sản phẩm',
			inputPlaceholder: 'Nhập tên sản phẩm cần tìm kiếm'
		});

		if (searchKeyword && searchKeyword.trim() !== "") {
			$http.get("/rest/products/search", {
				params: { keyword: searchKeyword }
			}).then(resp => {
				$scope.productitems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy sản phẩm có tên ' + searchKeyword,
					});
				}
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tìm kiếm sản phẩm!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không tìm thấy tên sản phẩm mà bạn mong muốn!',
			});
		}
	};
	// Tìm kiếm END 

	$scope.initialize = function() {
		//load productitems hết luôn
		$http.get("/rest/products/loadall").then(resp => {
			$scope.productitemsLoadAll = resp.data;
			$scope.productitemsLoadAll.forEach(productitem => {
				productitem.modifyDate = new Date(productitem.modifyDate)
			})
			$scope.productitems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
			console.log("$scope.productitemsLoadAll: ", $scope.productitemsLoadAll)
		});

		//load productitems
		$http.get("/rest/products/loadallNoDeleted").then(resp => {
			$scope.productitems = resp.data;
			$scope.productitems.forEach(productitem => {
				productitem.modifyDate = new Date(productitem.modifyDate)
			})
			$scope.productitems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load productitems đã xóa
		$http.get("/rest/products/loadallDeleted").then(resp => {
			$scope.productitemss = resp.data;
			$scope.productitemss.forEach(productitem => {
				productitem.modifyDate = new Date(productitem.modifyDate)
			})
			$scope.productitems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load category
		$http.get("/rest/categories/loadallNoDeleted").then(resp => {
			$scope.cates = resp.data;
			$scope.pager.first();
		});

		//load brand
		$http.get("/rest/brands/loadallNoDeleted").then(resp => {
			$scope.brans = resp.data;
			$scope.pager.first();
		});
	}

	$scope.filterByActivities = function() {
		if ($scope.selectedActivity === "all") {
			$http.get("/rest/products/loadallNoDeleted").then(resp => {
				$scope.productitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách sản phẩm!',
				});

				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/products/loadallNoDeleted").then(resp => {
				const selectedStatus = $scope.selectedActivity === "true";
				const filteredSizes = resp.data.filter(product => product.activities === selectedStatus);
				$scope.productitems = filteredSizes;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách sản phẩm theo trạng thái!',
				});

				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};

	//	Xóa form
	$scope.reset = function() {
		// Đặt lại nội dung của CKEditor
		var ckeditor = CKEDITOR.instances.description;

		if (ckeditor) {
			ckeditor.setData('');
		}

		// Đặt lại các trường khác trong form
		$scope.form = {
			createDate: new Date(),
			activities: false,
			deleted: false,
			featured: false,
		};
		$scope.disableCreateButton = false;
	}

	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(productitem) {
		// Gọi API để lấy thông tin sản phẩm chi tiết dựa vào productID
		$http.get("/rest/products/" + productitem.productID).then(function(resp) {
			var productDetails = resp.data;
			console.log("productDetails: ", productDetails)
			$scope.form = angular.copy(productitem);
			// Cập nhật giá trị CKEditor
			$scope.form.description = productitem.description;
			CKEDITOR.instances.description.setData($scope.form.description);

			// Gọi API để lấy danh sách hình ảnh của sản phẩm dựa vào productId
			$http.get("/rest/productimages/loadbyproduct/" + productitem.productID).then(function(imageResp) {
				var productImages = imageResp.data;
				console.log("productImages: ", productImages)
				// Kiểm tra xem sản phẩm có hình ảnh hay không
				if (productImages.length > 0) {
					// Sản phẩm có hình ảnh, cho phép cập nhật sản phẩm
					checkImage = false;
				} else {
					// Sản phẩm không có ảnh và activities = true thì cho phép cập nhật sản phẩm
					checkImage = true;
				}
			}).catch(function(imageError) {
				console.error("Lỗi khi lấy danh sách hình ảnh:", imageError);
			});
		}).catch(function(error) {
			console.error("Lỗi khi lấy thông tin sản phẩm:", error);
		});
		 $scope.disableCreateButton = true;
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

	// Thêm sản phẩm mới
	$scope.create = function() {
		// Kiểm tra lỗi và thông báo
		if (!$scope.form.category || !$scope.form.category.categoryID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn danh mục!',
			});
			return;
		}

		if (!$scope.form.brand || !$scope.form.brand.brandID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thương hiệu!',
			});
			return;
		}

		if (!$scope.form.productName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên sản phẩm!',
			});
			return;
		}

		let existingProductName = $scope.productitems.find(productitem => productitem.productName === $scope.form.productName);
		if (existingProductName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tên sản phẩm đã tồn tại!',
			});
			return;
		}

		if (!$scope.form.price) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập giá sản phẩm!',
			});
			return;
		}

		if ($scope.form.price < 0) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập giá sản phẩm lớn hơn 0!',
			});
			return;
		}

		var descriptionEditor = CKEDITOR.instances.description;
		$scope.form.description = descriptionEditor.getData();

		if ($scope.form.price > 100000000) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập giá sản phẩm nhỏ hơn 100.000.000đ!',
			});
			return;
		}

		if (checkImage == true) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng thêm ảnh cho sản phẩm trước khi bật trạng thái hoạt động!',
			});
			return;
		}

		// Gọi API để lấy thông tin người dùng từ userID vừa nhận được
		$http.get("/user/Idprofile").then(resp => {
			var userID = resp.data;

			// Gọi API để lấy đầy đủ thông tin người dùng
			$http.get("/user/" + userID).then(userResp => {
				var fullUserData = userResp.data;
				$scope.form.user = fullUserData;

				$scope.form.modifyDate = new Date();

				// Tiếp tục với quá trình cập nhật dữ liệu vào cơ sở dữ liệu
				var productitem = angular.copy($scope.form);
				productitem.user = fullUserData;

				// Gọi API POST để tạo sản phẩm mới với thông tin sản phẩm đã chỉnh sửa
				$http.post('/rest/products/create', productitem).then(resp => {
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.productitems.push(resp.data);
					$scope.reset();
					$scope.initialize();

					Swal.fire({
						icon: 'success',
						title: 'Thành công',
						text: 'Thêm mới thành công!',
					});
					console.log("productitem:: ", productitem);
				}).catch(error => {
					// Xử lý lỗi khi không thể tạo mới sản phẩm
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Thêm mới thất bại!',
					});
					$scope.initialize();
					console.log("Error", error);
				});
			}).catch(error => {
				// Xử lý lỗi khi không thể lấy đầy đủ thông tin người dùng
				console.log("Error fetching full user data", error);
			});
		}).catch(error => {
			console.log("Error fetching userID from email", error);
			// Xử lý lỗi khi không lấy được userID từ email
		});
	}

	//	Cập nhật sản phẩm 
	$scope.update = function() {


		//Không chọn danh mục
		if (!$scope.form.category || !$scope.form.category.categoryID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn danh mục!',
			})
			return;
		}

		//Không chọn thương hiệu
		if (!$scope.form.brand || !$scope.form.brand.brandID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thương hiệu!',
			})
			return;
		}

		//Lỗi bỏ trống tên sản phẩm 
		if (!$scope.form.productName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên sản phẩm!',
			})
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
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập giá sản phẩm!',
			})
			return;
		}

		//Lỗi giá sản phẩm < 0
		if ($scope.form.price < 0) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập giá sản phẩm lớn hơn 0!',
			})
			return;
		}

		//Lỗi giá sản phẩm > 100.000.000
		if ($scope.form.price > 100000000) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập giá sản phẩm nhỏ hơn 100.000.000đ!',
			})
			return;
		}

//		 Lỗi khi cố gắng thay đổi trạng thái hoạt động khi thêm sản phẩm mới
				if (checkImage == true) {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Vui lòng thêm ảnh cho sản phẩm trước khi bật trạng thái hoạt động!',
					})
					return;
				}


		// Lấy giá trị từ CKEditor cho trường description và gán vào form.description
		var descriptionEditor = CKEDITOR.instances.description;
		$scope.form.description = descriptionEditor.getData();

		// Lấy thông tin người dùng từ API /user/Idprofile
		$http.get("/user/Idprofile").then(resp => {
			var userID = resp.data;
			$scope.form.user = { userID: userID }; // Gán userID cho sản phẩm

			$scope.form.modifyDate = new Date();

			// Gọi API để lấy thông tin người dùng từ userID vừa nhận được
			$http.get("/user/" + userID).then(response => {
				var user = response.data; // Lấy thông tin người dùng từ phản hồi

				// Gán thông tin người dùng vào form
				$scope.form.fullName = user.fullName;

				// Tiếp tục với quá trình cập nhật dữ liệu vào cơ sở dữ liệu
				var productitem = angular.copy($scope.form);
				productitem.user = user;

				// Gọi API PUT để cập nhật thông tin người dùng vào cơ sở dữ liệu
				$http.put('/rest/products/update/' + productitem.productID, productitem).then(resp => {
					// Xử lý phản hồi thành công
					var index = $scope.productitems.findIndex(p => p.productID == productitem.productID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.productitems[index] = productitem;
					$scope.initialize();
					Swal.fire({
						icon: 'success',
						title: 'Thành công',
						text: 'Cập nhật thành công!',
					});
					console.log("productitem:: ", productitem);
					$scope.disableCreateButton = false;
				}).catch(error => {
					// Xử lý lỗi khi không thể cập nhật
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Cập nhật thất bại!',
					});
					$scope.initialize();
					console.log("Error", error);
				});
			}).catch(error => {
				// Xử lý lỗi khi không thể lấy thông tin người dùng từ userID
				console.log("Error fetching user with ID", userID, error);
			});
		}).catch(error => {
			console.log("Error fetching userID from email", error);
			// Xử lý lỗi khi không lấy được userID từ email
		});

	}

	//Mở modal thùng rác
	$scope.openRecycleBinForm = function() {
		// Reset searchKeyword
		searchValue = '';
		$('#recycleBinModal').modal('show');
	};

	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở FORM) bắt đầu
	$scope.confirmHide = function() {
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa sản phẩm này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				var productitem = angular.copy($scope.form);
				productitem.deleted = true;
				productitem.modifyDate = new Date();
				$http.put('/rest/products/update/' + productitem.productID, productitem).then(resp => {
					var index = $scope.productitems.findIndex(p => p.productID == productitem.productID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.productitems[index] = productitem;
					Swal.fire({
						icon: 'success',
						title: 'Thành công',
						text: 'Xóa thành công',
					});
					$scope.initialize();
					$scope.reset();
				}).catch(error => {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Xóa thất bại!',
					});
					$scope.initialize();
					$scope.reset();
					console.log("Error", error);
				})
			}
		})
	}
	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở FORM) Kết thúc

	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở TABLE) bắt đầu
	$scope.confirmHideTable = function(productitem) {
		$scope.form = angular.copy(productitem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa sản phẩm này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				productitem.deleted = true;
				productitem.modifyDate = new Date();
				$http.put('/rest/products/update/' + productitem.productID, productitem).then(resp => {
					var index = $scope.productitems.findIndex(p => p.productID == productitem.productID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.productitems[index] = productitem;
					Swal.fire({
						icon: 'success',
						title: 'Thành công',
						text: 'Xóa thành công',
					});
					$scope.initialize();
					$scope.reset();
				}).catch(error => {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Xóa thất bại!',
					});
					$scope.initialize();
					$scope.reset();
					console.log("Error", error);
				})
			}
		})
	}
	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở TABLE) kết thúc	


	//sau khi xác nhận thành công thì khôi phục từ thùng rác (Nút khôi phục ở TABLE) bắt đầu
	$scope.restore = function(productitem) {
		$scope.form = angular.copy(productitem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn khôi phục sản phẩm này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			console.log(result)
			if (result.isConfirmed) {
				productitem.deleted = false;
				productitem.modifyDate = new Date();
				$http.put('/rest/products/update/' + productitem.productID, productitem).then(resp => {
					var index = $scope.productitemsLoadAll.findIndex(p => p.productID == productitem.productID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.productitemsLoadAll[index] = productitem;

					Swal.fire({
						icon: 'success',
						title: 'Thành công',
						text: 'khôi phục thành công',
					});
					$scope.initialize();
					$scope.reset();
				}).catch(error => {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Khôi phục thất bại!',
					});
					$scope.initialize();
					$scope.reset();
					console.log("Error", error);
				})
			}
		})
	}
	//sau khi xác nhận thành công thì khôi phục item từ thùng rác (Nút khôi phục ở TABLE) Kết thúc

	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở TABLE) bắt đầu
	$scope.confirmDelete = function(productitem) {
		$scope.form = angular.copy(productitem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa sản phẩm này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				$http.delete('/rest/products/delete/' + $scope.form.productID).then(resp => {
					var index = $scope.productitems.findIndex(p => p.productID == $scope.form.productID);
					$scope.productitems.splice(index, 1);
					$scope.reset();
					Swal.fire({
						icon: 'success',
						title: 'Thành công',
						text: 'Xóa thành công!',
					});
					$scope.initialize();
				}).catch(error => {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Xóa thất bại!',
					});
					console.log("Error", error);
					$scope.initialize();
					$scope.reset();
				});
			}
		})
	}
	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở TABLE) Kết thúc

	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})

	$scope.exportPdf = function () {
		$http({
		  method: "POST",
		  url: "/product-pdf",
		  data: $scope.productitems,
		  responseType: "arraybuffer", // Đặt responseType thành 'arraybuffer' để nhận dữ liệu PDF dưới dạng ArrayBuffer
		  headers: {
			"Content-Type": "application/json",
		  },
		})
		  .then(function (response) {
			// Tạo một đối tượng Blob từ dữ liệu PDF và tạo URL để tải xuống
			var blob = new Blob([response.data], { type: "application/pdf" });
			var url = URL.createObjectURL(blob);
	
			// Tạo một thẻ a để tải xuống tệp PDF
			var a = document.createElement("a");
			a.href = url;
			a.download = "DSProduct.pdf";
			document.body.appendChild(a);
			a.click();
			URL.revokeObjectURL(url);
		  })
		  .catch(function (error) {
			console.error("Xuất PDF thất bại:", error);
		});
	};

	$scope.exportExcel = function () {
		$http({
		  method: "POST",
		  url: "/export-excelProduct", // Thay thế với URL phía máy chủ đúng
		  data: $scope.productitems,
		  responseType: "arraybuffer", // Đặt responseType thành 'arraybuffer' để nhận dữ liệu Excel dưới dạng ArrayBuffer
		  headers: {
			"Content-Type": "application/json",
		  },
		})
		  .then(function (response) {
			// Tạo một đối tượng Blob từ dữ liệu Excel và tạo URL để tải xuống
			var blob = new Blob([response.data], {
			  type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
			});
			var url = URL.createObjectURL(blob);
	
			// Tạo một thẻ <a> để tải xuống tệp Excel
			var a = document.createElement("a");
			a.href = url;
			a.download = "ProductStepUpStyle.xlsx"; // Đặt tên tệp Excel mong muốn
			document.body.appendChild(a);
			a.click();
			URL.revokeObjectURL(url);
		  })
		  .catch(function (error) {
			console.error("Xuất ra Excel thất bại:", error);
		  });
	  };

	$('.exportPdf').click(function() {

		let timerInterval
		Swal.fire({
			icon: 'info',
			title: 'Đang xuất file',
			html: 'Cần phải chờ trong <b></b>s.',
			timer: 2000,
			timerProgressBar: true,
			didOpen: () => {
				Swal.showLoading()
				const b = Swal.getHtmlContainer().querySelector('b')
				timerInterval = setInterval(() => {
					b.textContent = Swal.getTimerLeft()
				}, 100)
			},
			willClose: () => {
				clearInterval(timerInterval)
			}
		}).then((result) => {
			/* Read more about handling dismissals below */
			if (result.dismiss === Swal.DismissReason.timer) {
				console.log('I was closed by the timer')

				//code xuất file
				$scope.exportPdf();
			}

		})

	});

	$('.exportExcel').click(function() {

		let timerInterval
		Swal.fire({
			icon: 'info',
			title: 'Đang xuất file',
			html: 'Cần phải chờ trong <b></b>s.',
			timer: 2000,
			timerProgressBar: true,
			didOpen: () => {
				Swal.showLoading()
				const b = Swal.getHtmlContainer().querySelector('b')
				timerInterval = setInterval(() => {
					b.textContent = Swal.getTimerLeft()
				}, 100)
			},
			willClose: () => {
				clearInterval(timerInterval)
			}
		}).then((result) => {
			/* Read more about handling dismissals below */
			if (result.dismiss === Swal.DismissReason.timer) {
				console.log('I was closed by the timer')

				//code xuất file
				$scope.exportExcel();
			}

		})

	});

	var myApp1 = new function() {
		this.printTable = function() {
			var tab = document.getElementById('sampleTable');
			var win = window.open('', '', 'height=700,width=700');
			win.document.write(tab.outerHTML);
			win.document.close();
			win.print();
		}
	}
});