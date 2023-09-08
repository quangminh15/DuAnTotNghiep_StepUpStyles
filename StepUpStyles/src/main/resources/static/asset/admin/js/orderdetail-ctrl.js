app.controller("orderdetail-ctrl", function($scope, $http){
	$scope.orderdetailitems = [];
	$scope.initialize = function() {
		//load product
		$http.get("/rest/orderdetails/loadall").then(resp => {
			$scope.orderdetailitems = resp.data;
		});
	}

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			
		};
	}
	//	Khởi đầu
	$scope.initialize();
})