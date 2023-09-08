app.controller("ImportReceiptDetail-ctrl", function($scope, $http){
    $scope.items = [];
    $scope.form = {};
    $scope.prods = [];
    $scope.form.products = {};
    $scope.importReceipt = [];
    $scope.form.importReceipt = {};

    $scope.initialize = function() {
		// Load importdetail
		$http.get("/rest/importDetails").then(resp => {
			$scope.items = resp.data;
			$scope.items.sort((a, b) => b.importReceipt.importReceiptID - a.importReceipt.importReceiptID);
			$scope.pager.first();
		});
	
		// Load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
			$scope.items.forEach(item => {
				item.createDate = new Date(item.createDate);
			});
			$scope.pager.first();
		});
	
		// Load import
		$http.get("/rest/ImportReceipt").then(resp => {
			$scope.importReceipt = resp.data;
			$scope.items.forEach(item => {
				item.importDate = new Date(item.importDate);
			});
			$scope.pager.first();
		});
	}
	

    $scope.initialize();

	//	Hiển thị lên form
	$scope.edit = function(items) {
		$scope.form = angular.copy(items);
	}

    //	Xóa form
	$scope.reset = function() {
		$scope.form = {
			
		};
	}

	//format tien te vnd
	$scope.formatToVND = function(amount) {
		// Logic để định dạng số amount sang định dạng VND
		return amount.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
	};

	//	Thêm mới 
	$scope.create = function() {
		//khong chon phieu nhap
		if (!$scope.form.importReceipt || !$scope.form.importReceipt.importReceiptID) {
			$scope.errorMessage = "Vui lòng chọn phiếu nhập!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//khong chon san pham
		if (!$scope.form.product || !$scope.form.product.productID) {
			$scope.errorMessage = "Vui lòng chọn sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong so luong
		if (!$scope.form.quantity) {
			$scope.errorMessage = "Vui lòng nhập số lượng!!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} if (!/^\d+$/.test($scope.form.quantity) || parseInt($scope.form.quantity) <= 0) {
			$scope.errorMessage = "Số lượng phải là số dương!!!";
			$('#errorModal').modal('show'); // Show the modal
			return; // Ngừng thực hiện hàm nếu có lỗi
		}
		//bo trong gia
		if (!$scope.form.price) {
			$scope.errorMessage = "Vui lòng nhập giá!!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} if (!/^\d+$/.test($scope.form.price) || parseInt($scope.form.price) <= 0) {
			$scope.errorMessage = "Giá phải là số dương!!!";
			$('#errorModal').modal('show'); // Show the modal
			return; // Ngừng thực hiện hàm nếu có lỗi
		}

		let newItem = angular.copy($scope.form);
		$http.post(`/rest/importDetails/createImpDetail`, newItem).then(response => {
			let data = response.data;
			$scope.items.push(data);
			$scope.reset();
			$scope.initialize();
			$scope.messageSuccess = "Thêm thành công chi tiết phiếu nhập";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			alert("Lỗi");
			console.log("Error", error);
		});
	}

	//ham update
	$scope.update = function () {
		//khong chon phieu nhap
		if (!$scope.form.importReceipt || !$scope.form.importReceipt.importReceiptID) {
			$scope.errorMessage = "Vui lòng chọn phiếu nhập!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//khong chon san pham
		if (!$scope.form.product || !$scope.form.product.productID) {
			$scope.errorMessage = "Vui lòng chọn sản phẩm!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong so luong
		if (!$scope.form.quantity) {
			$scope.errorMessage = "Vui lòng nhập số lượng!!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} if (!/^\d+$/.test($scope.form.quantity) || parseInt($scope.form.quantity) <= 0) {
			$scope.errorMessage = "Số lượng phải là số dương!!!";
			$('#errorModal').modal('show'); // Show the modal
			return; // Ngừng thực hiện hàm nếu có lỗi
		}
		//bo trong gia
		if (!$scope.form.price) {
			$scope.errorMessage = "Vui lòng nhập giá!!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} if (!/^\d+$/.test($scope.form.price) || parseInt($scope.form.price) <= 0) {
			$scope.errorMessage = "Giá phải là số dương!!!";
			$('#errorModal').modal('show'); // Show the modal
			return; // Ngừng thực hiện hàm nếu có lỗi
		}
		//ham update
		var item = angular.copy($scope.form);
		$http.put(`/rest/importDetails/updateDetail/${item.importReceiptDetailID}`, item).then(resp => {
			var index = $scope.items.findIndex(p => p.importReceiptDetailID == item.importReceiptDetailID);
			$scope.items[index] = item;
			$scope.initialize();
			$scope.messageSuccess = "Cập nhật thành công chi tiết phiếu nhập";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			alert("Loi cap nhat");
			console.log("Error", error);
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
		$http.delete('/rest/importDetails/deleteImpDetail/' + $scope.form.importReceiptDetailID).then(resp => {
			var index = $scope.items.findIndex(p => p.importReceiptDetailID == $scope.form.importReceiptDetailID);
			$scope.items.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công chi tiết phiếu nhập";
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