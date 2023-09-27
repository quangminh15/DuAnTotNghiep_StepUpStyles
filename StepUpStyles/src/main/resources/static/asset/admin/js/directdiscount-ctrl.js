app.controller("directdiscount-ctrl", function ($scope, $http) {
	$scope.directDiscountItem = [];
	$scope.directDiscountNoDelItem = [];
	$scope.directDiscountDelItem = [];
	$scope.prods = [];
	$scope.form = {};
	$scope.form.directdiscounts = {};
	$scope.errorMessage = '';
	$scope.selectedItems = [];

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
			$scope.errorMessage = "Vui lòng chọn sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
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
			$scope.errorMessage = "Vui lòng nhập mức giảm giá!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.startDate) {
			$scope.errorMessage = "Vui lòng nhập thời gian bắt đầu!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.endDate) {
			$scope.errorMessage = "Vui lòng nhập thời gian kết thúc!!";

			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//lỗi ngày 
		var today = new Date();


		if ($scope.form.startDate < today) {
			$scope.errorMessage = "Thời gian bắt đầu không thể ở quá khứ";
			console.log($scope.form.startDate);
			$('#errorModal').modal('show');
			return;
		}

		if ($scope.form.endDate < $scope.form.startDate) {
			$scope.errorMessage = "Thời gian kết thúc phải sau ngày bắt đầu";
			$('#errorModal').modal('show');
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
			$scope.errorMessage = "Thời gian khuyến mãi của sản phẩm bạn muốn thêm mới đang trùng với thời gian khuyến mãi hiện tại của sản phấm đó";
			$('#errorModal').modal('show');
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
			$scope.errorMessage = ''; // Xóa thông báo lỗi khi thành công
			$scope.messageSuccess = "Thêm mới thành công";
			$scope.initialize();
			$('#errorModal1').modal('show'); // Show the modal
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
			$scope.errorMessage = "Vui lòng nhập mức giảm giá!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.startDate) {
			$scope.errorMessage = "Vui lòng nhập thời gian bắt đầu!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.endDate) {
			$scope.errorMessage = "Vui lòng nhập thời gian kết thúc!!";

			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//lỗi ngày 
		var today = new Date();
		
		if ($scope.form.status === 'Đang diễn ra') {
			$scope.errorMessage = "Giảm giá đang trong thời gian áp dụng";
			$('#errorModal').modal('show');
			return;
		}
		if ($scope.form.startDate < today) {
			$scope.errorMessage = "Thời gian bắt đầu phải lớn hơn ngày hiện tại";
			console.log($scope.form.startDate);
			$('#errorModal').modal('show');
			return;
		}

		if ($scope.form.endDate < $scope.form.startDate) {
			$scope.errorMessage = "Thời gian kết thúc phải sau ngày bắt đầu";
			$('#errorModal').modal('show');
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
			$scope.messageSuccess = "Cập nhật thành công";
			$scope.initialize();
			$('#errorModal1').modal('show'); // Show the modal
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

	//Gọi đến modal xác nhận để xóa vào thùng rác
	$scope.confirmHideModal = function() {
		$('#confirmHideModal').modal('show');
	}

	//Xóa vào thùng rác
	$scope.confirmHide = function() {
		var item = angular.copy($scope.form);
		item.deleted = true;
		$http.put('/rest/discount/updateDiscount/' + item.directDiscountId, item).then(resp => {
			var index = $scope.directDiscountNoDelItem.findIndex(p => p.directDiscountId == item.directDiscountId);
			$scope.directDiscountNoDelItem[index] = item;
			$scope.messageSuccess = "Xóa thành công";
			$scope.reset();
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

	//Gọi đến modal xác nhận để xóa vào thùng rác
	$scope.confirmHideModal1 = function(item) {
		$scope.form = angular.copy(item);
		$('#confirmHideModal').modal('show');
	}

	//Gọi đến modal xác nhận để khôi phục từ thùng rác
	$scope.confirmRestoreModal1 = function(item) {
		$scope.form = angular.copy(item);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmRestoreModal').modal('show');
	}

	//Khôi phục item từ thùng rác
	$scope.restore = function() {
		var item = angular.copy($scope.form);
		item.deleted = false;
		$http.put('/rest/discount/updateDiscount/' + item.directDiscountId, item).then(resp => {
			var index = $scope.directDiscountItem.findIndex(p => p.directDiscountId == item.directDiscountId);
			$scope.directDiscountItem[index] = item;
			$scope.reset();
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
	$scope.confirmDeleteModal11 = function(ddI) {
		$scope.form = angular.copy(ddI);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa
		$http.delete('/rest/discount/deleteDiscount/' + $scope.form.directDiscountId).then(resp => {
			var index = $scope.directDiscountDelItem.findIndex(p => p.directDiscountId == $scope.form.directDiscountId);
			$scope.directDiscountDelItem.splice(index, 1);
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

	//	Xóa 
	$scope.delete = function (ddI) {
		$http.delete('/rest/discount/delete/' + ddI.directDiscountID).then(resp => {
			var index = $scope.directDiscountItem.findIndex(d => d.directDiscountID == ddI.directDiscountID);
			$scope.directDiscountItem.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})
	}

	$scope.confirmDeleteModal = function() {
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDeleteModal1 = function(productitem) {
		$scope.form = angular.copy(productitem);
		$('#confirmDeleteModal').modal('show');
	}

	// $scope.confirmDelete = function() {
	// 	// Thực hiện xóa 
	// 	$scope.form.startDate = new Date($scope.form.startDate);
	// 	$scope.form.endDate = new Date($scope.form.endDate);
	// 		var today = new Date();
	// 		if (today>$scope.form.startDate&&today<$scope.form.endDate) {
	// 			$scope.errorMessage = "Giảm giá đang trong thời gian diễn ra";
	// 			$('#errorModal').modal('show'); 
	// 	$('#confirmDeleteModal').modal('hide');
	// 			return
	// 		}
	// 	$http.delete('/rest/directdiscount/delete/' + $scope.form.directDiscountID).then(resp => {
	// 		var index = $scope.directDiscountItem.findIndex(d => d.directDiscountID == $scope.form.directDiscountID);
	// 		$scope.directDiscountItem.splice(index, 1);
	// 		$scope.reset();
	// 		$scope.messageSuccess = "Xóa thành công";
	// 		$('#errorModal1').modal('show'); // Show the modal
	// 		$scope.initialize();
			
	// 	}).catch(error => {
	// 		$scope.errorMessage = "Xóa thất bại";
	// 		$('#errorModal').modal('show'); 
	// 		console.log("Error", error);
	// 	});

	// 	// Đóng modal xác nhận xóa
	// 	$('#confirmDeleteModal').modal('hide');
	// }

	//loc trang thai
	$scope.filterStatus = ''; // Khởi tạo giá trị ban đầu

	$scope.filterStatusDiscount = function (item) {
		if ($scope.filterStatus === '') {
			
			return true; // Hiển thị tất cả khi bộ lọc chưa được chọn
		} else if ($scope.filterStatus === 'dang' && item.status === 'Đang diễn ra') {
			return true;
		} else if ($scope.filterStatus === 'chuadr' && item.status === 'Chưa diễn ra') {
			return true;
		} else if ($scope.filterStatus === 'ket' && item.status === 'Đã kết thúc') {
			return true;
		}

		return $scope.filterStatus === '';
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
		get directDiscountItem() {
			var start = this.page * this.size;
			return $scope.directDiscountItem.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.directDiscountItem.length / this.size);
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
});