app.controller("order-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
	$scope.orders = []
	$scope.allOrders = []
	$scope.orderDetail = []
	$scope.filteredOrders = [];
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


				

				$scope.filteredOrders = angular.copy($scope.allOrders);



				$scope.ordersPending = $scope.allOrders.filter(order => {

					return order.orderStatus == 'Pending';
				}).length;

				$scope.ordersConfirmed = $scope.allOrders.filter(order => {

					return order.orderStatus == 'Confirmed';
				}).length;

				$scope.ordersShipping = $scope.allOrders.filter(order => {

					return order.orderStatus == 'Shipping';
				}).length;

				$scope.ordersDelivered = $scope.allOrders.filter(order => {

					return order.orderStatus == 'Delivered';
				}).length;

				$scope.ordersCancel = $scope.allOrders.filter(order => {

					return order.orderStatus == 'Cancel';
				}).length;

				$scope.filteredOrders.forEach(item => {

					item.formattedDate = formatDate(item.orderDate)
				})
				$scope.filteredOrders.sort((a, b) => {
					const statusPriority = {
						'Pending': 3,
						'Confirmed': 2,
						'Shipping': 1, // Đặt ưu tiên cho orderStatus 'pending'
						// Định nghĩa mức độ ưu tiên cho các orderStatus khác nếu cần
					};

					// Xác định mức độ ưu tiên cho từng order
					const statusPriorityA = statusPriority[b.orderStatus] || 0;
					const statusPriorityB = statusPriority[a.orderStatus] || 0;

					if (statusPriorityA !== statusPriorityB) {
						
						return statusPriorityA - statusPriorityB;
					} else {
						// Nếu cả hai đơn hàng có cùng mức độ ưu tiên, sắp xếp theo ngày
						
						if (statusPriorityA==3 || statusPriorityB==3 ) {
							
							return new Date(a.orderDate) - new Date(b.orderDate);
						}else{

							return new Date(b.orderDate) - new Date(a.orderDate);
						}
					}
				});
				$scope.pager.first()
				$scope.orders.forEach(item => {
					//định dạng

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

		$scope.selectedActivity = 'all'
	}
	$scope.initialize()

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
	$scope.sortableColumns = [
		{ name: 'orderId', label: 'Mã Đơn' },
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

	$scope.updateStatus = function (id, status) {
		var vnStatus = '';
		if (status == 'Confirmed') {
			vnStatus = "Đã xác nhận"
		}
		else if (status == 'Shipping') {
			vnStatus = "Đang giao"
		}
		else if (status == 'Delivered') {
			vnStatus = "Đã giao"
		}
		else if (status == 'Cancel') {
			vnStatus = "Đã hủy"
		}

		//custom confirm alert

		let statusColor = ""; // Default color

		// Assuming vnStatus determines the color
		if (vnStatus === "Đã xác nhận") {
			statusColor = "text-info"; // Change color for "shipped" status to green
		} else if (vnStatus === "Đang giao") {
			statusColor = "text-warning"; // Change color for "processing" status to orange
		}else if (vnStatus === "Đã giao") {
			statusColor = "text-success"; // Change color for "processing" status to orange
		}else if (vnStatus === "Đã hủy") {
			statusColor = "text-danger"; // Change color for "processing" status to orange
		}
		Swal.fire({
			title: "Cập nhật đơn hàng",
			html: `<span>Xác nhận cập nhật thái của đơn hàng thành</span><h3 class="${statusColor}">${vnStatus}</h3>`,
			icon: "info",
			showCancelButton: true,
			confirmButtonColor: "#3085d6",
			cancelButtonColor: "#d33",
			confirmButtonText: "Cập Nhật",
			cancelButtonText: "Hủy"
		}).then((result) => {
			if (result.isConfirmed) {
				$http.put(`/rest/order/updateStatus?id=${id}&status=${status}`)
					.then(respone => {
						const Toast = Swal.mixin({
							toast: true,
							position: 'top',
							showConfirmButton: false,
							timer: 3000,
							timerProgressBar: true,
							didOpen: (toast) => {
								toast.addEventListener('mouseenter', Swal.stopTimer)
								toast.addEventListener('mouseleave', Swal.resumeTimer)
							}

						})
						Toast.fire({
							icon: 'success',
							title: 'Cập nhật thành công',

						})
						$scope.initialize()
					}).catch(function (error) {
						console.error('Error update:', error);
					});

			}
		});

	}
	$scope.calculateItemTotal = function (item) {
		let totalQuantity = 0;
		for (let i = 0; i < $scope.orderDetail.length; i++) {
			totalQuantity += $scope.orderDetail[i].quantity;
		}
		return totalQuantity;
	};

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
					$scope.calculateItemTotal(orderdetails)
					console.log("s1", orderdetails.productDetail.product.productID);
					$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
						orderdetails.image = resp.data;
						console.log("s2", orderdetails.image);

					})

				})
			})
	}

	$scope.filterByStatus = function (status) {

		$scope.filteredOrders = angular.copy($scope.allOrders);

		

		if (status) {
			if (status == 'pending') {

				$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

					return order.orderStatus == 'Pending';
				})

			} else if (status == 'confirmed') {
				$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

					return order.orderStatus == 'Confirmed';
				})

			} else if (status == 'shipping') {
				$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

					return order.orderStatus == 'Shipping';
				})

			} else if (status == 'shipped') {
				$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

					return order.orderStatus == 'Delivered';
				}).sort(function(a, b) {
				
					return new Date(b.orderDate) - new Date(a.orderDate);
				});

			} else if (status == 'cancel') {
				$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {
					
					return order.orderStatus == 'Cancel';
				}).sort(function(a, b) {
				
					return new Date(b.orderDate) - new Date(a.orderDate);
				});

			} else {
				$scope.filteredOrders.sort((a, b) => {


					const statusPriority = {
						'Pending': 5,
						'Confirmed': 4,
						'Shipping': 3, 
						'Delivered': 2,
						'Cancel': 1,// Đặt ưu tiên cho orderStatus 'pending'
						// Định nghĩa mức độ ưu tiên cho các orderStatus khác nếu cần
					};

					// Xác định mức độ ưu tiên cho từng order
					const statusPriorityA = statusPriority[b.orderStatus] || 0;
					const statusPriorityB = statusPriority[a.orderStatus] || 0;

					if (statusPriorityA !== statusPriorityB) {
						
						return statusPriorityA - statusPriorityB;
					} else {
						// Nếu cả hai đơn hàng có cùng mức độ ưu tiên, sắp xếp theo ngày
						
						if ((statusPriorityA==3 && statusPriorityB==3) || (statusPriorityA==2 && statusPriorityB==2)||(statusPriorityA==1 && statusPriorityB==1)) {
							
							return new Date(b.orderDate) - new Date(a.orderDate);
						}else{

							return new Date(a.orderDate) - new Date(b.orderDate);
						}
					}


				});
			}
		} else {
			if ($scope.selectedActivity === "newest" || $scope.selectedActivity === "all") {
				$scope.filteredOrders.sort((a, b) => {

					const statusPriority = {
						'Pending': 3,
						'Confirmed': 2,
						'Shipping': 1, // Đặt ưu tiên cho orderStatus 'pending'
						// Định nghĩa mức độ ưu tiên cho các orderStatus khác nếu cần
					};

					// Xác định mức độ ưu tiên cho từng order
					const statusPriorityA = statusPriority[b.orderStatus] || 0;
					const statusPriorityB = statusPriority[a.orderStatus] || 0;

					if (statusPriorityA !== statusPriorityB) {
						
						return statusPriorityA - statusPriorityB;
					} else {
						// Nếu cả hai đơn hàng có cùng mức độ ưu tiên, sắp xếp theo ngày
						
						if (statusPriorityA==3 || statusPriorityB==3 ) {
							
							return new Date(b.orderDate) - new Date(a.orderDate);
						}else{

							return new Date(a.orderDate) - new Date(b.orderDate);
						}
					}
				});

			} else if ($scope.selectedActivity === "oldest") {
				$scope.filteredOrders.sort((b, a) => {

					return new Date(b.orderDate) - new Date(a.orderDate);
				});
			} else {


				if ($scope.selectedActivity === "pending") {
					$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

						return order.orderStatus == 'Pending';
					})

				} else if ($scope.selectedActivity === "confirmed") {
					$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

						return order.orderStatus == 'Confirmed';
					})

				} else if ($scope.selectedActivity === "shipping") {
					$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

						return order.orderStatus == 'Shipping';
					})

				} else if ($scope.selectedActivity === "shipped") {
					$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

						return order.orderStatus == 'Delivered';
					})

				} else if ($scope.selectedActivity === "cancel") {
					$scope.filteredOrders = $scope.filteredOrders.filter(function (order) {

						return order.orderStatus == 'Cancel';
					})

				}

			}
		}
		$scope.pager.first()
		$scope.filteredOrders.forEach(item => {

			item.formattedDate = formatDate(item.orderDate)
		})
		
	}
}])