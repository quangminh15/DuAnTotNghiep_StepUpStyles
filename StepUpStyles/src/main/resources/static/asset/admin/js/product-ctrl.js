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

	var checkImage = false;

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
		//load productitems hết luôn
		$http.get("/rest/products/loadall").then(resp => {
			$scope.productitemsLoadAll = resp.data;
			$scope.productitemsLoadAll.forEach(productitem => {
				productitem.modifyDate = new Date(productitem.modifyDate)
			})
			$scope.productitems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
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
				$scope.errorMessage = "Lỗi khi tải danh sách sản phẩm!";
				$('#errorModal').modal('show');
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
				$scope.errorMessage = "Lỗi khi tải danh sách sản phẩm theo trạng thái!";
				$('#errorModal').modal('show');
				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};

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
	//		$scope.edit = function(productitem) {
	//			$scope.form = angular.copy(productitem);
	//		}

	$scope.edit = function(productitem) {
		// Gọi API để lấy thông tin sản phẩm chi tiết dựa vào productID
		$http.get("/rest/products/" + productitem.productID).then(function(resp) {
			var productDetails = resp.data;

			// Gọi API để lấy danh sách hình ảnh của sản phẩm dựa vào productId
			$http.get("/rest/productimages/loadbyproduct/" + productitem.productID).then(function(imageResp) {
				var productImages = imageResp.data;

				// Kiểm tra xem sản phẩm có hình ảnh hay không
				if (productImages.length > 0) {
					// Sản phẩm có hình ảnh, cho phép cập nhật sản phẩm
					$scope.form = angular.copy(productitem);
					checkImage = false;
					$scope.form.description = productitem.description;
					CKEDITOR.instances.description.setData($scope.form.description);
				} else {
					// Sản phẩm chưa có ảnh, không cho phép cập nhật sản phẩm
					// Hiển thị thông báo hoặc xử lý khác tùy ý
					$scope.form = angular.copy(productitem);
					checkImage = true;
					$scope.form.description = productitem.description;
					CKEDITOR.instances.description.setData($scope.form.description);
				}
			}).catch(function(imageError) {
				console.error("Lỗi khi lấy danh sách hình ảnh:", imageError);
			});
		}).catch(function(error) {
			console.error("Lỗi khi lấy thông tin sản phẩm:", error);
		});
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
		// Không chọn danh mục
		if (!$scope.form.category || !$scope.form.category.categoryID) {
			//			swal("Thất bại", "Vui lòng chọn danh mục!", "error")
			Swal.fire({
				title: 'Are you sure?',
				text: "You won't be able to revert this!",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes, delete it!'
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire(
						'Deleted!',
						'Your file has been deleted.',
						'success'
					)
				}
			})

			return;
		}

		// Không chọn thương hiệu
		if (!$scope.form.brand || !$scope.form.brand.brandID) {
			swal("Thất bại", "Vui lòng chọn thương hiệu!", "error")
			return;
		}

		// Lỗi bỏ trống tên sản phẩm
		if (!$scope.form.productName) {
			$scope.errorMessage = "Vui lòng nhập tên sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lỗi bỏ trống giá sản phẩm
		if (!$scope.form.price) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lỗi giá sản phẩm < 0
		if ($scope.form.price < 0) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm lớn hơn 0!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lỗi giá sản phẩm > 100.000.000
		if ($scope.form.price > 100000000) {
			$scope.errorMessage = "Vui lòng nhập giá sản phẩm nhỏ hơn 100.000.000đ!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lỗi bỏ trống mô tả
		if (!$scope.form.description) {
			$scope.errorMessage = "Vui lòng nhập mô tả sản phẩm!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lỗi khi cố gắng thay đổi trạng thái hoạt động khi thêm sản phẩm mới
		if (checkImage == true) {
			$scope.errorMessage = "Vui lòng thêm ảnh cho sản phẩm trước khi bật trạng thái hoạt động!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lấy giá trị từ CKEditor cho trường description và gán vào form.description
		var descriptionEditor = CKEDITOR.instances.description;
		$scope.form.description = descriptionEditor.getData();

		// Lấy thông tin người dùng từ API /rest/users/Idprofile
		$http.get("/rest/users/Idprofile").then(resp => {
			var userID = resp.data;
			$scope.form.user = { userID: userID }; // Gán userID cho sản phẩm

			$scope.form.modifyDate = new Date();

			var productitem = angular.copy($scope.form);
			productitem.user.userID = userID;
			$http.post('/rest/products/create', productitem).then(resp => {
				resp.data.modifyDate = new Date(resp.data.modifyDate);
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
					$scope.errorMessage = "Thêm mới thất bại";
					$scope.initialize();
					$('#errorModal').modal('show');
					console.log("Error", error);
				}
			});
		}).catch(error => {
			console.log("Lỗi không tìm thấy người dùng có ID", error);
			$scope.initialize();
			// Xử lý lỗi khi không lấy được thông tin người dùng từ ID
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

		// Lỗi khi cố gắng thay đổi trạng thái hoạt động khi thêm sản phẩm mới
		if (checkImage == true) {
			$scope.errorMessage = "Vui lòng thêm ảnh cho sản phẩm trước khi bật trạng thái hoạt động!!";
			$('#errorModal').modal('show');
			return;
		}

		// Lấy giá trị từ CKEditor cho trường description và gán vào form.description
		var descriptionEditor = CKEDITOR.instances.description;
		$scope.form.description = descriptionEditor.getData();

		// Lấy thông tin người dùng từ API /rest/users/Idprofile
		$http.get("/rest/users/Idprofile").then(resp => {
			var userID = resp.data;
			$scope.form.user = { userID: userID }; // Gán userID cho sản phẩm

			$scope.form.modifyDate = new Date();

			var productitem = angular.copy($scope.form);
			productitem.user.userID = userID;

			$http.put('/rest/products/update/' + productitem.productID, productitem).then(resp => {
				var index = $scope.productitems.findIndex(p => p.productID == productitem.productID);
				resp.data.modifyDate = new Date(resp.data.modifyDate);
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
	$scope.confirmHideModal1 = function(productitem) {
		$scope.form = angular.copy(productitem);
		$('#confirmHideModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa vào thùng rác
	$scope.confirmHide = function() {
		var productitem = angular.copy($scope.form);

		// Lấy giá trị từ CKEditor cho trường description và gán vào form.description
		var descriptionEditor = CKEDITOR.instances.description;
		$scope.form.description = descriptionEditor.getData();

		productitem.deleted = true;
		$http.put('/rest/products/update/' + productitem.productID, productitem).then(resp => {
			var index = $scope.productitems.findIndex(p => p.productID == productitem.productID);
			$scope.productitems[index] = productitem;
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
	$scope.confirmRestoreModal1 = function(productitem) {
		$scope.form = angular.copy(productitem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmRestoreModal').modal('show');
	}

	//Khôi phục item từ thùng rác
	$scope.restore = function() {
		var productitem = angular.copy($scope.form);

		// Lấy giá trị từ CKEditor cho trường description và gán vào form.description
		var descriptionEditor = CKEDITOR.instances.description;
		$scope.form.description = descriptionEditor.getData();

		productitem.deleted = false;
		$http.put('/rest/products/update/' + productitem.productID, productitem).then(resp => {
			var index = $scope.productitemsLoadAll.findIndex(p => p.productID == productitem.productID);
			$scope.productitemsLoadAll[index] = productitem;

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
	$scope.confirmDeleteModal1 = function(productitem) {
		$scope.form = angular.copy(productitem);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa
		$http.delete('/rest/products/delete/' + $scope.form.productID).then(resp => {
			var index = $scope.productitems.findIndex(p => p.productID == $scope.form.productID);
			$scope.productitems.splice(index, 1);
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

	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})

	$('.export').click(function() {
		var table2excel = new Table2Excel();
		table2excel.export(document.querySelectorAll("table.table"));
	});

	$('.pdf-file').click(function() {

		var elment = document.getElementById('sampleTable');
		var opt = {
			margin: 0.5,
			filename: 'myfilepdf.pdf',
			image: { type: 'jpeg', quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
		};
		html2pdf(elment, opt);
		let timerInterval
		Swal.fire({
			title: 'Auto close alert!',
			html: 'I will close in <b></b> milliseconds.',
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