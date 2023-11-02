app.controller("indexAdmin-ctrl", function($scope, $http, $interval) {
	//quangminh bắt đầu 
	$scope.totalQuantity = 0;

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
		$scope.productdetailitems = resp.data;

		// Tính tổng quantity từ danh sách sản phẩm
		$scope.totalQuantity = SumQuantity(resp.data);
	});

	//thời gian hiển thị start
	$scope.currentDate = new Date();
	$scope.days = ['Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'];
	$scope.dayOfWeek = $scope.days[$scope.currentDate.getDay()];

	function updateTime() {
		$scope.currentDate = new Date();
		$scope.timeString = $scope.currentDate.getHours() + 'h:' + $scope.currentDate.getMinutes() + 'm';
	}

	// Cập nhật thời gian mỗi giây
	$interval(updateTime, 1000);

	//thời gian hiển thị end
	//quangminh kết thúc

});
