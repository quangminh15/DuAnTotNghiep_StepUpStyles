app.controller("order-ctrl", function($scope, $http){
	$scope.orderitems = [];
	$scope.orderdetailitems = [];
	$scope.orderstatusitems = [];
	$scope.getOrderID ={};
	$scope.selectedStatus = 'all'
	$scope.initialize = function() {
		$http.get("/rest/orders/loadall").then(resp => {
			$scope.orderitems = resp.data;
			$scope.orderitems.forEach(orderitem => {
				orderitem.orderDate = new Date(orderitem.orderDate)
			})
			$scope.orderitems.sort((a, b) => b.orderDate - a.orderDate);
			$scope.pager.first();
		}).catch(error => {
			
		});
		
		$http.get("/rest/orderstatuss/loadall").then(resp => {
			$scope.orderstatusitems = resp.data;
			$scope.pager.first();
		});
		
	}
	
	$scope.getOrderID = function(orderID) {
		$http.get("/rest/orderdetails/getOrderID/" + orderID).then(resp => {			
		console.log(resp.data);
		$scope.orderdetailitems = resp.data;
		$('#orderModal').modal('show');
	    }	    
	)}	
	
	//	Khởi đầu
	$scope.initialize();

	//	Phân trang
	$scope.pager = {
		page: 0,
		size: 8,
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
		get orderitems() {
			var start = this.page * this.size;
			return $scope.orderitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.orderitems.length / this.size);
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
	
	$scope.updateStatus = function(order) {
		order.orderStatusID = 3
		$http.post('/rest/orders/update/' + order.orderID).then(resp => {
			console.log("Success", resp);
			$scope.initialize(); // Reload trang :))
		}).catch(error => {			
			console.log("Error", error);
		})
	};
	
	$scope.filterByOrderStatus = function() {
		if ($scope.selectedOrder) {
			$http.get("/rest/orders/loadbyorderstatus/" + $scope.selectedOrder).then(resp => {
				$scope.orderitems = resp.data;
				$scope.pager.first();
			}).catch(error => {
				$scope.pager.first();
			});
		} else {
			$scope.initialize();
		}
	};


})