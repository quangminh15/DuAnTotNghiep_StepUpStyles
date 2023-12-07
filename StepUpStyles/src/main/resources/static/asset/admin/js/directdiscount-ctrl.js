app.controller("directdiscount-ctrl", function ($scope, $http) {
	$scope.directDiscountItem = [];
	$scope.directDiscountNoDelItem = [];
	$scope.directDiscountDelItem = [];
	$scope.prods = [];
	$scope.form = {};
	$scope.form.directdiscounts = {};
	$scope.errorMessage = '';
	$scope.selectedItems = [];

	$scope.sortableColumns = [
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		// { name: 'modifyDate', label: 'Thời gian' },
		{ name: 'directDiscount', label: 'Mức giảm (%)' },
		{ name: 'formattedStartDate', label: 'Thời gian bắt đầu' },
		{ name: 'formattedEndDate', label: 'Thời gian kết thúc' },
		{ name: 'priceDiscount', label: 'Giá sau khi giảm' },
		{ name: 'status', label: 'Trạng thái' },
	];

	$scope.sortByColumn = function (columnName) {
		if ($scope.sortColumn === columnName) {
		  $scope.sortReverse = !$scope.sortReverse;
		} else {
		  $scope.sortColumn = columnName;
		  $scope.sortReverse = false;
		}
	
		$scope.directDiscountNoDelItem.sort(function (a, b) {
		  var aValue = a[columnName];
		  var bValue = b[columnName];
		  if (columnName === "product.productName") {
			aValue = a.product.productName;
			bValue = b.product.productName;
		  }
	
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

	$scope.initialize = function () {
		//load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
			console.log(resp.data);
			
		});

		//load discount all
		$http.get("/rest/discount").then(resp => {
			$scope.directDiscountItem = resp.data;
			$scope.directDiscountItem.forEach(function(ddI) {
				ddI.formattedStartDate = formatDate(ddI.startDate);
				ddI.formattedEndDate = formatDate(ddI.endDate);
			});
			$scope.pager.first();
		});

		//load directdiscount
		$http.get("/rest/discount/noDeletedDiscount").then(resp => {
			$scope.directDiscountNoDelItem = resp.data
			console.log(resp.data);
			// Sắp xếp mảng items theo trạng thái
			$scope.directDiscountNoDelItem.sort(function (a, b) {
				var statusDiscount = {
					'Đang diễn ra': 1,
					'Chưa diễn ra': 2,
					'Đã kết thúc': 3
				};
			
				var statusA = a.status;
				var statusB = b.status;
			
				return statusDiscount[statusA] - statusDiscount[statusB];
			});
			
			$scope.directDiscountNoDelItem.forEach(function(ddI) {
				ddI.formattedStartDate = formatDate(ddI.startDate);
				ddI.formattedEndDate = formatDate(ddI.endDate);
			});
			$scope.pager.first();
			$scope.RestorePager.first();
		})

		//load directdiscount deleted
		$http.get("/rest/discount/deletdDiscount").then(resp => {
			$scope.directDiscountDelItem = resp.data
			console.log(resp.data);
			// Sắp xếp mảng items theo trạng thái
			$scope.directDiscountDelItem.sort(function (a, b) {
				var statusDiscount = {
					'Đang diễn ra': 1,
					'Chưa diễn ra': 2,
					'Đã kết thúc': 3
				};
			
				var statusA = a.status;
				var statusB = b.status;
			
				return statusDiscount[statusA] - statusDiscount[statusB];
			});
			
			$scope.directDiscountDelItem.forEach(function(ddI) {
				ddI.formattedStartDate = formatDate(ddI.startDate);
				ddI.formattedEndDate = formatDate(ddI.endDate);
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
	}

	//loc trang thai
	$scope.selectedStatus = "Tất cả trạng thái";

	$scope.filterDiscounts = function () {
        // Chuyển đổi tên trạng thái sang giá trị tương ứng
        var statusMapping = {
            "Tất cả trạng thái": "",
            "Đang diễn ra": "Đang diễn ra",
            "Chưa diễn ra": "Chưa diễn ra",
            "Kết thúc": "Đã kết thúc"
        };

        var status = statusMapping[$scope.selectedStatus];

		if (status === "") {
			// Hiển thị toàn bộ dữ liệu
			$http.get("/rest/discount/noDeletedDiscount")
				.then(function (resp) {
					$scope.directDiscountNoDelItem = resp.data;
					$scope.directDiscountNoDelItem.sort(function (a, b) {
						var statusDiscount = {
							'Đang diễn ra': 1,
							'Chưa diễn ra': 2,
							'Đã kết thúc': 3
						};
					
						var statusA = a.status;
						var statusB = b.status;
					
						return statusDiscount[statusA] - statusDiscount[statusB];
					});
					$scope.directDiscountNoDelItem.forEach(function(ddI) {
						ddI.formattedStartDate = formatDate(ddI.startDate);
						ddI.formattedEndDate = formatDate(ddI.endDate);
					});
				});
		}else{
			// Gọi API bằng $http
			$http.get("/rest/discount/filter", {
				params: {
					status: status,
					deleted: false // Nếu bạn không cần sử dụng biến deleted, bạn có thể loại bỏ nó hoặc thay đổi giá trị mặc định tùy theo yêu cầu của bạn.
				}
			}).then(function (resp) {
				$scope.directDiscountNoDelItem = resp.data;
				$scope.directDiscountNoDelItem.forEach(function(ddI) {
					ddI.formattedStartDate = formatDate(ddI.startDate);
					ddI.formattedEndDate = formatDate(ddI.endDate);
				});
				console.log(resp.data);
			});
		}

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

	//tìm kiếm tên sản phẩm
	$scope.searchByProduct = function(){
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/discount/searchDiscountProduct", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.directDiscountNoDelItem = resp.data;
				$scope.directDiscountNoDelItem.sort(function (a, b) {
					var statusDiscount = {
						'Đang diễn ra': 1,
						'Chưa diễn ra': 2,
						'Đã kết thúc': 3
					};
				
					var statusA = a.status;
					var statusB = b.status;
				
					return statusDiscount[statusA] - statusDiscount[statusB];
				});
				
				$scope.directDiscountNoDelItem.forEach(function(ddI) {
					ddI.formattedStartDate = formatDate(ddI.startDate);
					ddI.formattedEndDate = formatDate(ddI.endDate);
				});
				$scope.pager.first();
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
			}).catch(error => {
				console.log("Error", error);
				$scope.pager.first();
			});
		}else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
		}
	}

	//	Xóa form
	$scope.reset = function () {
		$scope.form = {
		};
	}
	
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function (ddI) {
		$scope.form = angular.copy(ddI);
		$scope.form.startDate = new Date($scope.form.startDate);
		$scope.form.endDate = new Date($scope.form.endDate);
		$scope.form.directDiscount = $scope.form.directDiscount
	}


	//	Thêm mới 
	$scope.create = function () {
		//Không chọn sản phẩm
		if (!$scope.form.product || !$scope.form.product.productID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn sản phẩm!',
			})
			return;
		}

		// Kiểm tra sự trùng lặp
		//		var isDuplicate = checkDuplicateVariant($scope.form);
		//		if (isDuplicate) {
		//			$scope.errorMessage = "Sản phẩm này đã tồn tại với một cấu hình. Bạn cui lòng chọn sản phẩm khác!";
		//			$('#errorModal').modal('show'); // Show the modal
		//			return;
		//		}

		//Lỗi bỏ trống 
		if (!$scope.form.directDiscount) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập mức giảm giá!',
			})
			return;
		}

		if ($scope.form.directDiscount < 0 || $scope.form.directDiscount > 100) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập giảm giá từ 1 đến 100 (%)!',
			})
			return;
		}

		

		if (!$scope.form.startDate) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thời gian bắt đầu!',
			})
			return;
		}

		if (!$scope.form.endDate) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thời gian kết thúc!',
			})
			return;
		}

		//lỗi ngày 
		var today = new Date();

		if ($scope.form.startDate < today) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Thời gian bắt đầu không thể ở quá khứ!',
			})
			return;
		}

		if ($scope.form.endDate < $scope.form.startDate) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Thời gian kết thúc phải sau thời gian bắt đầu!',
			})
			return;
		}

		//format date
		var dynamicDateValueS = $scope.form.startDate;
		var dynamicDateObjectS = new Date(dynamicDateValueS);
		// Đặt múi giờ cho ngày giờ theo múi giờ Việt Nam (UTC+7)
		dynamicDateObjectS.setHours(dynamicDateObjectS.getHours() + 7);
		var isoDynamicDateStringS = dynamicDateObjectS.toISOString().slice(0, 19).replace('T', ' ');

		var dynamicDateValueE = $scope.form.endDate;
		var dynamicDateObjectE = new Date(dynamicDateValueE);
		// Đặt múi giờ cho ngày giờ theo múi giờ Việt Nam (UTC+7)
		dynamicDateObjectE.setHours(dynamicDateObjectE.getHours() + 7);
		var isoDynamicDateStringE = dynamicDateObjectE.toISOString().slice(0, 19).replace('T', ' ');


		var productId = $scope.form.product.productID;
		var isProductOnPromotion = $scope.directDiscountItem.some(function (discount) {
			console.log(discount.endDate, isoDynamicDateStringS);
			return discount.product.productID === productId && discount.endDate > isoDynamicDateStringS;
		});

		if (isProductOnPromotion) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Thời gian khuyến mãi của sản phẩm bạn muốn thêm mới đang trùng với thời gian khuyến mãi hiện tại của sản phấm đó!',
			})
			return;
		}

		var directDiscountItem = angular.copy($scope.form);
		directDiscountItem.startDate = isoDynamicDateStringS;
		directDiscountItem.endDate = isoDynamicDateStringE

		// directDiscountItem.directDiscount = decimalValue;
		directDiscountItem.deleted = false;

		$http.post('/rest/discount/createDiscount', directDiscountItem).then(resp => {
			console.log(directDiscountItem.startDate);
			$scope.directDiscountItem.push(resp.data);
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
		if (!$scope.form.directDiscount) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập mức giảm giá!',
			})
			return;
		}

		if (!$scope.form.startDate) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thời gian bắt đầu!',
			})
			return;
		}

		if (!$scope.form.endDate) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn thời gian kết thúc!',
			})
			return;
		}

		//lỗi ngày 
		var today = new Date();
		
		if ($scope.form.status === 'Đang diễn ra') {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Giảm giá đang trong thời gian áp dụng',
			})
			return;
		}

		if ($scope.form.startDate < today) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Thời gian bắt đầu không thể ở quá khứ!',
			})
			return;
		}

		if ($scope.form.endDate < $scope.form.startDate) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Thời gian kết thúc phải sau ngày bắt đầu!',
			})
			return;
		}

		var dynamicDateValueS = $scope.form.startDate;
		var dynamicDateObjectS = new Date(dynamicDateValueS);
		// Đặt múi giờ cho ngày giờ theo múi giờ Việt Nam (UTC+7)
		dynamicDateObjectS.setHours(dynamicDateObjectS.getHours() + 7);
		var isoDynamicDateStringS = dynamicDateObjectS.toISOString().slice(0, 19).replace('T', ' ');

		var dynamicDateValueE = $scope.form.endDate;
		var dynamicDateObjectE = new Date(dynamicDateValueE);
		// Đặt múi giờ cho ngày giờ theo múi giờ Việt Nam (UTC+7)
		dynamicDateObjectE.setHours(dynamicDateObjectE.getHours() + 7);
		var isoDynamicDateStringE = dynamicDateObjectE.toISOString().slice(0, 19).replace('T', ' ');

		//format deciaml
		// var percentageValue = $scope.form.directDiscount;

		// Convert the percentage to a decimal value
		// var decimalValue = percentageValue / 100;

		var discountitem = angular.copy($scope.form);

		discountitem.startDate = isoDynamicDateStringS;
		discountitem.endDate = isoDynamicDateStringE;

		// discountitem.directDiscount = decimalValue;

		$http.put('/rest/discount/updateDiscount/' + discountitem.directDiscountId, discountitem).then(resp => {
			var index = $scope.directDiscountItem.findIndex(d => d.directDiscountId == discountitem.directDiscountId);
			$scope.directDiscountItem[index] = discountitem;
			$scope.initialize();
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

	//Mở modal thùng rác
	$scope.openRecycleBinForm = function() {
		// Reset searchKeyword
		searchValue = '';
		$('#recycleBinModal').modal('show');
	};
	
	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở Table)
	$scope.confirmHideTable = function(item) {
		$scope.form = angular.copy(item);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa giảm giá sản phẩm này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				item.deleted = true;
				$http.put('/rest/discount/updateDiscount/' + item.directDiscountId, item).then(resp => {
					var index = $scope.directDiscountNoDelItem.findIndex(p => p.directDiscountId == item.directDiscountId);
					$scope.directDiscountNoDelItem[index] = item;
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
				$http.put('/rest/discount/updateDiscount/' + item.directDiscountId, item).then(resp => {
					var index = $scope.directDiscountNoDelItem.findIndex(p => p.directDiscountId == item.directDiscountId);
					$scope.directDiscountNoDelItem[index] = item;
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
				$http.put('/rest/discount/updateDiscount/' + item.directDiscountId, item).then(resp => {
					var index = $scope.directDiscountItem.findIndex(p => p.directDiscountId == item.directDiscountId);
					$scope.directDiscountItem[index] = item;
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

	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở TABLE) bắt đầu
	$scope.confirmDelete = function(ddI) {
		$scope.form = angular.copy(ddI);
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
				$http.delete('/rest/discount/deleteDiscount/' + $scope.form.directDiscountId).then(resp => {
					var index = $scope.directDiscountDelItem.findIndex(p => p.directDiscountId == $scope.form.directDiscountId);
					$scope.directDiscountDelItem.splice(index, 1);
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

	//format tien te vnd
	$scope.formatToVND = function (priceDiscount) {
		// Làm tròn đến hàng nghìn
		priceDiscount = Math.round(priceDiscount / 1000) * 1000;
		
		// Định dạng số amount sang định dạng VND
		return priceDiscount.toLocaleString("vi-VN", {
		  style: "currency",
		  currency: "VND",
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
			console.log('visiblePages', visiblePages);
			return visiblePages;
		},
		get directDiscountNoDelItem() {
			var start = this.page * this.size;
			return $scope.directDiscountNoDelItem.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.directDiscountNoDelItem.length / this.size);
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
		get directDiscountDelItem() {
			var start = this.page * this.size;
			return $scope.directDiscountDelItem.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.directDiscountDelItem.length / this.size);
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