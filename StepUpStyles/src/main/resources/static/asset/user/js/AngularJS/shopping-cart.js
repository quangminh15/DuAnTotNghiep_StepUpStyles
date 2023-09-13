const app = angular.module("app", []);
app.controller("cart-ctrl", ['$scope', '$http', '$timeout', function($scope, $http, $timeout) {
	
	$http.get(`/rest/cart`)	
	.then(resp => {
		$scope.items = resp.data;
		console.log(resp.data);

		
	})

	.catch(function(error) {
		console.error('Error fetching cart items:', error);
	});

    $scope.addToCart = function(id, size, color, qty) {

		$http.post(`/rest/cart?id=${id}&size=${size}&color=${color}&qty=${qty}`)
			// Nếu không sử dụng Object data cho phương thức bên RestController
			// Thì gán thằng biến lên URL --> truyền data cho @RequestParam(...)
			.then(function(response) {
				console.log('Added to cart: ');
				// $scope.itemQuantity = qty;
				// $scope.showAlert = true;
				// alert("Đã thêm "+qty+" sản phẩm giỏ hàng")
                // Hide the alert after 5 seconds
                
            })
			
			.catch(function(error) {
				console.error('Failed to add to cart:', error);
			});
			
			
					
			
				// get amount() {
				// 	return this.cartItems.map(item => item.quantity * item.productVariant.products.price)
				// 		.reduce((total, qty) => total += qty, 0)
				// },
				// get count() {
				// 	return this.cartItems.map(item => item.quantity)
				// 		.reduce((total, qty) => total += qty, 0)
				// },
				// getSubtotalForItem(item) {
				// return item.quantity * item.productVariant.products.price;
			// }
			
	};
}])