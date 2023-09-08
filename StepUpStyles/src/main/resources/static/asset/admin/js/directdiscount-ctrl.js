app.controller("directdiscount-ctrl", function ($scope, $http) {
	$scope.directDiscountItem = [];
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
		//load directdiscount
		$http.get("/rest/directdiscount/loadall").then(resp => {
			$scope.directDiscountItem = resp.data
			console.log(resp.data);
			$scope.directDiscountItem.forEach(function(ddI) {
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
		$scope.form.directDiscount = $scope.form.directDiscount * 100


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
		var isoDynamicDateStringS = dynamicDateObjectS.toISOString().slice(0, 19).replace('T', ' ');;
		var dynamicDateValueE = $scope.form.endDate;
		var dynamicDateObjectE = new Date(dynamicDateValueE);
		var isoDynamicDateStringE = dynamicDateObjectE.toISOString().slice(0, 19).replace('T', ' ');;
		//format deciaml
		var percentageValue = $scope.form.directDiscount;

		// Convert the percentage to a decimal value
		var decimalValue = percentageValue / 100;

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
		directDiscountItem.startEnd = isoDynamicDateStringE

		directDiscountItem.directDiscount = decimalValue;


		$http.post('/rest/directdiscount/create', directDiscountItem).then(resp => {
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
		
		if ($scope.form.startDate < today && $scope.form.endDate >today) {
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
		var isoDynamicDateStringS = dynamicDateObjectS.toISOString().slice(0, 19).replace('T', ' ');;
		var dynamicDateValueE = $scope.form.endDate;
		var dynamicDateObjectE = new Date(dynamicDateValueE);
		var isoDynamicDateStringE = dynamicDateObjectE.toISOString().slice(0, 19).replace('T', ' ');;
		//format deciaml
		var percentageValue = $scope.form.directDiscount;

		// Convert the percentage to a decimal value
		var decimalValue = percentageValue / 100;

		var discountitem = angular.copy($scope.form);

		discountitem.startDate = isoDynamicDateStringS;
		discountitem.endDate = isoDynamicDateStringE;

		discountitem.directDiscount = decimalValue;

		$http.put('/rest/directdiscount/update/' + discountitem.directDiscountID, discountitem).then(resp => {
			var index = $scope.directDiscountItem.findIndex(d => d.directDiscountID == discountitem.directDiscountID);
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

	//	Xóa 
	$scope.delete = function (ddI) {
		
		$http.delete('/rest/directdiscount/delete/' + ddI.directDiscountID).then(resp => {
			
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

	$scope.confirmDelete = function() {
		// Thực hiện xóa 
		$scope.form.startDate = new Date($scope.form.startDate);
		$scope.form.endDate = new Date($scope.form.endDate);
			var today = new Date();
			if (today>$scope.form.startDate&&today<$scope.form.endDate) {
				$scope.errorMessage = "Giảm giá đang trong thời gian diễn ra";
				$('#errorModal').modal('show'); 
		$('#confirmDeleteModal').modal('hide');

				return
			}
		$http.delete('/rest/directdiscount/delete/' + $scope.form.directDiscountID).then(resp => {
			var index = $scope.directDiscountItem.findIndex(d => d.directDiscountID == $scope.form.directDiscountID);
		
			

			$scope.directDiscountItem.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show'); // Show the modal
			$scope.initialize();
			
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); 
			console.log("Error", error);
		});

		// Đóng modal xác nhận xóa
		$('#confirmDeleteModal').modal('hide');
	}
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