app.controller("order-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
	$scope.orders = []
	$scope.allOrders = []
	$scope.orderDetail = []
	$scope.initialize = function () {

		// $http.get(`/rest/order/listOrder`)
		// 	.then(resp => {

		// 		$scope.orders = resp.data

		// 		console.log("orders", $scope.orders);

		// 		console.log("1", $scope.orders.shippingAddress)


		// 		$scope.orders.forEach(item => {


		// 			$http.get(`/rest/order/listOrder/detail?orderid=${item.orderId}`)
		// 				.then(respone => {
		// 					$scope.orderDetail = respone.data
		// 					console.log("order", $scope.orderDetail);

		// 					$scope.orderDetail.forEach(orderdetails => {
		// 						console.log("s1", orderdetails.productDetail.product.productID);
		// 						$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
		// 							orderdetails.image = resp.data;
		// 							console.log("s2", orderdetails.image);

		// 						})

		// 					})
		// 				})
		// 		});
		// 	})
		// 	.catch(function (error) {
		// 		console.error('Error fetching cart items:', error);
		// 	});


		// LOAD ALL ORDER
		$http.get(`/rest/order/listOrder/all`)
			.then(resp => {

				$scope.allOrders = resp.data

				console.log("orders", $scope.allOrders);


				$scope.allOrders.sort((a, b) => {
					
					return new Date(b.orderDate) - new Date(a.orderDate);
				  });
				  $scope.pager.first()
				$scope.orders.forEach(item => {


					$http.get(`/rest/order/listOrder/detail?orderid=${item.orderId}`)
						.then(respone => {
							$scope.orderDetail = respone.data
							console.log("order", $scope.orderDetail);

							$scope.orderDetail.forEach(orderdetails => {
								console.log("s1", orderdetails.productDetail.product.productID);
								$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
									orderdetails.image = resp.data;
									console.log("s2", orderdetails.image);

								})

							})
						})
				});
			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});


	}
	$scope.initialize()

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
		get allOrders() {
			var start = this.page * this.size;
			return $scope.allOrders.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.allOrders.length / this.size);
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
		{ name: 'orderId', label: 'STT' },
		{ name: 'shippingAddress.nameReceiver', label: 'Người Nhận' },
		{ name: 'orderorderDate', label: 'Ngày đặt' },
		{ name: 'paymentStatus', label: 'Tình trạng thanh toán' },
		{ name: 'totalAmount', label: 'Tổng thanh toán' },
		{ name: 'paymentMenthod.paymentMethodName', label: 'Thanh toán' },
		{ name: 'orderStatus', label: 'Trạng thái đơn hàng' },

	];

	$scope.sortByColumn = function (columnName) {

		if ($scope.sortColumn === columnName) {
			$scope.sortReverse = !$scope.sortReverse;
		} else {
			$scope.sortColumn = columnName;
			$scope.sortReverse = false;
		}

		$scope.productitems.sort(function (a, b) {
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
	
	$scope.updateStatus=function (id,status) {
		Swal.fire({
			title: "Cập nhật đơn hàng",
			text: "Xác nhận cập nhật thái của đơn hàng thành "+status,
			icon: "info",
			showCancelButton: true,
			confirmButtonColor: "#3085d6",
			cancelButtonColor: "#d33",
			confirmButtonText: "Cập Nhật",
			cancelButtonText: "Hủy"
		}).then((result) => {
			if (result.isConfirmed) {
				$http.put(`/rest/order/updateStatus?id=${id}&status=${status}`)
		.then(respone=>{
			alert("status update")
			$scope.initialize()
		}).catch(function (error) {
			console.error('Error update:', error);
		});

			}
		});
		
	}
	
	
	$scope.viewDetail = function (id) {
		$http.get(`/rest/order/single?orderid=${id}`)
			.then(resp => {
				$scope.singleOrder = resp.data
			}).catch(function (error) {
				console.error('Error update:', error);
			});
		$http.get(`/rest/order/listOrder/detail?orderid=${id}`)
			.then(respone => {
				$scope.orderDetail = respone.data
				console.log("orderdetaill", $scope.orderDetail);

				$scope.orderDetail.forEach(orderdetails => {
					console.log("s1", orderdetails.productDetail.product.productID);
					$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
						orderdetails.image = resp.data;
						console.log("s2", orderdetails.image);

					})

				})
			})
	}
}])