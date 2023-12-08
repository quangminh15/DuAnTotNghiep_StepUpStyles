app.controller("color-ctrl", function($scope, $http) {
	$scope.coloritems = [];
	$scope.coloritemss = [];
	$scope.coloritemsLoadAll = [];
	$scope.prods = [];
	$scope.productNames = [];
	$scope.form = {};
	$scope.form.product = {};
	$scope.selectedActivity = "all";
	$scope.disableCreateButton = false; 

	$scope.sortableColumns = [
		{ name: 'colorID', label: 'Mã màu' },
		{ name: 'colorName', label: 'Tên màu' },
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

		$scope.coloritems.sort(function(a, b) {
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
		get coloritems() {
			var start = this.page * this.size;
			return $scope.coloritems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.coloritems.length / this.size);
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
		get coloritemss() {
			var start = this.page * this.size;
			return $scope.coloritemss.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.coloritemss.length / this.size);
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

	$scope.initialize = function() {
		//load coloritems hết luôn
		$http.get("/rest/colors/loadall").then(resp => {
			$scope.coloritemsLoadAll = resp.data;
			$scope.coloritemsLoadAll.forEach(coloritem => {
				coloritem.modifyDate = new Date(coloritem.modifyDate)
			})
			$scope.coloritemsLoadAll.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load coloritems 
		$http.get("/rest/colors/loadallNoDeleted").then(resp => {
			$scope.coloritems = resp.data;
			$scope.coloritems.forEach(coloritem => {
				coloritem.modifyDate = new Date(coloritem.modifyDate)
			})
			$scope.coloritems.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});

		//load coloritems đã xóa
		$http.get("/rest/colors/loadallDeleted").then(resp => {
			$scope.coloritemss = resp.data;
			$scope.coloritemss.forEach(coloritem => {
				coloritem.modifyDate = new Date(coloritem.modifyDate)
			})
			$scope.coloritemss.sort((a, b) => b.modifyDate - a.modifyDate);
			$scope.pager.first();
			$scope.RestorePager.first();
		});
	}

	// Tìm kiếm  
	$scope.searchColorByName = async function() {
		const { value: searchKeyword } = await Swal.fire({
			title: 'Tìm kiếm màu sắc',
			input: 'text',
			inputLabel: 'Nhập tên màu sắc',
			inputPlaceholder: 'Nhập tên màu sắc cần tìm kiếm'
		});

		if (searchKeyword && searchKeyword.trim() !== "") {
			$http.get("/rest/colors/search", {
				params: { keyword: searchKeyword }
			}).then(resp => {
				$scope.coloritems = resp.data;
				$scope.pager.first();

				if (resp.data.length === 0) {
					$scope.initialize();
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy màu sắc có tên ' + searchKeyword,
					});
				}
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tìm kiếm màu sắc!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không tìm thấy tên màu sắc mà bạn mong muốn!',
			});
		}
	};

	$scope.filterByActivities = function() {
		if ($scope.selectedActivity === "all") {
			$http.get("/rest/colors/loadallNoDeleted").then(resp => {
				$scope.coloritems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách màu sắc!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			$http.get("/rest/colors/loadallNoDeleted").then(resp => {
				const selectedStatus = $scope.selectedActivity === "true";
				const filteredColors = resp.data.filter(color => color.activities === selectedStatus);
				$scope.coloritems = filteredColors;
				$scope.pager.first();
			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tải danh sách màu sắc theo trạng thái!',
				});
				console.log("Error", error);
				$scope.pager.first();
			});
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

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			activities: false,
			deleted: false,
		};
		$scope.disableCreateButton = false;
	}
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(coloritem) {
		$scope.form = angular.copy(coloritem);
		$scope.disableCreateButton = true;
	}

	//	Thêm mới 
	$scope.create = function() {

		//Lỗi bỏ trống tên màu
		if (!$scope.form.colorName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên màu!!',
			});
			return;
		}
		
		//Lỗi trùng tên màu sản phẩm
		let existingColorName = $scope.coloritems.find(coloritem => coloritem.colorName === $scope.form.colorName);
		if (existingColorName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Tên màu đã tồn tại!',
			});
			return;
		}

		// Thực hiện việc lưu vào db
		var coloritem = angular.copy($scope.form);
		coloritem.deleted = false;
		coloritem.modifyDate = new Date();
		$http.post('/rest/colors/create', coloritem).then(resp => {
			resp.data.modifyDate = new Date(resp.data.modifyDate);
			$scope.coloritems.push(resp.data);
			$scope.reset();
			Swal.fire({
				icon: 'success',
				title: 'Thành công',
				text: 'Thêm mới thành công',
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
	}

	//Cập nhật
	$scope.update = function() {

		//Lỗi bỏ trống tên màu
		if (!$scope.form.colorName) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng nhập tên màu!!',
			});
			return;
		}

		var coloritem = angular.copy($scope.form);
		coloritem.modifyDate = new Date();
		$http.put('/rest/colors/update/' + coloritem.colorID, coloritem).then(resp => {
			var index = $scope.coloritems.findIndex(p => p.colorID == coloritem.colorID);
			resp.data.modifyDate = new Date(resp.data.modifyDate); $scope.coloritems[index] = coloritem;
			Swal.fire({
				icon: 'success',
				title: 'Thành công',
				text: 'Cập nhật thành công',
			});
			$scope.initialize();
			$scope.reset();
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
			text: "Bạn có chắc chắn muốn xóa màu sắc này không này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				var coloritem = angular.copy($scope.form);
				coloritem.deleted = true;
				coloritem.modifyDate = new Date();
				$http.put('/rest/colors/update/' + coloritem.colorID, coloritem).then(resp => {
					var index = $scope.coloritems.findIndex(p => p.colorID == coloritem.colorID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.coloritems[index] = coloritem;
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
	$scope.confirmHideTable = function(coloritem) {
		$scope.form = angular.copy(coloritem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa màu sắc này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				coloritem.deleted = true;
				coloritem.modifyDate = new Date();
				$http.put('/rest/colors/update/' + coloritem.colorID, coloritem).then(resp => {
					var index = $scope.coloritems.findIndex(p => p.colorID == coloritem.colorID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.coloritems[index] = coloritem;
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
	$scope.restore = function(coloritem) {
		console.log(coloritem)
		$scope.form = angular.copy(coloritem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn khôi phục mùa sắc này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			console.log(result)
			if (result.isConfirmed) {

				coloritem.deleted = false;
				coloritem.modifyDate = new Date();
				$http.put('/rest/colors/update/' + coloritem.colorID, coloritem).then(resp => {
					var index = $scope.coloritemsLoadAll.findIndex(p => p.colorID == coloritem.colorID);
					resp.data.modifyDate = new Date(resp.data.modifyDate);
					$scope.coloritemsLoadAll[index] = coloritem;

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
	$scope.confirmDelete = function(coloritem) {
		console.log(coloritem)
		$scope.form = angular.copy(coloritem);
		Swal.fire({
			title: 'Thông báo',
			text: "Bạn có chắc chắn muốn xóa màu sắc này không?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			cancelButtonText: 'Không',
			confirmButtonText: 'Đồng ý'
		}).then((result) => {
			if (result.isConfirmed) {
				$http.delete('/rest/colors/delete/' + $scope.form.colorID).then(resp => {
					var index = $scope.coloritems.findIndex(p => p.colorID == $scope.form.colorID);
					$scope.coloritems.splice(index, 1);
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

	$scope.exportPdf = function () {
		$http({
		  method: "POST",
		  url: "/color-pdf",
		  data: $scope.sizeitems,
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
			a.download = "DSColor.pdf";
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
		  url: "/export-excelColor", // Thay thế với URL phía máy chủ đúng
		  data: $scope.coloritems,
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
			a.download = "ColorStepUpStyle.xlsx"; // Đặt tên tệp Excel mong muốn
			document.body.appendChild(a);
			a.click();
			URL.revokeObjectURL(url);
		  })
		  .catch(function (error) {
			console.error("Xuất ra Excel thất bại:", error);
		  });
	  };

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