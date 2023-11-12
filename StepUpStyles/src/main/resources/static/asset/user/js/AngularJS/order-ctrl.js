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
						$scope.orderDetail = respone.data
						console.log("order",$scope.orderDetail);

						$scope.orderDetail.forEach(orderdetails => {
							console.log("s1",orderdetails.productDetail.product.productID);
								$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
									 orderdetails.image = resp.data;
									 console.log("s2",orderdetails.image);
									
							})
				
						})
					})
				});
			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});

		
			
			
	}

		$scope.showModalReview = function(){
			$('#reviewModal').modal('show');
		}

	$scope.initialize()
}])