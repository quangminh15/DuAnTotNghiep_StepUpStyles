app.controller("indexAdmin-ctrl", function ($scope, $http, $interval) {
	//quangminh bắt đầu 
	$scope.totalQuantity = 0;
	$scope.productdetailitemss = [];
	$scope.outOfStockCount = [];
	$scope.nearlyOutOfStockCount = [];
	$scope.listorder = []
	$scope.filteredOrders = []

	//Tính tổng số lượng sản phẩm sản phẩm
	function SumQuantity(productdetailitems) {
		let total = 0;
		for (let i = 0; i < productdetailitems.length; i++) {
			total += productdetailitems[i].quantity;
		}
		return total;
	}

	// Load danh sách sản phẩm và tính tổng quantity
	$http.get("/rest/productdetails/loadall").then(resp => {
		$scope.productdetailitemss = resp.data;

		// Tính số lượng sản phẩm hết hàng (quantity = 0)
		$scope.outOfStockCount = $scope.productdetailitemss.filter(item => item.quantity === 0).length;

		// Tính số lượng sản phẩm gần hết hàng (quantity nhỏ hơn 10)
		$scope.nearlyOutOfStockCount = $scope.productdetailitemss.filter(item => item.quantity > 0 && item.quantity < 10).length;

		// Tính tổng quantity từ danh sách sản phẩm
		//		$scope.totalQuantity = SumQuantity(resp.data);

		// Tính tổng số lượng sản phẩm
		$scope.totalQuantity = $scope.productdetailitemss.reduce((total, item) => total + item.quantity, 0);

		// Đếm tổng số sản phẩm
		$scope.totalProductCount = $scope.productdetailitemss.length;

		// Đếm tổng số sản phẩm tồn kho
		$scope.TonKho = $scope.totalProductCount - $scope.nearlyOutOfStockCount - $scope.outOfStockCount;
	});

	// Tính số lượng sản phẩm hết hàng (quantity = 0)
	$scope.outOfStockCount = $scope.productdetailitemss.filter(item => item.quantity === 0).length;

	// Tính số lượng sản phẩm gần hết hàng (quantity nhỏ hơn 10)
	$scope.nearlyOutOfStockCount = $scope.productdetailitemss.filter(item => item.quantity > 0 && item.quantity < 10).length;


	//thời gian hiển thị start
	$scope.currentDate = new Date();
	$scope.days = ['Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'];
	$scope.dayOfWeek = $scope.days[$scope.currentDate.getDay()];

	function formatTime(value) {
		return value < 10 ? "0" + value : value;
	}

	function updateTime() {
		$scope.currentDate = new Date();
		$scope.hours = formatTime($scope.currentDate.getHours());
		$scope.minutes = formatTime($scope.currentDate.getMinutes());
		$scope.seconds = formatTime($scope.currentDate.getSeconds());
		$scope.timeString = $scope.hours + ':' + $scope.minutes + ':' + $scope.seconds;
	}

	// Cập nhật thời gian mỗi giây
	$interval(updateTime, 1000);

	//thời gian hiển thị end
	$scope.sortableColumns = [
		{ name: 'productDetailID', label: 'STT' },
		{ name: 'modifyDate', label: 'Ngày điều chỉnh' },
		{ name: 'product.productName', label: 'Tên sản phẩm' },
		{ name: 'color.colorName', label: 'Tên màu' },
		{ name: 'size.sizeNumber', label: 'Size' },
		{ name: 'quantity', label: 'Số lượng' },
	];


	$scope.sortByColumn = function (columnName) {
		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.productdetailitemss.sort(function (a, b) {
			var aValue = a[columnName];
			var bValue = b[columnName];
			if (columnName === 'product.productName') {
				aValue = a.product.productName;
				bValue = b.product.productName;
			}

			if (columnName === 'color.colorName') {
				aValue = a.color.colorName;
				bValue = b.color.colorName;
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
		get productdetailitemss() {
			var filteredProductDetails = $scope.productdetailitemss.filter(productdetailitem => productdetailitem.quantity <= 10);

			var start = this.page * this.size;
			return filteredProductDetails.slice(start, start + this.size);
		},
		get count() {
			var filteredProductDetails = $scope.productdetailitemss.filter(productdetailitem => productdetailitem.quantity <= 10);
			return Math.ceil(1.0 * filteredProductDetails.length / this.size);
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

	$scope.initialize = function () {
		//load productdetailitemss 
		$http.get("/rest/productdetails/loadall").then(resp => {
			$scope.productdetailitemss = resp.data;
			$scope.productdetailitemss = $scope.productdetailitemss.filter(productdetailitem => productdetailitem.quantity <= 10);

			$scope.productdetailitemss.forEach(productdetailitem => {
				productdetailitem.modifyDate = new Date(productdetailitem.modifyDate)
			});

			$scope.productdetailitemss.sort((a, b) => b.modifyDate - a.modifyDate);

			// Cập nhật pager
			$scope.pager.first();
		}).catch(error => {
			console.error("Error loading product details:", error);
		});

		$scope.hasData = function () {
			return $scope.productdetailitemss && $scope.productdetailitemss.length > 0;
		};
	}

	$scope.initialize();

	//quangminh kết thúc

	//Long Hai start
	//Load danh sách đơn hàng
	$http.get(`/rest/order/listOrder/all`)
		.then(resp => {
			$scope.listorder = resp.data

			//Tổng đơn hàng
			$scope.totalOrders = $scope.listorder.length

			$scope.totalOrders = $scope.listorder.length;

			// Get current date
			const currentDate = new Date();

			// Calculate start and end dates for week, month, and year
			const startOfWeek = new Date(currentDate);
			startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay()); // Go to the start of the current week (Sunday)
			const endOfWeek = new Date(startOfWeek);
			endOfWeek.setDate(endOfWeek.getDate() + 6); // Go to the end of the current week (Saturday)

			const startOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
			const endOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);

			const startOfYear = new Date(currentDate.getFullYear(), 0, 1);
			const endOfYear = new Date(currentDate.getFullYear(), 11, 31);

			// Filter orders for week, month, and year
			$scope.ordersThisWeek = $scope.listorder.filter(order => {
				const orderDate = new Date(order.orderDate);
				return orderDate >= startOfWeek && orderDate <= endOfWeek;
			}).length;

			$scope.sorordersGiao = $scope.listorder.filter(order => {
				
				return order.orderStatus=="Delivered";
			}).length;
			$scope.sororderHuy = $scope.listorder.filter(order => {
				
				return order.orderStatus=="Cancel";
			}).length;

			$scope.ordersThisMonth = $scope.listorder.filter(order => {
				const orderDate = new Date(order.orderDate);
				return orderDate >= startOfMonth && orderDate <= endOfMonth;
			}).length;

			$scope.ordersThisYear = $scope.listorder.filter(order => {
				const orderDate = new Date(order.orderDate);
				return orderDate >= startOfYear && orderDate <= endOfYear;
			}).length;


			$scope.filteredOrders = $scope.listorder.filter(order => {
				return order.orderStatus === 'Pending';
			});

			$scope.filteredOrders.forEach(item => {

				item.formattedDate = formatDate(item.orderDate)
			})
			console.log($scope.filteredOrders);
		})
		.catch(error => {
			console.error('Error fetching orders:', error);
		});

	function formatDate(date) {
		// Parse the input date string
		const inputDate = new Date(date);

		// format gio VN
		const options = {
			year: 'numeric',
			month: '2-digit',
			day: '2-digit',
			hour: '2-digit',
			minute: '2-digit',
			second: '2-digit',
			hour12: false, // 24-hour format
			timeZone: 'Asia/Ho_Chi_Minh', //  time zone
		};

		// Format the date using Intl.DateTimeFormat
		const formattedDate = new Intl.DateTimeFormat('vi-VN', options).format(inputDate);

		return formattedDate;
	}
	$scope.pagerOrder = {
		page: 0,
		size: 10,
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
		get filteredOrders() {
			var start = this.page * this.size;
			return $scope.filteredOrders.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.filteredOrders.length / this.size);
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
	//Long Hai end

	//tien sờ ta



	$scope.itemss = [];
	$scope.initializeSupp = function () {
		//load supplier no deleted
		$http.get("/rest/supplier/nodeleted").then(resp => {
			$scope.itemss = resp.data;
			$scope.totalSuppliers = $scope.itemss.length;
			console.log("Tổng toàn bộ nhà cung cấp:", $scope.totalSuppliers);
		});


	}
    $scope.initializeSupp();

	// tien en


	$scope.lResponseUsers = [];
	$scope.initializeBTB = function () {
		$http.get("/user/dkgn").then(resp => {
			$scope.lResponseUsers = resp.data;
			// angular.forEach($scope.lResponseUsers.createdDate, function(date, index) {
			// 		$scope.dateList[index] = $filter('date')(date, 'dd-MM-yyyy');
			// });
		});
	}
	$scope.initializeBTB();

	// date format
	$scope.convertDateFormat = function(input) {
		if (!input) return '';
		var date = new Date(input);
		var formattedDate =
			('0' + date.getDate()).slice(-2) +
			'/' +
			('0' + (date.getMonth() + 1)).slice(-2) +
			'/' +
			date.getFullYear();
		return formattedDate;
	};


	$scope.sumUser = 0;
	$scope.initializeBTB2 = function () {
		$http.get("/user/sumUser").then(resp => {
			$scope.sumUser = resp.data;
		});
	}
	$scope.initializeBTB2();


	$scope.role = '';
	$scope.initializeBTB_Role = function () {
		// Gọi API bằng AngularJS
		$http.get('/user/getRole')
			.then(function(response) {
				$scope.role = response.data.role;
				console.log("role: |"+$scope.role+'|');
			})
			.catch(function(error) {
				console.log('Error getting role:', error);
				// Xử lý khi gặp lỗi khi gọi API
			});
	}
	$scope.initializeBTB_Role();

});
