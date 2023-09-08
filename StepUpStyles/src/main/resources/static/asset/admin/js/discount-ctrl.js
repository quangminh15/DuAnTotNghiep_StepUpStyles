app.controller("discount-ctrl", function ($scope, $http) {
	$scope.discountItem = [];
	$scope.discountProdItem = [];
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
			// $scope.productitems.forEach(productitem => {
			// 	productitem.createDate = new Date(productitem.createDate)
			// })
		});

		//load discount
		$http.get("/rest/discount/loadall").then(resp => {
			$scope.discountItem = resp.data
			$scope.pager.first();
			var today = new Date();
			$scope.discountItem.forEach(function (ddI) {
				var start = new Date(ddI.startDate);
				var end = new Date(ddI.endDate);
				
				if(today>=start&&today<=end){
					$scope.updateDisplay(ddI,true)
				}else{
					$scope.updateDisplay(ddI,false)
				}
				ddI.formattedStartDate = formatDate(ddI.startDate);
				ddI.formattedEndDate = formatDate(ddI.endDate);
			});
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
		get discountItem() {
			var start = this.page * this.size;
			return $scope.discountItem.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.discountItem.length / this.size);
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
	
	$scope.updateDisplay = function(discount,display) {
		discount.display=display
		$http.put('/rest/discount/update/' + discount.discountID, discount).then(resp => {
			var index = $scope.discountItem.findIndex(d => d.discountID == discount.discountID);
			discount.display=display
			
			$scope.discountItem[index].display = display;
			
			
			
			
		}).catch(error => {
			
			
			console.log("Error", error);
		})
	};



	//	Xóa form
	$scope.reset = function () {
		$scope.form = {

		};
	}
	//validate discount
	$scope.validateDiscount = function () {
		if ($scope.form.directDiscount < 0) {
			alert("djfhasdf")
			$scope.form.directDiscount = 0;
		} else if ($scope.form.directDiscount > 100) {
			$scope.form.directDiscount = 100;
		}
	};
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function (ddI) {

		$scope.form = angular.copy(ddI);

		$scope.form.startDate = new Date($scope.form.startDate);
		$scope.form.endDate = new Date($scope.form.endDate);
		$scope.form.discountRate = $scope.form.discountRate * 100


	}


	//	Thêm mới 
	$scope.create = function () {
		


		
		if (!$scope.form.discountName) {
			$scope.errorMessage = "Vui lòng tên giảm giá!";
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
		if (!$scope.form.discountRate) {
			$scope.errorMessage = "Vui lòng nhập mức giảm giá!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.startDate) {
			$scope.errorMessage = "Vui lòng nhập ngày bắt đầu!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.endDate) {
			$scope.errorMessage = "Vui lòng nhập ngày kết thúc!!";

			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//lỗi ngày 
		var today = new Date();
		if ($scope.form.startDate < today) {
			$scope.errorMessage = "Ngày bắt đầu không thể ở quá khứ";
			console.log($scope.form.startDate);
			$('#errorModal').modal('show');
			return;
		}

		if ($scope.form.endDate < $scope.form.startDate) {
			$scope.errorMessage = "Ngày kết thúc phải sau ngày bắt đầu";
			$('#errorModal').modal('show');
			return;
		}

		// if ($scope.form.dateStart > today) {
		// 	$scope.errorMessage = "Ngày bắt đầu phải sau ngày hiện tại";
		// 	$('#errorModal').modal('show');
		// 	return;
		// }

		//format date
		var dynamicDateValueS = $scope.form.startDate;
		var dynamicDateObjectS = new Date(dynamicDateValueS);
		var isoDynamicDateStringS = dynamicDateObjectS.toISOString().slice(0, 19).replace('T', ' ');;
		var dynamicDateValueE = $scope.form.endDate;
		var dynamicDateObjectE = new Date(dynamicDateValueE);
		var isoDynamicDateStringE = dynamicDateObjectE.toISOString().slice(0, 19).replace('T', ' ');;
		//format deciaml
		var percentageValue = $scope.form.discountRate;

		// Convert the percentage to a decimal value
		var decimalValue = percentageValue / 100;

		var discount = angular.copy($scope.form);
		discount.startDate = isoDynamicDateStringS;
		discount.startEnd = isoDynamicDateStringE;

		discount.discountRate = decimalValue;

		

		$http.post('/rest/discount/create', discount).then(resp => {
			
			resp.data.display = false;
			$scope.discountItem.push(resp.data);
			
			
			
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
		if (!$scope.form.discountName) {
			$scope.errorMessage = "Vui lòng tên giảm giá!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		if (!$scope.form.discountRate) {
			$scope.errorMessage = "Vui lòng nhập mức giảm giá!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.startDate) {
			$scope.errorMessage = "Vui lòng nhập ngày bắt đầu!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		if (!$scope.form.endDate) {
			$scope.errorMessage = "Vui lòng nhập ngày kết thúc!!";

			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//lỗi ngày 
		var today = new Date();
		if ($scope.form.startDate < today) {
			$scope.errorMessage = "Ngày bắt đầu không thể ở quá khứ";
			console.log($scope.form.startDate);
			$('#errorModal').modal('show');
			return;
		}

		if ($scope.form.endDate < $scope.form.startDate) {
			$scope.errorMessage = "Ngày kết thúc phải sau ngày bắt đầu";
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
		var percentageValue = $scope.form.discountRate;

		// Convert the percentage to a decimal value
		var decimalValue = percentageValue / 100;

		var discount = angular.copy($scope.form);

		discount.startDate = isoDynamicDateStringS;
		discount.EndDate = isoDynamicDateStringE;

		discount.discountRate = decimalValue;

		$http.put('/rest/discount/update/' + discount.discountID, discount).then(resp => {
			var index = $scope.discountItem.findIndex(d => d.discountID == discount.discountID);
			$scope.discountItem[index] = discount;
			$scope.messageSuccess = "Cập nhật thành công";
			$scope.initialize();
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Cập nhật thất bại";
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
		$scope.form.startDate = new Date($scope.form.startDate);
		$scope.form.endDate = new Date($scope.form.endDate);
			var today = new Date();
			if (today>$scope.form.startDate&&today<$scope.form.endDate) {
				$scope.errorMessage = "Giảm giá đang trong thời gian diễn ra";
				$('#errorModal').modal('show'); 
		$('#confirmDeleteModal').modal('hide');

				return
			}
		$http.delete('/rest/discount/delete/' + $scope.form.discountID).then(resp => {
			var index = $scope.discountItem.findIndex(d => d.discountID == $scope.form.discountID);
			$scope.discountItem.splice(index, 1);
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
	//	Xóa 
	$scope.delete = function (discount) {
		$http.delete('/rest/discount/delete/' + $scope.form.discountID).then(resp => {
			var index = $scope.discountItem.findIndex(d => d.discountID == discount.discountID);
			var start = new Date(index.startDate);
			var end = new Date(index.endDate);
			var today = new Date();

			if (today>start&&today<end) {
				$scope.errorMessage = "Giảm giá đang trong thời gian diễn ra";
				$('#errorModal').modal('show'); 
				return
			}

			$scope.discountItem.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})
	}

	
});