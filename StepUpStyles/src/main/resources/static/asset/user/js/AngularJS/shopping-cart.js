const app = angular.module("app", ['ui.filters']);
app.controller("cart-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

	$scope.coloritems = [];
	$scope.prods = [];
	$scope.cartitems = [];
	$scope.selectedColors = {};
	$scope.cout=0
	//Load data
	$scope.initialize = function () {
		$scope.tongTien=0
		localStorage.removeItem('selectedItems');
		$http.get(`/rest/cart`)
			.then(resp => {
				const cartItems = resp.data;
				 //console.log(cartItems);
				 
				$scope.updateCount(cartItems.length)
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
							console.log("size",cartItem.sizes)

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
							console.log("color",cartItem.colors)

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
				if ($scope.items.length>0) {
					$scope.page = true
				}else
				$scope.page = false

				
			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});

			
	}

	$scope.initialize();

	//Unique productDetai in cart
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
	//------------------------------------

	//Check cart 
	$scope.checkButton = function () {
	if ($scope.tongTien==0) {
			return false
		}else 
			return true
	}
	$scope.checkOne = function (index) {
		$scope.items[index].isSelected = !$scope.items[index].isSelected;
		setTongTien()
		checkCheck()

		updateLocalStorage()
	}
	$scope.checkBox = function () {
		var checkBox = document.getElementById("checkAll");
		if (checkBox.checked == true) {
			checkAll();

		} else {
			unCheckAll();
		}
		 setTongTien();
	}

	function checkCheck() {
		var checkAll = true;
		angular.forEach($scope.items, function (value, key) {
			
			if (!value.isSelected ) {
				console.log(value.isSelected);
				checkAll = false;
				console.log(1,checkAll);
			}
		});

		console.log(3,checkAll);

		var check = document.getElementById("checkAll");

		if (checkAll == true ) {
			check.checked = true;
		} else {
			check.checked = false;
		}
	}
	function checkAll() {
		angular.forEach($scope.items, function (value, key) {
			// if (value.inventory >= value.quantity) {
				if (value.quantity <= value.productDetail.quantity) {
					
					value.isSelected = true;
					updateLocalStorage()
				}

			// }
		});
	}

	function unCheckAll() {
		angular.forEach($scope.items, function (value, key) {
			value.isSelected = false;
			updateLocalStorage()
		});
	}

	function updateLocalStorage() {
		var selectedItems = $scope.items.filter(function (item) {
			return item.isSelected;
		});
		// Save selected items as JSON in local storage
		localStorage.setItem('selectedItems', JSON.stringify(selectedItems));
	}
	
$scope.updateCount = function (newCount) {
    $scope.count = newCount;
    console.log($scope.count);
};
	// Data modification
	$scope.addToCart = function (id, size, color, qty) {

		$http.post(`/rest/cart?id=${id}&size=${size}&color=${color}&qty=${qty}`)
			// Nếu không sử dụng Object data cho phương thức bên RestController
			// Thì gán thằng biến lên URL --> truyền data cho @RequestParam(...)
			.then(function (response) {
				console.log('Added to cart: ');
				$scope.initialize()
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

	$scope.updateQuantity = function (index, method) {
		var item = angular.copy($scope.items[index])
		if (method == 1) {
			if (item.quantity < item.productDetail.quantity) {
				item.quantity += 1;
				console.log(item.quantity);
			} else {

				console.log("out of stock");
				return
			}
		} else if (method == 0) {
			item.quantity -= 1
			console.log(item.quantity);
		} else {
			 var maxQuantity = item.productDetail.quantity;
			 console.log(maxQuantity);
			// var qty = item.quantity;

			var newValue = $scope.items[index].quantity;
			console.log("New value:", newValue);
			

			if (newValue > maxQuantity) {
				item.quantity = maxQuantity;
				console.log(item.quantity);
			} else {
				item.quantity = newValue;
				console.log(newValue);
			}

			// Make an HTTP PUT request to update the quantity on the server
			$http.put("/rest/cart/updateQuantity", item)
				.then(resp => {
					$scope.items[index].quantity = item.quantity;
					console.log($scope.items[index].quantity);
					setTongTien()
					console.log("ok");
				}).catch(error => {
					console.log("Error update", error);
				});

			return
		}
		//$scope.initialize()
		$http.put("/rest/cart/updateQuantity", item)
			.then(resp => {
				$scope.items[index].quantity = item.quantity
				console.log($scope.items[index].quantity);
				setTongTien()
				console.log("ok");
			}).catch(error => {
				console.log("Error update", error)
			});
	}

	$scope.updatetest = function (index) {
		// The updated value of item.quantity is available here in real-time
		var newValue = $scope.items[index].quantity;
		console.log("New value:", newValue);
		$scope.$apply();

		// You can perform additional actions with the new value here
	};
	function setTongTien() {
        var tongTien = 0;
        angular.forEach($scope.items, function (value, key) {
			console.log(1,value.isSelected);
            if (value.isSelected == true) {
				console.log(value.isSelected);
                tongTien += value.product.price * value.quantity;
            }
        });
		console.log(tongTien);
        $scope.tongTien = tongTien;
    }

	//ADDRESS load -------------
	


	  $scope.loadDistricts = function () {
		console.log('loadDistricts function called');
		if ($scope.selectedProvince) {
			$http({
				method: 'GET',
				url: `https://online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=${$scope.selectedProvince.ProvinceID}`,
				headers: {
				  'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
				}})
			.then(function (response) {
				console.log(response.data.data);
			  $scope.selectedProvince.Districts = response.data.data;
			  
			})
			.catch(function (error) {
			  console.error('Error fetching districts:', error);
			});
		} else {
		  $scope.selectedDistrict = null;
		  $scope.selectedWard = null;
		}
	  };
	
	  $scope.loadWards = function () {
		if ($scope.selectedDistrict) {
			$http({
				method: 'GET',
				url: `https://online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=${$scope.selectedDistrict.DistrictID}`,
				headers: {
				  'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
				}})
		 
			.then(function (response) {
				console.log($scope.selectedDistrict.DistrictID);
			  $scope.selectedDistrict.Wards = response.data.data;
			})
			.catch(function (error) {
			  console.error('Error fetching wards:', error);
			});
		} else {
		  $scope.selectedWard = null;
		}
	  };

	  $http({
		method: 'GET',
		url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/province',
		headers: {
		  'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
		}
	  }).then(function(response) {
		$scope.provinces = response.data.data.sort(function(a, b) {
			return a.ProvinceName.localeCompare(b.ProvinceName);
		console.log(response.data);})
	  })
	  .catch(function(error) {
		console.error('Error fetching provinces:', error);
	  });

	  
	 

	  $scope.calculateShipping = function () {
		if ($scope.selectedWard) {
		  // Gửi yêu cầu tính tiền ship dựa trên địa chỉ đã chọn
		  $scope.dataAddress= {
			// Truyền thông tin địa chỉ vào yêu cầu
			province_id: $scope.selectedProvince.ProvinceID,
			district_id: $scope.selectedDistrict.DistrictID,
			ward_id: $scope.selectedWard.WardID,
			// Các thông tin khác cần thiết
		  }

		  $scope.data1 = {
			"service_type_id": 2,
			"insurance_value": null,
			"coupon": null,
			"from_district_id": 1574,
			"to_district_id": $scope.dataAddress.district_id,
			"to_ward_code": $scope.dataAddress.ward_id,
			"height": 15,
			"length": 38,
			"weight": 1000,
			"width": 15
		}
		  $http({
			
			method: 'POST', // Hoặc phương thức GET tùy theo yêu cầu của API
			url: 'https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee',
			data: $scope.data1,
			headers: {
			  'Token': 'da60559e-557a-11ee-af43-6ead57e9219a',
			  'ShopId': '4551956'
			},
		  })
		  .then(function (response) {
			$scope.data2 = response.data.data
			//$scope.total = $scope.tongTien + $scope.data2.total;
			var shippingCost = $scope.data2.total;
			alert('Tiền ship là: ' + shippingCost);
			$scope.shippingFee =shippingCost;
		  })
		  .catch(function (error) {
			console.error('Error calculating shipping:', error);
		  });
		} else {
		  alert('Vui lòng chọn địa chỉ đầy đủ để tính tiền ship.');
		}
	  };
	//--------------
}])