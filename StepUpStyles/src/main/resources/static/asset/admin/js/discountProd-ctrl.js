app.controller("prodsDiscount-ctrl", function ($scope, $http) {
	$scope.discounts = [];
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

		//load product discount
		$http.get("/rest/discountProd/loadall").then(resp => {
			$scope.discountProdItem = resp.data
			$scope.pager.first();
			var today = new Date();
			$scope.discountProdItem.forEach(function (ddI) {

				ddI.formattedStartDate = formatDate(ddI.discount.startDate);
				ddI.formattedEndDate = formatDate(ddI.discount.endDate);

				console.log(ddI.formattedStartDate);
				console.log(ddI.formattedEndDate);
			});
		})

		//load directdiscount
		$http.get("/rest/discount/loadall").then(resp => {
			$scope.discounts = resp.data
			console.log(resp.data);
			var today = new Date();
			$scope.discounts.forEach(function (ddI) {
				var start = new Date(ddI.startDate);
				var end = new Date(ddI.endDate);

				if (today >= start && today <= end) {
					$scope.updateDisplay(ddI, true)
				} else {
					$scope.updateDisplay(ddI, false)
				}

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
	$scope.showSelected = function () {
		console.log('Selected items:', $scope.selectedItems);
	};

	$scope.updateDisplay = function (discount, display) {
		discount.display = display
		$http.put('/rest/discount/update/' + discount.discountID, discount).then(resp => {
			var index = $scope.discounts.findIndex(d => d.discountID == discount.discountID);
			discount.display = display

			$scope.discounts[index].display = display;




		}).catch(error => {


			console.log("Error", error);
		})
	};


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
		$scope.form.discountRate = $scope.form.discountRate * 100


	}

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 5,
		getPageNumbers: function () {
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
		get discountProdItem() {
			var start = this.page * this.size;
			return $scope.discountProdItem.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.discountProdItem.length / this.size);
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

	//	Thêm mới 
	$scope.create = function () {
		//Không chọn sản phẩm
		if (!$scope.form.product || !$scope.form.product.productID) {
			$scope.errorMessage = "Vui lòng chọn sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		if (!$scope.form.discount) {
			$scope.errorMessage = "Vui lòng chọn giảm giá!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}


		var discountProd = angular.copy($scope.form);





		$http.post('/rest/discountProd/create', discountProd).then(resp => {

			$scope.discountProdItem.push(resp.data);
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
		if (!$scope.form.product || !$scope.form.product.productID) {
			$scope.errorMessage = "Vui lòng chọn sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		if (!$scope.form.discount) {
			$scope.errorMessage = "Vui lòng chọn giảm giá!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}


		var discount = angular.copy($scope.form);

		$http.put('/rest/discountProd/update/' + discount.productDiscountID, discount).then(resp => {
			var index = $scope.discountProdItem.findIndex(d => d.discountID == discount.productDiscountID);
			$scope.discountProdItem[index] = discount;
			$scope.messageSuccess = "Cập nhật thành công";
			$scope.initialize();
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Cập nhật thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})
	}

	$scope.confirmDeleteModal = function () {
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDeleteModal1 = function (productitem) {
		$scope.form = angular.copy(productitem);
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDelete = function () {

		var check = 1;
		$scope.discounts.forEach(function (ddI) {
			console.log(1);
			if (ddI.discountID == $scope.form.discount.discountID) {
				console.log(2);
				ddI.startDate = new Date(ddI.startDate);
				ddI.endDate = new Date(ddI.endDate);
				var today = new Date();
				if (today > ddI.startDate && today < ddI.endDate) {
					console.log(3);
					$scope.errorMessage = "Giảm giá đang trong thời gian diễn ra";
					$('#errorModal').modal('show');
					$('#confirmDeleteModal').modal('hide');

					check = 2;
				} else {
					check = 1
				}
			}
		});
		if (check != 2) {


			$http.delete('/rest/discountProd/delete/' + $scope.form.productDiscountID).then(resp => {
				var index = $scope.discountProdItem.findIndex(d => d.productDiscountID == $scope.form.productDiscountID);



				$scope.discountProdItem.splice(index, 1);
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
	}


});