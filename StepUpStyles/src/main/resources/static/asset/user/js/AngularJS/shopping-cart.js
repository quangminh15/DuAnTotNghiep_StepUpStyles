const app = angular.module("app", ['ui.filters']);
app.controller("cart-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

	$scope.coloritems = [];
	$scope.prods = [];
	$scope.cartitems = [];
	$scope.selectedColors = {};


	$scope.initialize = function () {

		$http.get(`/rest/cart`)
			.then(resp => {
				const cartItems = resp.data;
				// console.log(cartItems);

				// Initialize the disabledColors object
				$scope.disabledSizes = {};

				$scope.disabledColors = {};

				// Loop through each item in the cart
				cartItems.forEach(cartItem => {
					const productId = cartItem.product.productID;
					const sizeId = cartItem.productDetail.size.sizeID;
					const colorId = cartItem.productDetail.color.colorID;


					// Initialize the 'colors' property for the cart item
					cartItem.colors = [];
					cartItem.sizes = [];

					// Make an API request to get size information for the product
					$http.get(`/rest/cart/sizes?prodID=${productId}&colorID=${colorId}`)
						.then(sizeResp => {
							cartItem.sizes = sizeResp.data;
							console.log(cartItem.sizes)

							if (!$scope.disabledSizes[productId]) {
								$scope.disabledSizes[productId] = {};
							}
							
							if (!$scope.disabledSizes[productId][colorId]) {
								$scope.disabledSizes[productId][colorId] = [];
							}
							
							$scope.disabledSizes[productId][colorId].push(sizeId);
						})
						.catch(function (error) {
							console.error('Error fetching size information:', error);
						});
					// Make an API request to get color information for the product
					$http.get(`/rest/cart/colors?prodID=${productId}&sizeID=${sizeId}`)
						.then(colorResp => {
							cartItem.colors = colorResp.data;
							console.log(cartItem.colors)

							// Set disabled colors for the product
							if (!$scope.disabledColors[productId]) {
								$scope.disabledColors[productId] = {};
							}
							
							if (!$scope.disabledColors[productId][sizeId]) {
								$scope.disabledColors[productId][sizeId] = [];
							}
							
							$scope.disabledColors[productId][sizeId].push(colorId);
						})
						.catch(function (error) {
							console.error('Error fetching color information:', error);
						});



				});

				// Now, cartItems will have color and size information for each product
				$scope.items = cartItems;
				$scope.cartitems = cartItems
			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});


	}

	$scope.initialize();


	// $scope.isColorDisabled = function (productId, colorId,sizeId) {
	// 	if ($scope.disabledColors[productId]) {
			
	// 		return $scope.disabledColors[productId].includes(colorId);
	// 	}
	// 	return false;
	// };

	// $scope.isSizeDisabled = function (productId, sizeId,colorId) {
	// 	if ($scope.disabledSizes[productId]) {
	// 		return $scope.disabledSizes[productId].includes(sizeId);
	// 	}
	// 	return false;
	// };

	$scope.isColorDisabled = function (productId, colorId, sizeId) {
		if ($scope.disabledColors[productId] && $scope.disabledColors[productId][sizeId]) {
			// Check if the colorId is in the array of disabled colors for this size
			return $scope.disabledColors[productId][sizeId].includes(colorId);
		}
		return false;
	};
	
	$scope.isSizeDisabled = function (productId, sizeId, colorId) {
		if ($scope.disabledSizes[productId] && $scope.disabledSizes[productId][colorId]) {
			// Check if the sizeId is in the array of disabled sizes for this color
			return $scope.disabledSizes[productId][colorId].includes(sizeId);
		}
		return false;
	};
	
	
	

	// $scope.isColorDisabled = function (productId, colorId, sizeId) {
	// 	// Check if both the sizeId and colorId are included in disabledColors
	// 	if (
	// 		$scope.disabledColors[productId]
	// 		&&
	// 		// $scope.disabledColors[productId].includes(colorId)
	// 		// &&
	// 		 $scope.disabledSizes[productId] 
	// 		 //&&
	// 		// $scope.disabledSizes[productId].includes(sizeId)
	// 	) {
	// 		if (!$scope.disabledSizes[productId].includes(colorId) &&
	// 			!$scope.disabledSizes[productId].includes(sizeId)

	// 		){
	// 			return true;
	// 		}
	// 			return false;
	// 	} return true;
	// };

	// $scope.isSizeDisabled = function (productId, sizeId, colorId) {
	// 	// Check if both the sizeId and colorId are included in disabledColors
	// 	if (
	// 		$scope.disabledSizes[productId]
	// 		&&
	// 		// $scope.disabledSizes[productId].includes(sizeId) 
	// 		// &&
	// 		$scope.disabledColors[productId]
	// 		// $scope.disabledColors[productId].includes(colorId)

	// 	) {
			
	// 		if (
	// 			$scope.disabledSizes[productId].includes(sizeId)
	// 			&&
				
	// 			$scope.disabledColors[productId].includes(colorId)) {
	// 			console.log(1);
	// 			return true;
				
	// 		}
	// 		else if (
				
	// 			!$scope.disabledSizes[productId].includes(sizeId)
	// 			&&
				
	// 			!$scope.disabledColors[productId].includes(colorId)) {
	// 			console.log(2);
	// 			return true;
	// 		}
	// 		else if (
				
	// 			!$scope.disabledSizes[productId].includes(sizeId)
	// 			&&
				
	// 			$scope.disabledColors[productId].includes(colorId)) {
	// 			console.log(3);
	// 			return false;
	// 		}
	// 		else if (
				
	// 			$scope.disabledSizes[productId].includes(sizeId)
	// 			&&
	// 			!$scope.disabledColors[productId].includes(colorId)) {
	// 			console.log(4);
	// 			return false;
	// 		}else
	// 		return false
			
	// 	}
	// 	return true
	// };


	$scope.isColorAvailable = function (productId, colorId, sizeId) {
		// Check if the color is available for the specified size
		if ($scope.disabledColors[productId] && $scope.disabledSizes[productId]) {
			return !$scope.disabledColors[productId].includes(colorId) || !$scope.disabledSizes[productId].includes(sizeId);
		}
		return true;
	};



	$scope.addToCart = function (id, size, color, qty) {

		$http.post(`/rest/cart?id=${id}&size=${size}&color=${color}&qty=${qty}`)
			// Nếu không sử dụng Object data cho phương thức bên RestController
			// Thì gán thằng biến lên URL --> truyền data cho @RequestParam(...)
			.then(function (response) {
				console.log('Added to cart: ');
				// $scope.itemQuantity = qty;
				// $scope.showAlert = true;
				// alert("Đã thêm "+qty+" sản phẩm giỏ hàng")
				// Hide the alert after 5 seconds

			})

			.catch(function (error) {
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

	$scope.updateCartItemByColor = function (colorID, cartDetailID, index) {
		var cartDetail = angular.copy($scope.items[index])
		var sizeID = cartDetail.productDetail.size.sizeID
		var prodID = cartDetail.product.productID
		//console.log(cartDetail);
		console.log("p", cartDetail.product.productID);
		console.log("s", cartDetail.productDetail.size.sizeID);
		console.log("c", colorID);
		console.log("cd", cartDetailID);

		console.log("pd", cartDetail.productDetail.productDetailID)

		// Make an HTTP PUT request to the API endpoint
		$http.put(`/rest/cart/updateCartItem?cartDetailID=${cartDetailID}&prodID=${prodID}&size=${sizeID}&color=${colorID}`)
			.then(function (response) {
				//cartDetail.productDetail.color.colorID = colorID
				console.log('Updated cart item:', response.data);
				$scope.initialize()
				// 		// Handle success, if needed
			})
			.catch(function (error) {
				console.error('Failed to update cart item:', error);
				// 		// Handle error, if needed
			});
	};

	$scope.updateCartItemBySize = function (sizeID, cartDetailID, index) {
		var cartDetail = angular.copy($scope.items[index])
		var colorID = cartDetail.productDetail.color.colorID
		var prodID = cartDetail.product.productID




		// Make an HTTP PUT request to the API endpoint
		$http.put(`/rest/cart/updateCartItem?cartDetailID=${cartDetailID}&prodID=${prodID}&size=${sizeID}&color=${colorID}`)
			.then(function (response) {
				// cartDetail.productDetail.szie.sizeID = sizeID
				console.log('Updated cart item:', response.data);
				$scope.initialize()
				// 		// Handle success, if needed
			})
			.catch(function (error) {
				console.error('Failed to update cart item:', error);
				// 		// Handle error, if needed
			});
	};

}])