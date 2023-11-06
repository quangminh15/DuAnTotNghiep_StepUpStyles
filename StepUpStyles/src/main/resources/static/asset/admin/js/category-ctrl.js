app.controller("category-ctrl", function($scope, $http) {
	$scope.categoryitems = [];
	$scope.categoryitemss = [];
	$scope.categoryitemsLoadAll = [];
	$scope.prodgroups = [];
	$scope.form = {};
	$scope.form.productGroup = {};
	$scope.selectedActivity = "all";

	$scope.sortableColumns = [
		{ name: 'categoryID', label: 'Mã danh mục' },
		{ name: 'categoryName', label: 'Tên danh mục' },
		{ name: 'categoryImage', label: 'Hình ảnh' },
		{ name: 'modifyDate', label: 'Ngày điều chỉnh' },
		{ name: 'activities', label: 'Trang thái' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.categoryitems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'productGroup.productGroupName') {
				aValue = a.productGroup.productGroupName;
				bValue = b.productGroup.productGroupName;
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
		get categoryitems() {
			var start = this.page * this.size;
			return $scope.categoryitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.categoryitems.length / this.size);
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
		get categoryitemss() {
			var start = this.page * this.size;
			return $scope.categoryitemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.categoryitemss.length / this.size);
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

	// Tải ảnh lên Firebase	
	$scope.uploadImages = function() {
		var ref = firebase.storage().ref();
		var folder = 'Brand';
		var file = document.querySelector('#photo').files[0];
		var metadata = {
			contentType: file.type
		};
		var name = folder + '/' + file.name; // Tạo tên file với thư mục

		var uploadIMG = ref.child(name).put(file, metadata);

		return uploadIMG.then(snapshot => snapshot.ref.getDownloadURL())
			.then(url => {
				$scope.form.categoryImage = url;
				console.log($scope.form.categoryImage)
			});
	};

	$scope.initialize = function() {
		//load categoryitems hết luôn
		$http.get("/rest/categories/loadall").then(resp => {
			$scope.categoryitemsLoadAll = resp.data;
			$scope.categoryitemsLoadAll.forEach(categoryitem => {
				categoryitem.modifyDate = new Date(categoryitem.modifyDate)
			})
			$scope.categoryitemsLoadAll.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load categoryitems chưa xóa 
		$http.get("/rest/categories/loadallNoDeleted").then(resp => {
			$scope.categoryitems = resp.data;
			$scope.categoryitems.forEach(categoryitem => {
				categoryitem.modifyDate = new Date(categoryitem.modifyDate)
			})
			$scope.categoryitems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load categoryitems đã xóa
		$http.get("/rest/categories/loadallDeleted").then(resp => {
			$scope.categoryitemss = resp.data;
			$scope.categoryitemss.forEach(categoryitem => {
				categoryitem.modifyDate = new Date(categoryitem.modifyDate)
			})
			$scope.categoryitemss.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

	$scope.filterByActivities = function() {
		if ($scope.selectedActivity === "all") {
			$http.get("/rest/categories/loadallNoDeleted").then(resp => {
				$scope.categoryitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách danh mục sản phẩm màu sắc!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/categories/loadallNoDeleted").then(resp => {
				const selectedStatus = $scope.selectedActivity === "true";
				const filteredCategories = resp.data.filter(category => category.activities === selectedStatus);
				$scope.categoryitems = filteredCategories;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách danh mục sản phẩm theo trạng thái!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		}
	};

	// Tìm kiếm  
	$scope.searchProductCateByName = async function() {
		const { value: searchKeyword } = await Swal.fire({
			title: 'Tìm kiếm danh mục',
			input: 'text',
			inputLabel: 'Nhập tên danh mục',
			inputPlaceholder: 'Nhập tên danh mục cần tìm kiếm'
		});

		if (searchKeyword && searchKeyword.trim() !== "") {
			$http.get("/rest/categories/search", {
				params: { keyword: searchKeyword }
			}).then(resp => {
				$scope.categoryitems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy danh mục có tên ' + searchKeyword,
					});
				}
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tìm kiếm danh mục!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không tìm thấy tên danh mục mà bạn mong muốn!',
			});
		}
	};

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
	$scope.edit = function(categoryitem) {
		$scope.form = angular.copy(categoryitem);
	}


	//	Thêm mới 
	$scope.create = async function() {
		//Lỗi bỏ trống 
		if (!$scope.form.categoryName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên danh mục sản phẩm!!',
			});
			return;
		}
		
		//Lỗi trùng tên danh mục sản phẩm
		let existingCategoryName = $scope.categoryitems.find(categoryitem => categoryitem.categoryName === $scope.form.categoryName);
		if (existingCategoryName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tên danh mục đã tồn tại!',
			});
			return;
		}

		//Lỗi không chọn ảnh
		if (!document.querySelector('#photo').files[0]) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Bạn chưa chọn ảnh!',
			});
			return; // Dừng tiến trình nếu không chọn ảnh
		};

		try {
			await $scope.uploadImages(); // Tải ảnh lên Firebase

			// Thực hiện việc lưu vào db
			var categoryitem = angular.copy($scope.form);
			categoryitem.categoryImage = $scope.form.categoryImage;
			categoryitem.deleted = false;
			categoryitem.modifyDate = new Date();
			$http.post('/rest/categories/create', categoryitem).then(resp => {
				resp.data.modifyDate = new Date(resp.data.modifyDate);
				$scope.categoryitems.push(resp.data);
				Swal.fire({
					icon: 'success',
					title: 'Thành công',
					text: 'Thêm mới thành công!',
				});
				$scope.initialize();
				$scope.reset();
				console.log(resp)
			}).catch(error => {
				if (error.status === 400) {
					$scope.errorMessage = error.data;
					$scope.initialize();
					$scope.reset();
				} else {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Thêm mới thất bại!',
					});
					$scope.initialize();
					$scope.reset();
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
			$scope.reset();
		}
	}

	//	Cập nhật  
	$scope.update = async function() {
		//Lỗi bỏ trống 
		if (!$scope.form.categoryName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên danh mục sản phẩm!!',
			});
			return;
		}

		try {

			var newImageFile = document.querySelector('#photo').files[0];
			if (newImageFile) {
				// Tải ảnh lên Firebase nếu có ảnh mới
				await $scope.uploadImages();
				// Sau khi tải lên Firebase, bạn có thể cập nhật thông tin thương hiệu ở đây
			}

			var categoryitem = angular.copy($scope.form);
			categoryitem.categoryImage = $scope.form.categoryImage;
			categoryitem.modifyDate = new Date();
			$http.put('/rest/categories/update/' + categoryitem.categoryID, categoryitem).then(resp => {
				var index = $scope.categoryitems.findIndex(p => p.categoryID == categoryitem.categoryID);
				resp.data.modifyDate = new Date(resp.data.modifyDate);
				$scope.categoryitems[index] = categoryitem;
				$scope.messageSuccess = "Cập nhật thành công";
				Swal.fire({
					icon: 'success',
					title: 'Thành công',
					text: 'Cập nhật thành công!!',
				});
				$scope.initialize();
				$scope.reset();
				console.log("categoryitem", categoryitem);
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
			text: "Bạn có chắc chắn muốn xóa sản phẩm này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				var categoryitem = angular.copy($scope.form);
				categoryitem.deleted = true;
				categoryitem.modifyDate = new Date();
				$http.put('/rest/categories/update/' + categoryitem.categoryID, categoryitem).then(resp => {
					var index = $scope.categoryitems.findIndex(p => p.categoryID == categoryitem.categoryID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.categoryitems[index] = categoryitem;
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
	$scope.confirmHideTable = function(categoryitem) {
		$scope.form = angular.copy(categoryitem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa danh mục này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				categoryitem.deleted = true;
				categoryitem.modifyDate = new Date();
				$http.put('/rest/categories/update/' + categoryitem.categoryID, categoryitem).then(resp => {
					var index = $scope.categoryitems.findIndex(p => p.categoryID == categoryitem.categoryID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.categoryitems[index] = categoryitem;
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
	$scope.restore = function(categoryitem) {
		$scope.form = angular.copy(categoryitem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn khôi phục danh mục này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			console.log(result)
			if (result.isConfirmed) {

				categoryitem.deleted = false;
				categoryitem.modifyDate = new Date();
				$http.put('/rest/categories/update/' + categoryitem.categoryID, categoryitem).then(resp => {
					var index = $scope.categoryitemsLoadAll.findIndex(p => p.categoryID == categoryitem.categoryID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.categoryitemsLoadAll[index] = categoryitem;

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
	$scope.confirmDelete = function(categoryitem) {
		console.log(categoryitem)
		$scope.form = angular.copy(categoryitem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa danh mục này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				$http.delete('/rest/categories/delete/' + $scope.form.categoryID).then(resp => {
					var index = $scope.categoryitems.findIndex(p => p.categoryID == $scope.form.categoryID);
					$scope.categoryitems.splice(index, 1);
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