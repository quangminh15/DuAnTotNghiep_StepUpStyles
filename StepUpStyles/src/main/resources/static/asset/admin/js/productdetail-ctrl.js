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
	$scope.disableCreateButton = false;

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

	// Tìm kiếm  
	$scope.searchProductDetailByName = async function() {
		const { value: searchKeyword } = await Swal.fire({
			title: 'Tìm kiếm sản phẩm',
			input: 'text',
			inputLabel: 'Nhập tên sản phẩm',
			inputPlaceholder: 'Nhập tên sản phẩm cần tìm kiếm'
		});

		if (searchKeyword && searchKeyword.trim() !== "") {
			$http.get("/rest/productdetails/search", {
				params: { keyword: searchKeyword }
			}).then(resp => {
				$scope.productdetailitems = resp.data;
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
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không tìm thấy tên sản phẩm mà bạn mong muốn!',
			});
		}
	};

	$scope.filterByProduct = function() {
		if ($scope.selectedProduct) {
			$http.get("/rest/productdetails/loadbyproduct/" + $scope.selectedProduct).then(resp => {
				$scope.productdetailitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách sản phẩm!!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			deleted: false,
		};
		$scope.disableCreateButton = false;
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(productdetailitem) {
		$scope.form = angular.copy(productdetailitem);
		 $scope.disableCreateButton = true;
	}

	function checkDuplicateProductDetail(productdetailitem) {
		// Kiểm tra sự trùng lặp dựa trên productID, colorID
		var isDuplicate = $scope.productdetailitems.some(function(item) {
			return (
				item.product.productID === productdetailitem.product.productID &&
				item.color.colorID === productdetailitem.color.colorID &&
				item.size.sizeID === productdetailitem.size.sizeID
			);
		});

		return isDuplicate;
	}

	//	Thêm mới 
	$scope.create = function() {
		//Không chọn sản phẩm
		if (!$scope.form.product || !$scope.form.product.productID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn sản phẩm!!',
			});
			return;
		}

		//Không chọn màu sản phẩm
		if (!$scope.form.color || !$scope.form.color.colorID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn màu cho sản phẩm!!',
			});
			return;
		}
		
		//Không chọn size sản phẩm
		if (!$scope.form.size || !$scope.form.size.sizeID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn size cho sản phẩm!!',
			});
			return;
		}

		// Kiểm tra sự trùng lặp
		var isDuplicate = checkDuplicateProductDetail($scope.form);
		if (isDuplicate) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Đã tồn tại sản phẩm chi tiết có size và màu này rồi!',
			});
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.quantity) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập số lượng!!',
			});
			return;
		}

		//Lỗi số lượng sản phẩm < 0
		if ($scope.form.quantity < 0) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập số lượng sản phẩm lớn hơn 0!!',
			});
			return;
		}

		//Lỗi số lượng sản phẩm > 10.000
		if ($scope.form.quantity > 10000) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Số lượng quá lớn. Vui lòng nhập nhỏ hơn 10.000 !!',
			});
			return;
		}

		var productdetailitem = angular.copy($scope.form);
		productdetailitem.deleted = false;
		productdetailitem.modifyDate = new Date();
		$http.post('/rest/productdetails/create', productdetailitem).then(resp => {
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.productdetailitems.push(resp.data);
			$scope.reset();
			Swal.fire({
				icon: 'success',
				title: 'Thành công',
				text: 'Thêm mới thành công!!',
			});
			$scope.initialize();
			$scope.reset();
		}).catch(error => {
			if (error.status === 400) {
				$scope.errorMessage = error.data;
				$scope.initialize();
			} else {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Thêm mới thất bại!!',
				});
				console.log("Error", error);
				$scope.initialize();
			}
		});
	}

	//	Cập nhật  
	$scope.update = function() {
		//Không chọn sản phẩm
		if (!$scope.form.product || !$scope.form.product.productID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn sản phẩm!!',
			});
			return;
		}

		//Không chọn màu sản phẩm
		if (!$scope.form.color || !$scope.form.color.colorID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn màu cho sản phẩm!!',
			});
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.quantity) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập số lượng!!',
			});
			return;
		}

		//Lỗi số lượng sản phẩm < 0
		if ($scope.form.quantity < 0) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập số lượng sản phẩm lớn hơn 0!!',
			});
			return;
		}

		//Lỗi số lượng sản phẩm > 10.000
		if ($scope.form.quantity > 10000) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Số lượng quá lớn. Vui lòng nhập nhỏ hơn 10.000 !!',
			});
			return;
		}


		var productdetailitem = angular.copy($scope.form);
		productdetailitem.modifyDate = new Date();
		$http.put('/rest/productdetails/update/' + productdetailitem.productDetailID, productdetailitem).then(resp => {
			var index = $scope.productdetailitems.findIndex(p => p.productDetailID == productdetailitem.productDetailID);
			$scope.productdetailitems[index] = productdetailitem;
			Swal.fire({
				icon: 'success',
				title: 'Thành công',
				text: 'Cập nhật thành công!!',
			});
			$scope.initialize();$scope.reset();
			$scope.disableCreateButton = false;
		}).catch(error => {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Cập nhật thất bại!!',
			});
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
				var productdetailitem = angular.copy($scope.form);
				productdetailitem.deleted = true;
				productdetailitem.modifyDate = new Date();
				$http.put('/rest/productdetails/update/' + productdetailitem.productDetailID, productdetailitem).then(resp => {
					var index = $scope.productdetailitems.findIndex(p => p.productDetailID == productdetailitem.productDetailID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.productdetailitems[index] = productdetailitem;
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
	$scope.confirmHideTable = function(productdetailitem) {
		$scope.form = angular.copy(productdetailitem);
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
				productdetailitem.deleted = true;
				productdetailitem.modifyDate = new Date();
				$http.put('/rest/productdetails/update/' + productdetailitem.productDetailID, productdetailitem).then(resp => {
					var index = $scope.productdetailitems.findIndex(p => p.productDetailID == productdetailitem.productDetailID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.productdetailitems[index] = productdetailitem;
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
	$scope.restore = function(productdetailitem) {
		console.log(productdetailitem)
		$scope.form = angular.copy(productdetailitem);
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
				productdetailitem.deleted = false;
				productdetailitem.modifyDate = new Date();
				$http.put('/rest/productdetails/update/' + productdetailitem.productDetailID, productdetailitem).then(resp => {
					var index = $scope.productdetailitemsLoadAll.findIndex(p => p.productDetailID == productdetailitem.productDetailID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.productdetailitemsLoadAll[index] = productdetailitem;

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
	$scope.confirmDelete = function(productdetailitem) {
		console.log(productdetailitem)
		$scope.form = angular.copy(productdetailitem);
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
				$http.delete('/rest/productdetails/delete/' + $scope.form.productDetailID).then(resp => {
					var index = $scope.productdetailitems.findIndex(p => p.productDetailID == $scope.form.productDetailID);
					$scope.productdetailitems.splice(index, 1);
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
		  url: "/productdetail-pdf",
		  data: $scope.productdetailitems,
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
			a.download = "DSProductDetail.pdf";
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
		  url: "/export-excelProductDetail", // Thay thế với URL phía máy chủ đúng
		  data: $scope.productdetailitems,
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
			a.download = "ProductDetailStepUpStyle.xlsx"; // Đặt tên tệp Excel mong muốn
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