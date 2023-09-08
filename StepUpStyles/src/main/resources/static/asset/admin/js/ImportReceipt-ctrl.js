app.controller("ImportReceipt-ctrl", function ($scope, $http) {
	$scope.items = [];
	$scope.importSup = [];
	$scope.form = {};
	$scope.form.supplier = {};
	$scope.form.user = {};
	$scope.importDetail = [];
	$scope.form.importDetail = {};
	$scope.importReceiptDetailItems = [];

	$scope.initialize = function () {
		//load import
		$http.get("/rest/ImportReceipt").then(resp => {
			$scope.items = resp.data;
			$scope.items.forEach(item => {
				item.importDate = new Date(item.importDate)
				item.totalAmount = 0; // Khởi tạo giá trị totalAmount
			});
			$scope.items.sort((a, b) => b.importDate - a.importDate);
			$scope.pager.first();
		});

		//load supplier
		$http.get("/rest/supplier").then(resp => {
			$scope.importSup = resp.data;
			$scope.pager.first();
		});

		$http.get("/rest/importDetails").then(resp => {
			$scope.importDetail = resp.data;
			$scope.pager.first();
			$scope.importDetail.forEach(detail => {
				//tinh tong tien tu phieu nhap chi tiet
				detail.totalAmount = detail.price * detail.quantity;

				//tim nhung id phieu nhap tuong ung dua tren importReceiptID
				const tuongungItem = $scope.items.find(item => item.importReceiptID === detail.importReceipt.importReceiptID);

				//Neu tim thay id phieu nhap tuong ung trong danh sach
				if (tuongungItem) {
					//tinh tong tien cho phieu nhap bang cach cong them tong tien chi tiet vua tinh vao tong hien tai
					tuongungItem.totalAmount += detail.totalAmount;
				}else {
					console.log(`khong tim thay ${detail.importReceipt.importReceiptID}`);
				}

				// tao bien updatetotaldata gui yeu cau len may chu
				const updateTotalData = {
					totalAmount: tuongungItem.totalAmount
				};

				$http.put(`/rest/ImportReceipt/ImportReceipt/${tuongungItem.importReceiptID}`, updateTotalData)
					.then(response => {
						
					})
					.catch(error => {
						// Xử lý lỗi
					});
			});
		});
	}


	$scope.initialize();

	//xem chi tiet phieu nhap
	$scope.getimportReceiptDetailID = function(importReceiptDetailID) {
		$http.get("/rest/importDetails/getImpDetail/" + importReceiptDetailID).then(resp => {			
		console.log(resp.data);
		$scope.importReceiptDetailItems = resp.data;
		$('#orderModal').modal('show');
	    }	    
	)}

	//	Hiển thị lên form
	$scope.edit = function (items) {
		$scope.form = angular.copy(items);
	}

	//	Xóa form
	$scope.reset = function () {
		$scope.form = {

		};
	}

	//format tien te vnd
	$scope.formatToVND = function (amount) {
		// Logic để định dạng số amount sang định dạng VND
		return amount.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
	};


	//	Thêm mới 
	$scope.create = function () {
		//khong chon nha cung cap
		if (!$scope.form.supplier || !$scope.form.supplier.supplierID) {
			$scope.errorMessage = "Vui lòng chọn nhà cung cấp!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		$http.get("/api/user").then(resp => {
			const email = resp.data.username; // Lấy email từ userDetails
			// Truy vấn cơ sở dữ liệu để lấy userID từ email
			$http.get("/rest/ImportReceipt/usersByEmail/" + email).then(userResp => {
				var userID = userResp.data.userID;
				$scope.form.user = { userID: userID }; // Gán userID cho phiếu nhập
				let newItem = angular.copy($scope.form);
				newItem.importDate = new Date();  // Lấy ngày giờ hiện tại
				$http.post(`/rest/ImportReceipt/createImp`, newItem).then(response => {
					let data = response.data;
					data.importDate = new Date(data.importDate); // Chuyển đổi ngày giờ từ response
					data.totalAmount = 0;
					$scope.items.push(data);
					$scope.reset();
					$scope.messageSuccess = "Thêm thành công phiếu nhập";
					$scope.initialize();
					$('#errorModal1').modal('show'); // Show the modal
				}).catch(error => {
					$scope.initialize();
					$scope.errorMessage = "Lỗi!!";
					$('#errorModal').modal('show'); // Show the modal
					console.log("Error", error);
				});
			})
		})
	}


	//ham update
	$scope.update = function () {
		//khong chon nha cung cap
		if (!$scope.form.supplier || !$scope.form.supplier.supplierID) {
			$scope.errorMessage = "Vui lòng chọn nhà cung cấp!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//ham update

		$http.get("/api/user").then(resp => {
			const email = resp.data.username; // Lấy email từ userDetails
			// Truy vấn cơ sở dữ liệu để lấy userID từ email
			$http.get("/rest/ImportReceipt/usersByEmail/" + email).then(userResp => {
				var userID = userResp.data.userID;
				$scope.form.user = { userID: userID }; // Gán userID cho phiếu nhập

				let item = angular.copy($scope.form); 
				item.user.userID = userID;
				$http.put('/rest/ImportReceipt/updateImp/' + item.importReceiptID, item).then(resp => {
					var index = $scope.items.findIndex(p => p.importReceiptID == item.importReceiptID);
					$scope.items[index] = item;
					$scope.initialize();
					$scope.messageSuccess = "Cập nhật thành công phiếu nhập";
					$('#errorModal1').modal('show'); // Show the modal
				}).catch(error => {
					alert("Loi cap nhat");
					console.log("Error", error);
				})
			})
		})
	}

	//Gọi đến modal xác nhận
	$scope.confirmDeleteModal = function() {
		$('#confirmDeleteModal').modal('show');
	}

	$scope.confirmDeleteModal1 = function(item) {
		$scope.form = angular.copy(item); // Set form data for confirmation modal
		$('#confirmDeleteModal').modal('show'); // Show the confirmation modal
	}

	//sau khi xác nhận thành công thì xóa
	$scope.confirmDelete = function() {

		// Thực hiện xóa nhóm sản phẩm
		$http.delete('/rest/ImportReceipt/deleteImp/' + $scope.form.importReceiptID).then(resp => {
			var index = $scope.items.findIndex(p => p.importReceiptID == $scope.form.importReceiptID);
			$scope.items.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công phiếu nhập";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})

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
		get items() {
			var start = this.page * this.size;
			return $scope.items.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.items.length / this.size);
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