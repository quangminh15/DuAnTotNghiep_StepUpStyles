app.controller("favorite-ctrl", function($scope, $http){
	$scope.favoriteitems = [];
	$scope.prods = [];
	$scope.users = [];
	$scope.form = {};
	$scope.initialize = function() {
		//load 
		$http.get("/rest/favorites/loadall").then(resp => {
			$scope.favoriteitems = resp.data;
			$scope.countF = $scope.favoriteitems.length;
			$scope.favoriteitems.forEach(favoriteitem => {
				favoriteitem.dateLike = new Date(favoriteitem.dateLike)
			})
			$scope.favoriteitems.sort((a, b) => b.dateLike - a.dateLike);
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

	$scope.filterByProduct = function() {
		if ($scope.selectedProduct) {
			$scope.selectedUser = ""
			$http.get("/rest/favorites/loadbyproducts/" + $scope.selectedProduct).then(resp => {
				$scope.favoriteitems = resp.data;
				if($scope.favoriteitems.length == 0){
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy sản phẩm phù hợp. Vui lòng chọn lại!',
					});
					$scope.initialize();
					$scope.selectedProduct = ""
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

	$scope.filterByUser = function() {
		if ($scope.selectedUser) {
			$scope.selectedProduct = ""
			$http.get("/rest/favorites/loadbyusers/" + $scope.selectedUser).then(resp => {
				$scope.favoriteitems = resp.data;
				if($scope.favoriteitems.length == 0){
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy người dùng phù hợp. Vui lòng chọn lại!',
					});
					$scope.initialize();
					$scope.selectedUser = ""
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
		get favoriteitems() {
			var start = this.page * this.size;
			return $scope.favoriteitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.favoriteitems.length / this.size);
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

	$scope.sortableColumns = [
		{ name: 'favoriteId', label: 'Mã yêu thích' },
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		{ name: 'user.fullName', label: 'Tên người dùng' },
		{ name: 'dateLike', label: 'Ngày thích sản phẩm' },
	];


	$scope.sortByColumn = function(columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.favoriteitems.sort(function(a, b) {
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

	$scope.productTop = [];

$scope.getProductTop = function(){
    $http.get("/rest/favorites/top1").then(resp => {
        $scope.productTop = resp.data;
        console.log("Danh sách sản phẩm theo thứ tự giảm dần lượt thích:", resp.data);

        // Sắp xếp danh sách theo lượt thích giảm dần
        $scope.productTop.sort((a, b) => {
            return b.numberOfLikes - a.numberOfLikes;
        });

        // Lấy sản phẩm có nhiều lượt thích nhất
        if ($scope.productTop.length > 0) {
            var mostLikedProduct = $scope.productTop[0];
            console.log("Sản phẩm có nhiều lượt thích nhất:", mostLikedProduct);
        } else {
            console.log("Không có sản phẩm nào được yêu thích.");
        }
    }).catch(error => {
        console.error("Lỗi khi lấy danh sách sản phẩm yêu thích:", error);
    });
}

$scope.getProductTop();

})