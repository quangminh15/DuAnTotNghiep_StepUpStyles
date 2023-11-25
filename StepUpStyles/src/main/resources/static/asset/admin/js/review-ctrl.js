app.controller("review-ctrl", function($scope, $http){
	$scope.reviewitems = [];
	$scope.prods = [];
	$scope.users = [];
	$scope.form = {};
	$scope.reviewdetails = {}
	$scope.showSelectBoxEmptyWarning = false;
	$scope.initialize = function() {
		//load review
		$http.get("/rest/reviews/loadall").then(resp => {
			$scope.reviewitems = resp.data;
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
		$http.get("/user/loadall").then(resp => {
			$scope.users = resp.data;
		});
	}
	//	Khởi đầu
	$scope.initialize();

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 8,
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
		get reviewitems() {
			var start = this.page * this.size;
			return $scope.reviewitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.reviewitems.length / this.size);
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

	$scope.showReview = function(reviewId){
		$http.get("/rest/reviews/" + reviewId).then(resp => {
			$scope.reviewdetails =  resp.data;
			$('#orderModal').modal('show');
			console.log($scope.reviewdetails);
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

	$scope.filterByProduct = function() {
		if ($scope.selectedProduct) {
			$http.get("/rest/reviews/loadbyproducts/" + $scope.selectedProduct).then(resp => {
				$scope.reviewitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};

	$scope.filterByUser = function() {
		if ($scope.selectedUser) {
			$http.get("/rest/reviews/loadbyusers/" + $scope.selectedUser).then(resp => {
				$scope.reviewitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};

	$scope.searchReviews = function() {
		if(!$scope.productId || !$scope.usersId || !$scope.rating){
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Vui lòng chọn đầy đủ các trường để thực hiện chức năng tìm kiếm!'
			})
		}else{
			$http.get(`/rest/reviews/search?productId=${$scope.productId}&usersId=${$scope.usersId}&rating=${$scope.rating}`)
            .then(function(response) {
                $scope.reviewitems = response.data;
				if($scope.reviewitems.length == 0){
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy kết quả phù hợp!'
					})
				}
				$scope.pager.first();
			})
		}
	}

	$scope.reset = function(){
		$scope.initialize();
		$scope.productId = "";
        $scope.usersId = "";
  		$scope.rating = "";
	}

	$scope.sortableColumns = [
		{ name: 'reviewId', label: 'Mã đánh giá' },
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		{ name: 'user.fullName', label: 'Tên người dùng' },
		{ name: 'title', label: 'Nội dung' },
		{ name: 'rating', label: 'Sao đánh giá' },
		{ name: 'reviewDate', label: 'Ngày đánh giá' },
		{ name: 'image1', label: 'Ảnh 1' },
		{ name: 'image2', label: 'Ảnh 2' },
		{ name: 'image3', label: 'Ảnh 3' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.reviewitems.sort(function(a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'product.productName') {
				aValue = a.product.productName;
				bValue = b.product.productName;
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
	
})