app.controller("supplier-ctrl", function($scope, $http){
    $scope.items = [];
	$scope.itemss = [];
	$scope.itemsss = [];
	$scope.form = {
        supplierName: '',
        phone: '',
        email: '',
		addresss: '',
        display: true,
		deleted: false
    };

	$scope.sortableColumns = [
		{ name: 'supplierId', label: 'Mã nhà cung cấp' },
		// { name: 'modifyDate', label: 'Thời gian' },
		{ name: 'supplierName', label: 'Tên nhà cung cấp' },
		{ name: 'addresss', label: 'Địa chỉ' },
		{ name: 'phone', label: 'Số điện thoại' },
		{ name: 'email', label: 'Email' },
		{ name: 'display', label: 'Hiển thị' },
	];

	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.itemss.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			// if (columnName === 'category.categoryName') {
			// 	aValue = a.category.categoryName;
			// 	bValue = b.category.categoryName;
			// }
			// if (columnName === 'brand.brandName') {
			// 	aValue = a.brand.brandName;
			// 	bValue = b.brand.brandName;
			// }
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

	$scope.exportPdf = function () {
		$http({
		  method: "POST",
		  url: "/supplier-pdf",
		  data: $scope.itemss,
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
			a.download = "DSSupplier.pdf";
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
		  url: "/export-excelSup", // Thay thế với URL phía máy chủ đúng
		  data: $scope.itemss,
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
			a.download = "SupplierStepUpStyle.xlsx"; // Đặt tên tệp Excel mong muốn
			document.body.appendChild(a);
			a.click();
			URL.revokeObjectURL(url);
		  })
		  .catch(function (error) {
			console.error("Xuất ra Excel thất bại:", error);
		  });
	  };

    $scope.initialize = function () {
		//load all supplier
		$http.get("/rest/supplier").then(resp => {
			$scope.items = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
			
		});

		//load supplier deleted
		$http.get("/rest/supplier/deleted").then(resp => {
			$scope.itemsss = resp.data;
			$scope.pager.first();
			$scope.RestorePager.first();
			
		});

		//load supplier no deleted
		$http.get("/rest/supplier/nodeleted").then(resp => {
			resp.data.sort((a, b) => b.supplierId - a.supplierId);
			$scope.itemss = resp.data;
			console.log($scope.itemss)
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

    $scope.initialize();

    //ham create
    $scope.create = function (){
		//bo trong ten
		if (!$scope.form.supplierName) {	
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên nhà cung cấp!!!',
			})
			return;
		}
		//loi trung
		let existingSupplier = $scope.items.find(item => item.supplierName === $scope.form.supplierName);
		if (existingSupplier) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tên nhà cung cấp đã tồn tại!!',
			})
			return;
		}
		// bo trong address
		if (!$scope.form.addresss) {	
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập địa chỉ!!!',
			})
			return;
		}
		//bo trong so dien thoai
		if (!$scope.form.phone) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập số điện thoại!!!',
			})
			return;
		} else if (!/^0\d{9}$/.test($scope.form.phone)) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Số điện thoại không hợp lệ!!!',
			})
			return;
		}

		// Kiểm tra trùng số điện thoại
		let existingPhone = $scope.items.find(item => item.phone === $scope.form.phone);
		if (existingPhone) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Số điện thoại đã tồn tại!!!',
			})
			return;
		}
		//bo trong email va kiem tra email
		if (!$scope.form.email) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập email!!!',
			})
			return;
		} else if (!/\S+@\S+\.\S+/.test($scope.form.email)) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Email không hợp lệ. Vui lòng nhập email chính xác!!',
			})
			return;
		}
		// Kiểm tra trùng email
		let existingEmail = $scope.items.find(item => item.email === $scope.form.email);
		if (existingEmail) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Email đã tồn tại!!',
			})
			return;
		}

        let newItem = angular.copy($scope.form);
		newItem.deleted = false;
		$http.post(`/rest/supplier/createSupp`, newItem).then(response => {
			let data = response.data;
			$scope.items.push(data);
			$scope.reset();
			$scope.initialize();
			Swal.fire({
				icon: 'success',
				title: 'Thành công',
				text: 'Thêm nhà cung cấp thành công!',
			})
		}).catch(error => {
			alert("Lỗi");
			console.log("Error", error);
		});
    }

    //ham update
    $scope.update = function () {
		//bo trong ten
		if (!$scope.form.supplierName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên nhà cung cấp!!!',
			})
			return;
		}
		//bo trong so dien thoai
		if (!$scope.form.phone) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập số điện thoại!!!',
			})
			return;
		} else if (!/^0\d{9}$/.test($scope.form.phone)) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Số điện thoại không hợp lệ!!!',
			})
			return;
		}
		//bo trong email va kiem tra email
		if (!$scope.form.email) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập email!!!',
			})
			return;
		} else if (!/\S+@\S+\.\S+/.test($scope.form.email)) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Email không hợp lệ. Vui lòng nhập email chính xác!!',
			})
			return;
		}

		var item = angular.copy($scope.form);
		$http.put(`/rest/supplier/updateSupp/${item.supplierId}`, item).then(resp => {
			var index = $scope.items.findIndex(p => p.supplierId == item.supplierId);
			$scope.items[index] = item;
			$scope.reset();
			Swal.fire({
				icon: 'success',
				title: 'Thành công',
				text: 'Cập nhật nhà cung cấp thành công!',
			})
			$scope.initialize();
		}).catch(error => {
			alert("Loi cap nhat");
			console.log("Error", error);
		})
	}

	//Gọi đến modal xác nhận để xóa vào thùng rác
	$scope.confirmHideModal1 = function(item) {
		$scope.form = angular.copy(item);
		$('#confirmHideModal').modal('show');
	}
	//Xóa vào thùng rác
	$scope.confirmHide = function() {
		var item = angular.copy($scope.form);
		item.deleted = true;
		$http.put('/rest/supplier/updateSupp/' + item.supplierId, item).then(resp => {
			var index = $scope.itemss.findIndex(p => p.supplierId == item.supplierId);
			$scope.itemss[index] = item;
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

	//Mở modal thùng rác
	$scope.openRecycleBinForm = function() {
		// Reset searchKeyword
		searchValue = '';
		$('#recycleBinModal').modal('show');
	};

	//Gọi đến modal xác nhận để khôi phục item từ thùng rác
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
		$http.put('/rest/supplier/updateSupp/' + item.supplierId, item).then(resp => {
			var index = $scope.items.findIndex(p => p.supplierId == item.supplierId);
			$scope.items[index] = item;
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

	//search
	$scope.searchByName = function(){
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/supplier/searchSupplier", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.itemss = resp.data;
				$scope.pager.first();
			}).catch(error => {
				console.log("Error", error);
				$scope.pager.first();
			});
		}else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
		}
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
		var supplierId = $scope.form.supplierId; // Lấy supplierId từ form
    	$scope.deleted(supplierId); // Gọi hàm deleted với supplierId

		// Đóng modal xác nhận xóa
		$('#confirmDeleteModal').modal('hide');
	}

	//Gọi đến modal xác nhận để xóa luôn
	$scope.confirmDeleteModal1 = function(item) {
		$scope.form = angular.copy(item);

		// Đóng modal thùng rác
		$('#recycleBinModal').modal('hide');

		$('#confirmDeleteModal').modal('show');
	}

	//sau khi xác nhận thành công thì xóa luôn
	$scope.confirmDelete = function() {
		// Thực hiện xóa
		$http.delete('/rest/supplier/removeSupp/' + $scope.form.supplierId).then(resp => {
			var index = $scope.itemss.findIndex(p => p.supplierId == $scope.form.supplierId);
			$scope.itemss.splice(index, 1);
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

	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở Table)
	$scope.confirmHideTable = function(item) {
		$scope.form = angular.copy(item);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa nhà cung cấp này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				item.deleted = true;
				$http.put('/rest/supplier/updateSupp/' + item.supplierId, item).then(resp => {
					var index = $scope.itemss.findIndex(p => p.supplierId == item.supplierId);
					$scope.itemss[index] = item;
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
			text: "Bạn có chắc chắn muốn xóa nhà cung cấp này không?",
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
				$http.put('/rest/supplier/updateSupp/' + item.supplierId, item).then(resp => {
					var index = $scope.itemss.findIndex(p => p.supplierId == item.supplierId);
					$scope.itemss[index] = item;
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
			text: "Bạn có chắc chắn muốn khôi phục nhà cung cấp này không?",
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
				$http.put('/rest/supplier/updateSupp/' + item.supplierId, item).then(resp => {
					var index = $scope.items.findIndex(p => p.supplierId == item.supplierId);
					$scope.items[index] = item;
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
	$scope.confirmDelete = function(item) {
		$scope.form = angular.copy(item);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa nhà cung cấp này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				$http.delete('/rest/supplier/removeSupp/' + $scope.form.supplierId).then(resp => {
					var index = $scope.itemsss.findIndex(p => p.supplierId == $scope.form.supplierId);
					$scope.itemsss.splice(index, 1);
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

	//loc display
	$scope.filterByDisplay = function() {
		if ($scope.selectedDisplay === "") {
			$http.get("/rest/supplier/nodeleted").then(resp => {
				$scope.itemss = resp.data;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách sản phẩm!',
				});

				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/supplier/nodeleted").then(resp => {
				const selectedStatus = $scope.selectedDisplay === "true";
				const filteredSizes = resp.data.filter(itemss => itemss.display === selectedStatus);
				$scope.itemss = filteredSizes;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách sản phẩm theo trạng thái!',
				});

				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};
	
	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})

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

	$scope.formatPhoneNumber = function (phoneNumber) {
		// Loại bỏ tất cả các ký tự không phải là số
		var numericPhoneNumber = phoneNumber.replace(/\D/g, '');
	
		// Kiểm tra xem có đủ số để định dạng không
		if (numericPhoneNumber.length >= 10) {
			// Tạo một mảng để lưu trữ các đoạn của số điện thoại
			var chunks = [];
	
			// Lấy 4 số đầu tiên và thêm vào mảng
			chunks.push(numericPhoneNumber.substr(0, 4));
	
			// Lặp qua phần còn lại của số điện thoại và chia thành các đoạn 3 số
			for (var i = 4; i < numericPhoneNumber.length; i += 3) {
				chunks.push(numericPhoneNumber.substr(i, 3));
			}
	
			// Kết hợp các đoạn bằng khoảng trắng
			return chunks.join(' ');
		} else {
			// Trả về số điện thoại không thay đổi nếu không đủ số
			return phoneNumber;
		}
	};
	
	$scope.formatAddress = function (address) {
		// Đặt một giới hạn độ dài cho địa chỉ
		var maxLength = 20;
	
		// Kiểm tra độ dài địa chỉ và trả về địa chỉ được cắt hoặc không đổi
		if (address.length > maxLength) {
			return address.substring(0, maxLength) + '...';
		} else {
			return address;
		}
	};	

    //Phân trang
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
			return visiblePages;
		},
		get itemss() {
			var start = this.page * this.size;
			return $scope.itemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.itemss.length / this.size);
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
		get itemsss() {
			var start = this.page * this.size;
			return $scope.itemsss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.itemsss.length / this.size);
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