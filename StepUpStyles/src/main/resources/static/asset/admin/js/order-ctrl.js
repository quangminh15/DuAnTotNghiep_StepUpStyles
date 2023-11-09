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

	$scope.sortableColumns = [
		{ name: 'orderId', label: 'Mã đơn hàng' },
		{ name: 'deliveryDate', label: 'Ngày giao' },
		{ name: 'deliveryStatus', label: 'trạng thái giao hàng' },
		{ name: 'initialPrice', label: 'Tổng giá sản phẩm' },
		{ name: 'orderStatus', label: 'Trạng thái đơn hàng' },
		{ name: 'orderorderDate', label: 'Ngày đặt' },
		{ name: 'paymentStatus', label: 'Tình trạng thanh toán' },
		{ name: 'totalAmount', label: 'Tổng thanh toán' },
		{ name: 'paymentMenthod.paymentMethodName', label: 'Thanh toán' }

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

	$scope.viewDetail = function (id) {
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