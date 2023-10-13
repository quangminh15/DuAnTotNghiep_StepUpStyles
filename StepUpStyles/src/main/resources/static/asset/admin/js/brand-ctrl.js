app.controller("brand-ctrl", function($scope, $http) {
	$scope.branditems = [];
	$scope.branditemss = [];
	$scope.branditemsLoadAll = [];
	$scope.form = {};
	$scope.selectedActivity = "all";

	$scope.sortableColumns = [
		{ name: 'brandID', label: 'Mã thương hiệu' },
		{ name: 'brandName', label: 'Tên thương hiệu' },
		{ name: 'brandImage', label: 'Hình ảnh' },
		{ name: 'modifyDate', label: 'Ngày điều chỉnh' },
		{ name: 'activities', label: 'Trạng thái' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.branditems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
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
		get branditems() {
			var start = this.page * this.size;
			return $scope.branditems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.branditems.length / this.size);
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
		get branditemss() {
			var start = this.page * this.size;
			return $scope.branditemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.branditemss.length / this.size);
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

	// Tải ảnh lên Firebase	bắt đầu
	$scope.createImages = async function() {
		try {
			// Lấy tệp ảnh đã chọn từ trường input với id là "photo"
			const imageFile = document.querySelector('#photo').files[0];

			if (!imageFile) {
				throw new Error("Chưa chọn ảnh để tải lên Firebase.");
			}

			// Tạo một thư mục trên Firebase Storage để lưu trữ ảnh
			const storageRef = firebase.storage().ref();
			const imageRef = storageRef.child('brands/' + imageFile.name);

			// Tải tệp ảnh lên Firebase Storage
			const snapshot = await imageRef.put(imageFile);

			// Lấy URL của ảnh sau khi tải lên Firebase
			const downloadURL = await snapshot.ref.getDownloadURL();

			// Lưu URL vào biến $scope.form.brandImage hoặc nơi bạn muốn lưu
			$scope.form.brandImage = downloadURL;
		} catch (error) {
			// Xử lý lỗi khi tải ảnh lên Firebase
			throw error;
		}
	};
	// Tải ảnh lên Firebase	Kết thúc

	//Cập nhật ảnh lên Firebase	bắt đầu
	$scope.updateImages = async function() {
		try {
			const imageFile = document.querySelector('#photo').files[0];

			if (!imageFile) {
				throw new Error("Chưa chọn ảnh để tải lên Firebase.");
			}

			// Tạo một thư mục trên Firebase Storage để lưu trữ ảnh (ví dụ: theo tên brand)
			const brandID = $scope.form.brandID; // Lấy tên brand (sử dụng tên brand hoặc một giá trị duy nhất khác)
			const storageRef = firebase.storage().ref();

			// Lấy định dạng của tệp ảnh được tải lên
			const fileExtension = imageFile.name.split('.').pop();

			// Đặt tên ảnh theo tên brand và định dạng của tệp
			const imageRef = storageRef.child('brands/' + brandID + '.' + fileExtension);

			// Tải tệp ảnh lên Firebase Storage, và sử dụng 'put' để thay thế ảnh cũ nếu đã tồn tại
			const snapshot = await imageRef.put(imageFile);

			// Lấy URL của ảnh sau khi tải lên Firebase
			const downloadURL = await snapshot.ref.getDownloadURL();

			// Lưu URL vào biến $scope.form.brandImage hoặc nơi bạn muốn lưu
			$scope.form.brandImage = downloadURL;
		} catch (error) {
			throw error;
		}
	}



	//Cập nhật ảnh lên Firebase	Kết thúc

	$scope.filterByActivities = function() {
		if ($scope.selectedActivity === "all") {
			$http.get("/rest/brands/loadallNoDeleted").then(resp => {
				$scope.branditems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách thương hiệu!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/brands/loadallNoDeleted").then(resp => {
				const selectedStatus = $scope.selectedActivity === "true";
				const filteredBrands = resp.data.filter(brand => brand.activities === selectedStatus);
				$scope.branditems = filteredBrands;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách thương hiệu theo trạng thái!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};

	$scope.initialize = function() {
		//load branditems hết luôn
		$http.get("/rest/brands/loadall").then(resp => {
			$scope.branditemsLoadAll = resp.data;
			$scope.branditemsLoadAll.forEach(branditem => {
				branditem.modifyDate = new Date(branditem.modifyDate)
			})
			$scope.branditemsLoadAll.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load branditems 
		$http.get("/rest/brands/loadallNoDeleted").then(resp => {
			$scope.branditems = resp.data;
			$scope.branditems.forEach(branditem => {
				branditem.modifyDate = new Date(branditem.modifyDate)
			})
			$scope.branditems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load branditems đã xóa
		$http.get("/rest/brands/loadallDeleted").then(resp => {
			$scope.branditemss = resp.data;
			$scope.branditemss.forEach(branditem => {
				branditem.modifyDate = new Date(branditem.modifyDate)
			})
			$scope.branditemss.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			activities: false,
			deleted: false,
		};
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(branditem) {
		$scope.form = angular.copy(branditem);
	}

	// Tìm kiếm  
	$scope.searchProductGroupByName = async function() {
		const { value: searchKeyword } = await Swal.fire({
			title: 'Tìm kiếm thương hiệu',
			input: 'text',
			inputLabel: 'Nhập tên thương hiệu',
			inputPlaceholder: 'Nhập tên thương hiệu cần tìm kiếm'
		});

		if (searchKeyword && searchKeyword.trim() !== "") {
			$http.get("/rest/brands/search", {
				params: { keyword: searchKeyword }
			}).then(resp => {
				$scope.branditems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy thương hiệu có tên ' + searchKeyword,
					});
				}
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tìm kiếm thương hiệu!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không tìm thấy tên thương hiệu mà bạn mong muốn!',
			});
		}
	};



	//	Thêm mới 
	$scope.create = async function() {
		//Lỗi trùng tên nhóm sản phẩm
		let existingBrandName = $scope.branditems.find(branditem => branditem.brandName === $scope.form.brandName);
		if (existingBrandName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tên thương hiệu đã tồn tại!',
			});
			return;
		}

		//Lỗi bỏ trống 
		if (!$scope.form.brandName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên thương hiệu!',
			});
			return;
		}

		//Lỗi không chọn ảnh
		if (!document.querySelector('#photo').files[0]) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Bạn chưa chọn ảnh',
			});
			return; // Dừng tiến trình nếu không chọn ảnh
		};

		try {
			await $scope.createImages(); // cập nhật ảnh của Firebase

			// Thực hiện việc lưu vào db
			var branditem = angular.copy($scope.form);
			branditem.brandImage = $scope.form.brandImage;
			branditem.deleted = false;
			branditem.modifyDate = new Date();
			$http.post('/rest/brands/create', branditem).then(resp => {
				resp.data.modifyDate = new Date(resp.data.modifyDate);
				$scope.branditems.push(resp.data);
				$scope.reset();
				Swal.fire({
					icon: 'success',
					title: 'Thành công',
					text: 'Thêm mới thành công!',
				});
				$scope.initialize();
				console.log(resp)
			}).catch(error => {
				if (error.status === 400) {
					$scope.errorMessage = error.data;
					$scope.initialize();
				} else {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Thêm mới thất bại!',
					});
					$scope.initialize();
					console.log("Error", error);
				}
			});
		} catch (error) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tải ảnh lên firebase thất bại',
			});
			$scope.initialize();
		}
	}

	//	Cập nhật  
	$scope.update = async function() {
		// Lỗi bỏ trống
		if (!$scope.form.brandName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên thương hiệu!',
			});
			return;
		}

		try {
			var newImageFile = document.querySelector('#photo').files[0];
			if (newImageFile) {
				// Tải ảnh lên Firebase nếu có ảnh mới
				await $scope.updateImages();
				// Sau khi tải lên Firebase, bạn có thể cập nhật thông tin thương hiệu ở đây
			}

			var branditem = angular.copy($scope.form);
			branditem.modifyDate = new Date();
			$http.put('/rest/brands/update/' + branditem.brandID, branditem).then(resp => {
				var index = $scope.branditems.findIndex(p => p.brandID == branditem.brandID);
				resp.data.modifyDate = new Date(resp.data.modifyDate);
				$scope.branditems[index] = branditem;
				Swal.fire({
					icon: 'success',
					title: 'Thành công',
					text: 'Cập nhật thành công',
				});
				$scope.initialize();
				$scope.reset();
				console.log("branditem", branditem);
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Cập nhật thất bại!',
				});
				$scope.initialize();
				console.log("Error", error);
			});
		} catch (error) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tải ảnh lên Firebase thất bại!' + error,
			});
			$scope.initialize();
		}
	}



	//Mở modal thùng rác
	$scope.openRecycleBinForm = function() {
		// Reset searchKeyword
		searchValue = '';
		$('#recycleBinModal').modal('show');
	};

	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở FORM) bắt đầu
	$scope.confirmHide = function() {
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa thương hiệu này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				var branditem = angular.copy($scope.form);
				branditem.deleted = true;
				branditem.modifyDate = new Date();
				$http.put('/rest/brands/update/' + branditem.brandID, branditem).then(resp => {
					var index = $scope.branditems.findIndex(p => p.brandID == branditem.brandID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.branditems[index] = branditem;
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
	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở FORM) Kết thúc

	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở TABLE) bắt đầu
	$scope.confirmHideTable = function(branditem) {
		$scope.form = angular.copy(branditem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa thương hiệu này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				branditem.deleted = true;
				branditem.modifyDate = new Date();
				$http.put('/rest/brands/update/' + branditem.brandID, branditem).then(resp => {
					var index = $scope.branditems.findIndex(p => p.brandID == branditem.brandID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.branditems[index] = branditem;
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
	//sau khi xác nhận thành công thì xóa vào thùng rác (Nút xóa ở TABLE) kết thúc	

	//sau khi xác nhận thành công thì khôi phục từ thùng rác (Nút khôi phục ở TABLE) bắt đầu
	$scope.restore = function(branditem) {
		console.log(branditem)
		$scope.form = angular.copy(branditem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn khôi phục thương hiệu này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			console.log(result)
			if (result.isConfirmed) {

				branditem.deleted = false;
				branditem.modifyDate = new Date();
				$http.put('/rest/brands/update/' + branditem.brandID, branditem).then(resp => {
					var index = $scope.branditemsLoadAll.findIndex(p => p.brandID == branditem.brandID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.branditemsLoadAll[index] = branditem;

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
	//sau khi xác nhận thành công thì khôi phục item từ thùng rác (Nút khôi phục ở TABLE) Kết thúc

	//sau khi xác nhận thành công thì xóa luôn (Nút xóa ở TABLE) bắt đầu
	$scope.confirmDelete = function(branditem) {
		console.log(branditem)
		$scope.form = angular.copy(branditem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn khôi phục thương hiệu này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				$http.delete('/rest/brands/delete/' + $scope.form.brandID).then(resp => {
					var index = $scope.branditems.findIndex(p => p.brandID == $scope.form.brandID);
					$scope.branditems.splice(index, 1);
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

				//code xuất file
				var table2excel = new Table2Excel();
				table2excel.export(document.querySelectorAll("table.table"));
			}

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
			}
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