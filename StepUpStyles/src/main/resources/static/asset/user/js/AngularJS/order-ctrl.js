app.controller("order-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
	$scope.orders=[]
	$scope.orderDetail=[]
	$scope.filterStaus=[]
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
						$scope.filterByStatusAndCheck(null)
						console.log("order",$scope.orderDetail);
						item.orderDetail.forEach(orderdetails => {
							$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
								orderdetails.productDetail.product.productImages = resp.data;
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

	$scope.updateStatus=function (id,status) {
		$http.put(`/rest/order/updateStatus?id=${id}&status=${status}`)
		.then(respone=>{
			alert("status update")
			$scope.initialize()
		}).catch(function (error) {
			console.error('Error update:', error);
		});
	}

	// Hàm lọc đánh giá theo số sao
	$scope.filterByStatus = function(status) {
		
		if (status == null) {
			$scope.filterStaus = $scope.orders;
			
		} else {
			$scope.filterStaus = $scope.orders.filter(function(order) {
				
				return order.orderStatus == status;
			})
			
		}
	}
	$scope.activeStatus=null
	$scope.filterByStatusAndCheck = function(status) {
		
		$scope.filterByStatus(status)
		$scope.activeStatus = status;
		if ($scope.filterStaus.length <1) {
			$scope.checkList = true;
		} else {
			
			$scope.checkList = false;
		}
		
	}
	

	$scope.isActiveStatus = function(status) {
		return $scope.activeStatus === status;
	};
}])