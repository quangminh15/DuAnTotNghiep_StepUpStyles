app.controller("review-ctrl", function ($scope, $http) {
	$scope.reviewitems = [];
	$scope.prods = [];
	$scope.users = [];
	$scope.form = {};
	$scope.reviewdetails = {}
	$scope.showSelectBoxEmptyWarning = false;
	$scope.reviewitemSearchs = []
	$scope.initialize = function () {
		//load review
		$http.get("/rest/reviews/loadall").then(resp => {
			$scope.reviewitems = resp.data;
			$scope.reviewAll = $scope.reviewitems.length;
			$scope.reviewitems.forEach(reviewitem => {
				reviewitem.reviewDate = new Date(reviewitem.reviewDate)
			})
			$scope.reviewitems.sort((a, b) => b.reviewDate - a.reviewDate);
			$scope.pager.first();
		});

		//load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
		});

		//load User
		$http.get("/rest/userbyroleUser").then(resp => {
			$scope.users = resp.data;
		});
	}
	//	Khởi đầu
	$scope.initialize();

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 8,
		length : 0,
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
			return visiblePages;
		},
		get reviewitems() {
			var start = this.page * this.size;
			return $scope.reviewitems.slice(start, start + this.size);
		},
		get count() {
			// if ($scope.filteredReviews) {
			// 	length = $scope.filteredReviews.length;
			// } else {
				length = $scope.reviewitems.length
			// }
			return Math.ceil(1.0 * length / this.size);
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

	$scope.showReview = function (reviewId) {
		$http.get("/rest/reviews/" + reviewId).then(resp => {
			$scope.reviewdetails = resp.data;
			$('#reviewModal').modal('show');
			console.log("Success", resp);
		}).catch(error => {
			console.log("ẻroorrr", error);
		});
	}

	$scope.hideReview = function (reviewId) {
		$http.put('/rest/reviews/' + reviewId + '/hide')
			.then(function (response) {
				if (response.status === 200) {
				}
				$scope.initialize();
			})
			.catch(function (error) {
				console.log('Error hiding review:', error);
			});
	};

	$scope.filterByProduct = function () {
		if ($scope.productId) {
			$scope.usersId = ""
			$scope.rating = ""
			$scope.dateFilter = ""
			$http.get("/rest/reviews/loadbyproducts/" + $scope.productId).then(resp => {
				$scope.reviewitems = resp.data;
				$scope.demSP = $scope.reviewitems.length
				if($scope.reviewitems.length == 0){
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy sản phẩm phù hợp. Vui lòng chọn lại!',
					});
					$scope.initialize();
					$scope.productId = ""
				}else{
					$scope.pager.first();
				}
			}).catch(error => {
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};

	$scope.filterByUser = function () {
		if ($scope.usersId) {
			$scope.productId = ""
			$scope.rating = ""
			$scope.dateFilter = ""
			$http.get("/rest/reviews/loadbyusers/" + $scope.usersId).then(resp => {
				$scope.reviewitems = resp.data;
				$scope.demND = $scope.reviewitems.length
				if($scope.reviewitems.length == 0){
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy khách hàng phù hợp. Vui lòng chọn lại!',
					});
					$scope.initialize();
					$scope.usersId = ""
				}else{
					$scope.pager.first();
				}
			}).catch(error => {
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};

	$scope.filterByStar = function () {
		if ($scope.rating) {
			$scope.productId = ""
			$scope.usersId = ""
			$scope.dateFilter = ""
			$http.get("/rest/reviews/loadbystar/" + $scope.rating).then(resp => {
				$scope.reviewitems = resp.data;
				$scope.demStar = $scope.reviewitems.length
				if($scope.reviewitems.length == 0){
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy sao đánh giá phù hợp. Vui lòng chọn lại!',
					});
					$scope.initialize();
					$scope.rating = ""
				}else{
				$scope.pager.first();
			}
			}).catch(error => {
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};

	// $scope.searchReviews = function () {
	// 	// if (!$scope.productId || !$scope.usersId || !$scope.rating) {
	// 	// 	Swal.fire({
	// 	// 		icon: 'error',
	// 	// 		title: 'Thất bại',
	// 	// 		text: 'Vui lòng chọn đầy đủ các trường để thực hiện chức năng tìm kiếm!'
	// 	// 	})
	// 	// } else {
	// 		$http.get("/rest/reviews/search",
	// 			{
	// 				params: {
	// 					productId: $scope.productId ? parseInt($scope.productId) : undefined,
	// 					usersId: $scope.usersId ? parseInt($scope.usersId) : undefined,
	// 					rating: $scope.rating ? parseInt($scope.rating) : undefined
	// 				}
	// 			}
	// 		)
	// 			.then(function (response) {
	// 				$scope.reviewitems = response.data;
	// 				console.log("rev",$scope.reviewitems);
	// 				// if ($scope.reviewitems.length == 0) {
	// 				// 	Swal.fire({
	// 				// 		icon: 'error',
	// 				// 		title: 'Thất bại',
	// 				// 		text: 'Không tìm thấy kết quả phù hợp!'
	// 				// 	})
	// 				// 	$scope.initialize();
	// 				// }
	// 				$scope.pager.first();
	// 			})
	// 	// }
	// }

	$scope.searchReviews = function () {
			$http.get("/rest/reviews/search", {
				params: {
					productId: $scope.productId,
					usersId: $scope.usersId,
					rating: $scope.rating
				}
			}).then(function (response) {
				$scope.reviewitems = response.data;
				$scope.pager.first();
			}).catch(function (error) {
				// Xử lý lỗi
			});
	}
	

	$scope.reset = function () {
		$scope.initialize();
		$scope.productId = "";
		$scope.usersId = "";
		$scope.rating = "";
	}

	$scope.sortableColumns = [
		{ name: 'orderDetail.orderDetailId', label: 'Mã đơn hàng' },
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		{ name: 'user.fullName', label: 'Tên khách hàng' },
		{ name: 'title', label: 'Nội dung' },
		{ name: 'rating', label: 'Sao đánh giá' },
		{ name: 'reviewDate', label: 'Ngày đánh giá' },
		{ name: 'image1', label: 'Ảnh 1' },
		{ name: 'image2', label: 'Ảnh 2' },
		{ name: 'image3', label: 'Ảnh 3' },
	];


	$scope.sortByColumn = function (columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.reviewitems.sort(function (a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'product.productName') {
				aValue = a.product.productName;
				bValue = b.product.productName;
			}
			if (columnName === 'orderDetail.orderDetailId') {
				aValue = a.orderDetail.orderDetailId;
				bValue = b.orderDetail.orderDetailId;
			}
			if (columnName === 'user.fullName') {
				aValue = a.user.fullName;
				bValue = b.user.fullName;
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

	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	})

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

	$scope.exportPdf = function () {
		$http({
		  method: "POST",
		  url: "/review-pdf",
		  data: $scope.reviewitems,
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
			a.download = "Review.pdf";
			document.body.appendChild(a);
			a.click();
			URL.revokeObjectURL(url);
		  })
		  .catch(function (error) {
			console.error("Xuất PDF thất bại:", error);
		});
	};

	var myApp1 = new function () {
		this.printTable = function () {
			var tab = document.getElementById('sampleTable');
			var win = window.open('', '', 'height=700,width=1200');
			win.document.write(tab.outerHTML);
			win.document.close();
			win.print();
		}

	}

	$scope.exportExcel = function () {
		$http({
		  method: "POST",
		  url: "/export-excelReview", // Thay thế với URL phía máy chủ đúng
		  data: $scope.reviewitems,
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
			a.download = "ReviewStepUpStyle.xlsx"; // Đặt tên tệp Excel mong muốn
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

	$scope.applyDateFilter = function() {
		$scope.productId = ""
		$scope.usersId = ""
		$scope.rating = ""
		var today = new Date();
		var filter = $scope.dateFilter;
	
		if (filter === 'today') {
			// Lọc theo hôm nay
			$scope.filteredReviews = $scope.reviewitems.filter(function(review) {
				var reviewDate = new Date(review.reviewDate);
				return reviewDate.toDateString() === today.toDateString();
			});
		} else if (filter === 'thisWeek') {
			// Lọc theo tuần này
			var startOfWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay());
			var endOfWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay() + 6);
	
			$scope.filteredReviews = $scope.reviewitems.filter(function(review) {
				var reviewDate = new Date(review.reviewDate);
				return reviewDate >= startOfWeek && reviewDate <= endOfWeek;
			});
		} else if (filter === 'thisMonth') {
			// Lọc theo tháng này
			var startOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);
			var endOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0);
	
			$scope.filteredReviews = $scope.reviewitems.filter(function(review) {
				var reviewDate = new Date(review.reviewDate);
				return reviewDate >= startOfMonth && reviewDate <= endOfMonth;
			});
		} else if (filter === 'thisYear') {
			// Lọc theo năm nay
			var startOfYear = new Date(today.getFullYear(), 0, 1);
			var endOfYear = new Date(today.getFullYear(), 11, 31);
	
			$scope.filteredReviews = $scope.reviewitems.filter(function(review) {
				var reviewDate = new Date(review.reviewDate);
				return reviewDate >= startOfYear && reviewDate <= endOfYear;
			});
		} else {
			// Hiển thị tất cả đánh giá nếu không có bộ lọc được chọn
			$scope.filteredReviews = $scope.reviewitems;
		}
		$scope.pager.first();
	};	

	$scope.applyDateFilter()

	$scope.searchProductName = function(){
		if ($scope.keySearch && $scope.keySearch.trim() !== "") {
			$http.get("/rest/reviews/searchProductName", {
				params: { keyword: $scope.keySearch }
			}).then(resp => {
				$scope.reviewitems = resp.data;
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
	
})