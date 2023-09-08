app.controller("supplier-ctrl", function($scope, $http){
    $scope.items = [];
	$scope.form = {
        supplierName: '',
        businessName: '',
        phoneNumber: '',
        email: '',
        display: true
    };

    $scope.initialize = function () {
		// Load suppliers
		$http.get("/rest/supplier").then(resp => {
			$scope.items = resp.data;
			$scope.pager.first();
			
		}).catch(error => {
			console.log("Error fetching suppliers:", error);
			// Xử lý lỗi ở đây (ví dụ: hiển thị thông báo lỗi)
		});
	}

    $scope.initialize();

    //ham create
    $scope.create = function (){
		//bo trong ten
		if (!$scope.form.supplierName) {
			$scope.errorMessage = "Vui lòng nhập tên nhà cung cấp!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//loi trung
		let existingSupplier = $scope.items.find(item => item.supplierName === $scope.form.supplierName);
		if (existingSupplier) {
			$scope.errorMessage = "Tên nhà cung cấp đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong ten dn
		if (!$scope.form.businessName) {
			$scope.errorMessage = "Vui lòng nhập tên nhà doanh nghiệp!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//loi nhap trung ten doanh nghiep
		let existingbusiness = $scope.items.find(item => item.businessName === $scope.form.businessName);
		if (existingbusiness) {
			$scope.errorMessage = "Tên doanh nghiệp đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong so dien thoai
		if (!$scope.form.phoneNumber) {
			$scope.errorMessage = "Vui lòng nhập số điện thoại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} else if (!/^0\d{9}$/.test($scope.form.phoneNumber)) {
			$scope.errorMessage = "Số điện thoại không hợp lệ!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		// Kiểm tra trùng số điện thoại
		let existingPhone = $scope.items.find(item => item.phoneNumber === $scope.form.phoneNumber);
		if (existingPhone) {
			$scope.errorMessage = "Số điện thoại đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong email va kiem tra email
		if (!$scope.form.email) {
			$scope.errorMessage = "Vui lòng nhập email!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} else if (!/\S+@\S+\.\S+/.test($scope.form.email)) {
			$scope.errorMessage = "Email không hợp lệ. Vui lòng nhập email chính xác!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		// Kiểm tra trùng email
		let existingEmail = $scope.items.find(item => item.email === $scope.form.email);
		if (existingEmail) {
			$scope.errorMessage = "Email đã tồn tại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

        let newItem = angular.copy($scope.form);
		$http.post(`/rest/supplier/createSup`, newItem).then(response => {
			let data = response.data;
			$scope.items.push(data);
			$scope.reset();
			$scope.messageSuccess = "Thêm thành công nhà cung cấp";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			alert("Lỗi");
			console.log("Error", error);
		});
    }

    //ham update
    $scope.update = function () {
		//bo trong ten
		if (!$scope.form.supplierName) {
			$scope.errorMessage = "Vui lòng nhập tên nhà cung cấp!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong ten dn
		if (!$scope.form.businessName) {
			$scope.errorMessage = "Vui lòng nhập tên nhà doanh nghiệp!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong so dien thoai
		if (!$scope.form.phoneNumber) {
			$scope.errorMessage = "Vui lòng nhập số điện thoại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		//bo trong email va kiem tra email
		if (!$scope.form.email) {
			$scope.errorMessage = "Vui lòng nhập email!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		} else if (!/\S+@\S+\.\S+/.test($scope.form.email)) {
			$scope.errorMessage = "Email không hợp lệ. Vui lòng nhập email chính xác!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		var item = angular.copy($scope.form);
		$http.put(`/rest/supplier/updateSup/${item.supplierID}`, item).then(resp => {
			var index = $scope.items.findIndex(p => p.supplierID == item.supplierID);
			$scope.items[index] = item;
			$scope.messageSuccess = "Cập nhật thành công nhà cung cấp";
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
		$http.delete('/rest/supplier/deleteSup/' + $scope.form.supplierID).then(resp => {
			var index = $scope.items.findIndex(p => p.supplierID == $scope.form.supplierID);
			$scope.items.splice(index, 1);
			$scope.reset();
			$scope.messageSuccess = "Xóa thành công";
			$('#errorModal1').modal('show'); // Show the modal
		}).catch(error => {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		})

		// Đóng modal xác nhận xóa
		$('#confirmDeleteModal').modal('hide');
	}

    //xoa form
    $scope.reset = function () {
		$scope.form = {
			display: true
		};
	}

    //hien thi len form
	$scope.edit = function (item) {
		$scope.form = angular.copy(item);
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