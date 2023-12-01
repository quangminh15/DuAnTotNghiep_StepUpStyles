app.controller("voucher-ctrl", function($scope, $http){
    $scope.voucherItem = [];
	$scope.voucherNoDelItem = [];
	$scope.voucherDelItem = [];
	$scope.form = {};

    $scope.sortableColumns = [
        { name: 'total', label: 'Đơn hàng tối thiểu' },
		{ name: 'discountAmount', label: 'Mức giảm (%)' },
		{ name: 'formattedStartDate', label: 'Thời gian bắt đầu' },
		{ name: 'formattedEndDate', label: 'Thời gian kết thúc' },
		{ name: 'description', label: 'Mô tả' },
	];

	$scope.sortByColumn = function (columnName) {
		if ($scope.sortColumn === columnName) {
		  $scope.sortReverse = !$scope.sortReverse;
		} else {
		  $scope.sortColumn = columnName;
		  $scope.sortReverse = false;
		}
	
		$scope.voucherNoDelItem.sort(function (a, b) {
		  var aValue = a[columnName];
		  var bValue = b[columnName];
	
		  if (typeof aValue === "string") {
			aValue = aValue.toLowerCase();
		  }
		  if (typeof bValue === "string") {
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

    $scope.initialize = function (){
        //load voucher all
		$http.get("/rest/voucher").then(resp => {
			$scope.voucherItem = resp.data;
			$scope.voucherItem.forEach(function(ddI) {
				ddI.formattedStartDate = formatDate(ddI.dateStart);
				ddI.formattedEndDate = formatDate(ddI.dateEnd);
			});
			$scope.pager.first();
		});

        //load voucher no delete
		$http.get("/rest/voucher/noDeletedVoucher").then(resp => {
			$scope.voucherNoDelItem = resp.data
			console.log(resp.data);
			$scope.voucherNoDelItem.forEach(function(ddI) {
				ddI.formattedStartDate = formatDate(ddI.dateStart);
				ddI.formattedEndDate = formatDate(ddI.dateEnd);
			});
			$scope.pager.first();
			$scope.RestorePager.first();
		})

		//load voucher delete
		$http.get("/rest/voucher/deletedVoucher").then(resp => {
			$scope.voucherDelItem = resp.data
			console.log(resp.data);
			$scope.voucherDelItem.forEach(function(ddI) {
				ddI.formattedStartDate = formatDate(ddI.dateStart);
				ddI.formattedEndDate = formatDate(ddI.dateEnd);
			});
			$scope.pager.first();
			$scope.RestorePager.first();
		})

        function formatDate(startDate) {
			// Parse the input date string
			const inputDate = new Date(startDate);
		
			// format gio VN
			const options = {
				year: 'numeric',
				month: '2-digit',
				day: '2-digit',
				hour: '2-digit',
				minute: '2-digit',
				second: '2-digit',
				hour12: false, // 24-hour format
				timeZone: 'Asia/Ho_Chi_Minh', //  time zone
			};
		
			// Format the date using Intl.DateTimeFormat
			const formattedDate = new Intl.DateTimeFormat('vi-VN', options).format(inputDate);
		
			return formattedDate;
		}
    };

	//	Xóa form
	$scope.reset = function () {
		$scope.form = {
		};
	}

    $scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function (ddI) {
		$scope.form = angular.copy(ddI);
		$scope.form.dateStart = new Date($scope.form.dateStart);
		$scope.form.dateEnd = new Date($scope.form.dateEnd);
		$scope.form.discountAmount = $scope.form.discountAmount
	}

    //format tien te vnd
    $scope.formatToVND = function (amount) {
        // Logic để định dạng số amount sang định dạng VND
        return amount.toLocaleString("vi-VN", {
        style: "currency",
        currency: "VND",
        });
    };

	//Mở modal thùng rác
	$scope.openRecycleBinForm = function() {
		// Reset searchKeyword
		searchValue = '';
		$('#recycleBinModal').modal('show');
	};

	//	Thêm mới 
	$scope.create = function () {
		//Không chọn sản phẩm
		if (!$scope.form.total) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập mức giá tối thiểu cho đơn hàng!',
			})
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.discountAmount) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập mức giảm giá!',
			})
			return;
		}

		if (!$scope.form.dateStart) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thời gian bắt đầu!',
			})
			return;
		}

		if (!$scope.form.dateEnd) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thời gian kết thúc!',
			})
			return;
		}

		//lỗi ngày 
		var today = new Date();

		if ($scope.form.dateStart < today) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Thời gian bắt đầu không thể ở quá khứ!',
			})
			return;
		}

		if ($scope.form.dateEnd < $scope.form.dateStart) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Thời gian kết thúc phải sau ngày bắt đầu!',
			})
			return;
		}

		//format date
		var dynamicDateValueS = $scope.form.dateStart;
		var dynamicDateObjectS = new Date(dynamicDateValueS);
		// Đặt múi giờ cho ngày giờ theo múi giờ Việt Nam (UTC+7)
		dynamicDateObjectS.setHours(dynamicDateObjectS.getHours() + 7);
		var isoDynamicDateStringS = dynamicDateObjectS.toISOString().slice(0, 19).replace('T', ' ');

		var dynamicDateValueE = $scope.form.dateEnd;
		var dynamicDateObjectE = new Date(dynamicDateValueE);
		// Đặt múi giờ cho ngày giờ theo múi giờ Việt Nam (UTC+7)
		dynamicDateObjectE.setHours(dynamicDateObjectE.getHours() + 7);
		var isoDynamicDateStringE = dynamicDateObjectE.toISOString().slice(0, 19).replace('T', ' ');

		var voucherItem = angular.copy($scope.form);
		voucherItem.dateStart = isoDynamicDateStringS;
		voucherItem.dateEnd = isoDynamicDateStringE

		// directDiscountItem.directDiscount = decimalValue;
		voucherItem.deleted = false;

		$http.post('/rest/voucher/postVoucher', voucherItem).then(resp => {
			console.log(voucherItem.dateStart);
			$scope.voucherItem.push(resp.data);
			$scope.reset();
			$scope.initialize();
			Swal.fire({
				icon: 'success',
				title: 'Thành công',
				text: 'Thêm mới thành công!',
			})
		}).catch(error => {
			if (error.status === 400) {
				$scope.errorMessage = error.data;
			} else {
				$scope.errorMessage = "Thêm mới thất bại";
				$('#errorModal').modal('show'); // Show the modal
				console.log("Error", error);
			}
		});
	}

	//	Cập nhật  
	$scope.update = function () {
		//Không chọn sản phẩm
		if (!$scope.form.total) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập mức giá tối thiểu cho đơn hàng!',
			})
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.discountAmount) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập mức giảm giá!',
			})
			return;
		}

		if (!$scope.form.dateStart) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thời gian bắt đầu!',
			})
			return;
		}

		if (!$scope.form.dateEnd) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thời gian kết thúc!',
			})
			return;
		}

		//lỗi ngày 
		var today = new Date();

		if ($scope.form.dateEnd < $scope.form.dateStart) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Thời gian kết thúc phải sau ngày bắt đầu!',
			})
			return;
		}

		//format date
		var dynamicDateValueS = $scope.form.dateStart;
		var dynamicDateObjectS = new Date(dynamicDateValueS);
		// Đặt múi giờ cho ngày giờ theo múi giờ Việt Nam (UTC+7)
		dynamicDateObjectS.setHours(dynamicDateObjectS.getHours() + 7);
		var isoDynamicDateStringS = dynamicDateObjectS.toISOString().slice(0, 19).replace('T', ' ');

		var dynamicDateValueE = $scope.form.dateEnd;
		var dynamicDateObjectE = new Date(dynamicDateValueE);
		// Đặt múi giờ cho ngày giờ theo múi giờ Việt Nam (UTC+7)
		dynamicDateObjectE.setHours(dynamicDateObjectE.getHours() + 7);
		var isoDynamicDateStringE = dynamicDateObjectE.toISOString().slice(0, 19).replace('T', ' ');

		var voucherItem = angular.copy($scope.form);
		voucherItem.dateStart = isoDynamicDateStringS;
		voucherItem.dateEnd = isoDynamicDateStringE

		var voucherItem = angular.copy($scope.form);

		voucherItem.dateStart = isoDynamicDateStringS;
		voucherItem.dateEnd = isoDynamicDateStringE;

		// discountitem.directDiscount = decimalValue;

		$http.put('/rest/voucher/updateVoucher/' + voucherItem.voucherId, voucherItem).then(resp => {
			var index = $scope.voucherItem.findIndex(d => d.voucherId == voucherItem.voucherId);
			$scope.voucherItem[index] = voucherItem;
			$scope.initialize();
			$scope.reset();
			Swal.fire({
				icon: 'success',
				title: 'Thành công',
				text: 'Cập nhật thành công!',
			})
		}).catch(error => {
			$scope.errorMessage = "Cập nhật thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})
	}

	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở Table)
	$scope.confirmHideTable = function(item) {
		$scope.form = angular.copy(item);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa voucher này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				item.deleted = true;
				$http.put('/rest/voucher/updateVoucher/' + item.voucherId, item).then(resp => {
					var index = $scope.voucherNoDelItem.findIndex(p => p.voucherId == item.voucherId);
					$scope.voucherNoDelItem[index] = item;
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

	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở FORM) bắt đầu
	$scope.confirmHide = function() {
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa sản phẩm khuyến mãi này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				var item = angular.copy($scope.form);
				item.deleted = true;
				$http.put('/rest/voucher/updateVoucher/' + item.voucherId, item).then(resp => {
					var index = $scope.voucherNoDelItem.findIndex(p => p.voucherId == item.voucherId);
					$scope.voucherNoDelItem[index] = item;
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

	//sau khi xác nhận thành công thì khôi phục từ thùng rác (Nút khôi phục ở TABLE) bắt đầu
	$scope.restore = function(item) {
		$scope.form = angular.copy(item);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn khôi phục sản phẩm khuyến mãi này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			console.log(result)
			if (result.isConfirmed) {
				item.deleted = false;
				$http.put('/rest/voucher/updateVoucher/' + item.voucherId, item).then(resp => {
					var index = $scope.voucherItem.findIndex(p => p.voucherId == item.voucherId);
					$scope.voucherItem[index] = item;
					Swal.fire({
						icon: 'success',
						title: 'Thành công',
						text: 'Khôi phục thành công',
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

	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở TABLE) bắt đầu
	$scope.confirmDelete = function(ddI) {
		$scope.form = angular.copy(ddI);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa voucher này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				$http.delete('/rest/voucher/removeVoucher/' + $scope.form.voucherId).then(resp => {
					var index = $scope.voucherDelItem.findIndex(p => p.voucherId == $scope.form.voucherId);
					$scope.voucherDelItem.splice(index, 1);
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
	};

	$scope.formatDescription = function (description) {
		// Đặt một giới hạn độ dài cho địa chỉ
		var maxLength = 20;
	
		// Kiểm tra độ dài địa chỉ và trả về địa chỉ được cắt hoặc không đổi
		if (description.length > maxLength) {
			return description.substring(0, maxLength) + '...';
		} else {
			return description;
		}
	};

	//search
	// $scope.searchByName = function(){
	// 	if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
	// 		$http.get("/rest/voucher/searchVouchers", {
	// 			params: { keyword: $scope.searchKeyword }
	// 		}).then(resp => {
	// 			$scope.voucherNoDelItem = resp.data;
	// 			$scope.pager.first();
	// 		}).catch(error => {
	// 			console.log("Error", error);
	// 			$scope.pager.first();
	// 		});
	// 	}else {
	// 		// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
	// 		$scope.initialize();
	// 	}
	// }

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
			console.log('visiblePages', visiblePages);
			return visiblePages;
		},
		get voucherNoDelItem() {
			var start = this.page * this.size;
			return $scope.voucherNoDelItem.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.voucherNoDelItem.length / this.size);
		},
		first() {
			this.page = 0;
			$scope.visiblePages = this.getPageNumbers();
			console.log('Đã click nút first');
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
		get voucherDelItem() {
			var start = this.page * this.size;
			return $scope.voucherDelItem.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.voucherDelItem.length / this.size);
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
});