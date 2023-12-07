app.controller("productimage-ctrl", function($scope, $http) {
	$scope.productimageitems = [];
	$scope.prods = [];
	$scope.productNames = [];
	$scope.form = {};
	$scope.form.product = {};
	$scope.disableCreateButton = false;

	$scope.sortableColumns = [
		{ name: 'productImageID', label: 'Mã ảnh' },
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		{ name: 'modifyDate', label: 'Ngày điều chỉnh' },
		{ name: 'imagePath', label: 'Hình ảnh' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.productimageitems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'product.productName') {
				aValue = a.product.productName;
				bValue = b.product.productName;
			}
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

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 10,
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
		get productimageitems() {
			var start = this.page * this.size;
			return $scope.productimageitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productimageitems.length / this.size);
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

	$scope.initialize = function() {
		//load productimages
		$http.get("/rest/productimages/loadall").then(resp => {
			$scope.productimageitems = resp.data;
			$scope.productimageitems.forEach(productimageitem => {
				productimageitem.modifyDate = new Date(productimageitem.modifyDate)
			})
			$scope.productimageitems.sort((a, b) => b.modifyDate - a.modifyDate);
			console.log($scope.productimageitems)
			$scope.pager.first();
		});

		//load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
			console.log($scope.prods)
			$scope.productimageitems.forEach(productitem => {
				productitem.createDate = new Date(productitem.createDate)
			})
			$scope.pager.first();
		});
	}

	// Tìm kiếm  
	$scope.searchColorByName = async function() {
		const { value: searchKeyword } = await Swal.fire({
			title: 'Tìm kiếm tên sản phẩm',
			input: 'text',
			inputLabel: 'Nhập tên sản phẩm',
			inputPlaceholder: 'Nhập tên sản phẩm cần tìm kiếm'
		});

		if (searchKeyword && searchKeyword.trim() !== "") {
			$http.get("/rest/productimages/search", {
				params: { keyword: searchKeyword }
			}).then(resp => {
				$scope.productimageitems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy sản phẩm có tên ' + searchKeyword,
					});
				}
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tìm kiếm sản phẩm!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không tìm thấy tên sản phẩm mà bạn mong muốn!',
			});
		}
	};


	$scope.filterByProduct = function() {
		if ($scope.selectedProduct) {
			$http.get("/rest/productimages/loadbyproduct/" + $scope.selectedProduct).then(resp => {
				$scope.productimageitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách màu sắc theo sản phẩm!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};




	// Hàm giới hạn độ dài của đường dẫn
	$scope.truncateUrl = function(url) {
		const maxLength = 50; // Độ dài tối đa bạn muốn hiển thị
		if (url.length > maxLength) {
			return url.substring(0, maxLength) + '...';
		} else {
			return url;
		}
	};

	// Tải ảnh lên Firebase	
	$scope.uploadImages = function() {
		var ref = firebase.storage().ref();
		var folder = 'productImage';
		var file = document.querySelector('#photo').files[0];
		var metadata = {
			contentType: file.type
		};
		var name = folder + '/' + file.name; // Tạo tên file với thư mục

		var uploadIMG = ref.child(name).put(file, metadata);

		return uploadIMG.then(snapshot => snapshot.ref.getDownloadURL())
			.then(url => {
				// Lưu đường dẫn ảnh vào biến $scope.form.imagePath
				$scope.form.imagePath = url;
			});
	};


	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
		};
		var fileInput = document.getElementById('photo');
		if (fileInput) {
			fileInput.value = '';
		}
		$scope.disableCreateButton = false;
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(productimageitem) {
		$scope.form = angular.copy(productimageitem);
		 $scope.disableCreateButton = true;
	}

	function checkDuplicateColor(productimageitem) {
		// Kiểm tra sự trùng lặp dựa trên productID, sizeID và productImageID
		var isDuplicate = $scope.productimageitems.some(function(item) {
			return (
				item.product.productID === productimageitem.product.productID &&
				item.colorName === productimageitem.colorName
			);
		});

		return isDuplicate;
	}

	//	Thêm mới 
	$scope.create = async function() {

		//Lỗi không chọn sản phẩm 
		if (!$scope.form.product.productID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Bạn chưa chọn sản phẩm!!',
			});
			return;
		}


		// Kiểm tra sự trùng lặp
		//		var isDuplicate = checkDuplicateColor($scope.form);
		//		if (isDuplicate) {
		//			$scope.errorMessage = "Sản phẩm mà bạn chọn đã có màu này rồi. Vui lòng nhập màu khác!";
		//			$('#errorModal').modal('show');
		//			return;
		//		}


		//Lỗi không chọn ảnh
		if (!document.querySelector('#photo').files[0]) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Bạn chưa chọn ảnh!!',
			});
			return; // Dừng tiến trình nếu không chọn ảnh
		};

		try {
			await $scope.uploadImages(); // Tải ảnh lên Firebase

			// Thực hiện việc lưu vào db
			var productimageitem = angular.copy($scope.form);
			productimageitem.imagePath = $scope.form.imagePath;
			productimageitem.modifyDate = new Date();
			$http.post('/rest/productimages/create', productimageitem).then(resp => {
				resp.data.modifyDate = new Date(resp.data.modifyDate);
				$scope.productimageitems.push(resp.data);
				$scope.reset();
				Swal.fire({
					icon: 'success',
					title: 'Thành công',
					text: 'Thêm mới thành công!!',
				});
				$scope.initialize();
			}).catch(error => {
				if (error.status === 400) {
					$scope.errorMessage = error.data;
					$scope.initialize();
				} else {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Thêm mới thất bại!!',
					});
					$scope.initialize();
					console.log("Error", error);
				}
			});
		} catch (error) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tải ảnh lên firebase thất bại!!',
			});
			$scope.initialize();
		}
	}

	//Cập nhật
	$scope.update = async function() {
		//Lỗi không chọn sản phẩm 
		if (!$scope.form.product.productID) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Bạn chưa chọn sản phẩm!!',
			});
			return;
		}

		try {

			var newImageFile = document.querySelector('#photo').files[0];
			if (newImageFile) {
				await $scope.uploadImages();
			}

			var productimageitem = angular.copy($scope.form);
			productimageitem.imagePath = $scope.form.imagePath;
			productimageitem.modifyDate = new Date();
			$http.put('/rest/productimages/update/' + productimageitem.productImageID, productimageitem).then(resp => {
				var index = $scope.productimageitems.findIndex(p => p.productImageID == productimageitem.productImageID);
				resp.data.modifyDate = new Date(resp.data.modifyDate);
				$scope.productimageitems[index] = productimageitem;
				Swal.fire({
					icon: 'success',
					title: 'Thành công',
					text: 'Cập nhật thành công!!',
				});
				$scope.initialize();
				$scope.disableCreateButton = false;
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Cập nhật thất bại!!',
				});
				$scope.initialize();
				console.log("Error", error);
			})
		} catch (error) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tải ảnh lên firebase thất bại!!',
			});
			$scope.initialize();
		}
	}
	
	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở FORM) bắt đầu
	$scope.confirmDelete = function() {
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa hình ảnh này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				var productimageitem = angular.copy($scope.form);
				$http.delete('/rest/productimages/delete/' + productimageitem.productImageID).then(resp => {
					var index = $scope.productimageitems.findIndex(p => p.productImageID == $scope.form.productImageID);
					$scope.productimageitems.splice(index, 1);
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
	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở FORM) Kết thúc

	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở TABLE) bắt đầu
	$scope.confirmDeleteTable = function(productimageitem) {
		$scope.form = angular.copy(productimageitem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa hình ảnh này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				$http.delete('/rest/productimages/delete/' + $scope.form.productImageID).then(resp => {
					var index = $scope.productimageitems.findIndex(p => p.productImageID == $scope.form.productImageID);
					$scope.productimageitems.splice(index, 1);
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
	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở TABLE) Kết thúc
	
	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})

	$('.export').click(function() {

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
			}
			//code xuất file
			var table2excel = new Table2Excel();
			table2excel.export(document.querySelectorAll("table.table"));
		})

	});

	$('.pdf-file').click(function() {
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
			}

			//code xuất file
			var elment = document.getElementById('sampleTable');
			var opt = {
				margin: 0.5,
				filename: 'myfilepdf.pdf',
				image: { type: 'jpeg', quality: 0.98 },
				html2canvas: { scale: 2 },
				jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
			};
			html2pdf(elment, opt);
		})
	});

	var myApp1 = new function() {
		this.printTable = function() {
			var tab = document.getElementById('sampleTable');
			var win = window.open('', '', 'height=700,width=700');
			win.document.write(tab.outerHTML);
			win.document.close();
			win.print();
		}

	}

});