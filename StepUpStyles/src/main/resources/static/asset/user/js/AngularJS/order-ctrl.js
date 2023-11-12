app.controller("order-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
	$scope.orders=[]
	$scope.orderDetail=[]
	$scope.initialize = function () {

		$http.get(`/rest/order/listOrder`)
			.then(resp => {
				
				$scope.orders = resp.data
				
				console.log("orders",$scope.orders);
				
				console.log("1",$scope.orders.shippingAddress)
			
				
				$scope.orders.forEach(item => {
				
					
					$http.get(`/rest/order/listOrder/detail?orderid=${item.orderId}`)
					.then(respone=>{
						item.orderDetail = respone.data
						console.log("order",$scope.orderDetail);
						item.orderDetail.forEach(orderdetails => {
							$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
								orderdetails.productDetail.product.productImages = resp.data;
								console.log("s2",orderdetails.productDetail.product.productImages);
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
}])