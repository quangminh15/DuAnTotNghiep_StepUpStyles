const app = angular.module("app", ['ui.filters']);
app.controller("cart-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

	$scope.coloritems = [];
	$scope.prods = [];
	$scope.cartitems = [];
	$scope.selectedColors = {};
	$scope.cout = 0
	//Load data
	


	$scope.index_of_province = function (address) {
		return $scope.province.findIndex(a => a.ProvinceName === address);
	}

	$scope.index_of_district = function (address) {
		return $scope.district.findIndex(a => a.DistrictName === address);
	}

	$scope.index_of_ward = function (address) {
		return $scope.ward.findIndex(a => a.WardName === address);
	}
	$scope.initialize = function () {
		$scope.tongTien = 0

		// localStorage.removeItem('selectedItems');
		localStorage.removeItem('totalAmount');
		// localStorage.removeItem('selectedItems');
		$http.get(`/rest/cart`)
			.then(resp => {
				const cartItems = resp.data;
				$scope.cartitems = resp.data;
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

				// $scope.items.forEach(item => {
				// 	$http.get("/rest/discount/loadbyproduct/" + item.product.productID).then(resp => {
				// 		item.product.discount = resp.data;

				// 		if (item.product.discount) {
				// 			item.product.price = item.product.price - (item.product.price * item.product.discount[0].directDiscount / 100)

				// 		}
				// 	})

				// })
				$scope.items = cartItems;
				$scope.cartitems = cartItems
				$scope.items.forEach(cartDetail => {
					$http.get("/rest/productimages/loadbyproduct/" + cartDetail.product.productID).then(resp => {
						cartDetail.product.productImages = resp.data;
						console.log("images", cartDetail.product.productImages);
					})

					$http.get("/rest/discount/loadbyproduct/" + cartDetail.product.productID).then(resp => {
						cartDetail.product.directDiscount = resp.data.filter(directDiscounts => !directDiscounts.deleted);
					})
				})

				if ($scope.items.length > 0) {
					$scope.page = true
				} else
					$scope.page = false


			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});


		$http.get(`/rest/address/default`)
			.then(resp => {
				$scope.addressDefault = resp.data
				console.log(resp.data);
				$scope.getAddressToShippingFee($scope.addressDefault.province, $scope.addressDefault.district, $scope.addressDefault.ward)

			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});
			localStorage.removeItem('selectedItems');

	}
	$scope.singleProd = []

	$scope.showQuantityStock = function (id, size, color) {

		$scope.qty = 1
		$scope.checkColor = color;

		console.log("color đã chọn: ", $scope.checkColor);

		$http.get(`/rest/productdetails/find?id=${id}&size=${size}&color=${color}`)
			.then(function (response) {
				$scope.singleProd = response.data
				console.log("prod", $scope.singleProd);

			})

			.catch(function (error) {
				console.error('Failed to add to cart:', error);
			});

	}
	$scope.delete = function (id) {
		$http.delete(`/rest/cart/delete?cartId=${id}`).then(function (respone) {

			$scope.countcartItems()
			updateCartCount()
			$scope.initialize()
		})
			.catch(function (error) {
				console.error('Failed to delete:', error);
			});
	}
	$scope.checkQuantity = function (index,qty) {
		var item = angular.copy($scope.items[index])
		if ($scope.singleProd.quantity < qty) {

			console.log("qty", $scope.qty, $scope.singleProd.quantity);
			const Toast = Swal.mixin({
				toast: true,
				position: 'top',
				showConfirmButton: false,
				timer: 3000,
				timerProgressBar: true,
				didOpen: (toast) => {
					toast.addEventListener('mouseenter', Swal.stopTimer)
					toast.addEventListener('mouseleave', Swal.resumeTimer)
				}
			})

			Toast.fire({
				icon: 'error',
				title: 'Số lượng không đủ',

			})

			$scope.qty = $scope.singleProd.quantity
		}
		if (qty<1) {
			$scope.qty=1
		}else if ( isNaN(qty)) {
			$scope.qty = 1
		} 
	}


	$scope.initialize();

	$scope.getAddressToShippingFee = function (p, d, w) {
		if (!p || !d || !w) {
			$scope.shippingFee = 0
		} else {

			$scope.dataAddress = {
				"service_type_id": 2,
				"insurance_value": null,
				"coupon": null,
				"from_district_id": 1574,
				"to_district_id": null,
				"to_ward_code": null,
				"height": 15,
				"length": 38,
				"weight": 1000,
				"width": 15
			}
			$http({
				method: 'GET',
				url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/province',
				headers: {
					'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
				}
			}).then(function successCallback(response) {
				$scope.province = response.data.data;
				// console.log($scope.province);
				$scope.current_province = $scope.province[$scope.index_of_province(p)]

				$http({
					method: 'GET',
					url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=' + $scope.current_province.ProvinceID,
					headers: {
						'Token': 'da60559e-557a-11ee-af43-6ead57e9219a',
						'ShopId': '4551956'
					}
				}).then(function successCallback(response) {
					$scope.district = response.data.data;
					console.log($scope.district);
					$scope.dataAddress.to_district_id = $scope.district[$scope.index_of_district(d)].DistrictID
					$http({
						method: 'GET',
						url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + $scope.dataAddress.to_district_id,
						headers: {
							'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
						}
					}).then(function successCallback(response) {
						$scope.ward = response.data.data

						$scope.dataAddress.to_ward_code = $scope.ward[$scope.index_of_ward(w)].WardID
						$http({
							method: 'POST',
							url: 'https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee',
							data: $scope.dataAddress,
							headers: {
								'Token': '62a1bc3a-43d0-11ee-af43-6ead57e9219a',
								'ShopId': '4490048'
							}
						}).then(function (response) {
							$scope.data2 = response.data.data
							//$scope.total = $scope.tongTien + $scope.data2.total;
							var shippingCost = $scope.data2.total;
							// alert('Tiền ship là: ' + Math.floor(shippingCost));
							$scope.shippingFee = Math.floor(shippingCost);
						})
							.catch(function (error) {
								console.error('Error calculating shipping:', error);
							});
					}
					)
				})
			})
		}


	}

	$scope.countcartItems = function () {
		return $scope.cartitems.length
	}



	$scope.checkout = function () {
		var storedItems = localStorage.getItem('selectedItems');
		var parseData = JSON.parse(storedItems);
		var handle = ""
		var check = true
		if (Array.isArray(parseData)) {
			if (parseData.length > 0) {
				check = true
				console.log(check);
				handle = ""
				console.log("han", handle);
			} else {
				check = false
				console.log(check);

				handle = "data-swal-toast-template"
				console.log("han1", handle);
			}
		} else {
			check = false
		}

		if (check == true) {
			console.log("true");
			console.log("Length of parseData:", parseData.length);
			window.location.href = '/checkout';
		} else {
			console.log(false);
			const Toast = Swal.mixin({
				toast: true,
				position: 'top',
				showConfirmButton: false,
				timer: 3000,
				timerProgressBar: true,
				didOpen: (toast) => {
					toast.addEventListener('mouseenter', Swal.stopTimer)
					toast.addEventListener('mouseleave', Swal.resumeTimer)
				}
			})

			Toast.fire({
				icon: 'error',
				title: 'Vui lòng chọn ít nhất 1 sản phẩm',

			})
		}
	}
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
		if ($scope.tongTien == 0) {
			return false
		} else
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

			if (!value.isSelected) {
				console.log(value.isSelected);
				checkAll = false;
				console.log(1, checkAll);
			}
		});

		console.log(3, checkAll);

		var check = document.getElementById("checkAll");

		if (checkAll == true) {
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

		if (!size || !color) {
			const Toast = Swal.mixin({
				toast: true,
				position: 'top-right',
				showConfirmButton: false,
				timer: 3000,
				timerProgressBar: true,
				didOpen: (toast) => {
					toast.addEventListener('mouseenter', Swal.stopTimer)
					toast.addEventListener('mouseleave', Swal.resumeTimer)
				},
				customClass: {
					// Add your custom CSS class here
					popup: 'custom-toast-class',
				}
			})
			Toast.fire({
				icon: 'error',
				title: 'Vui lòng chọn size và màu sắc',

			})
		} else {


			if ($scope.singleProd.quantity <= 0) {
				Swal.fire({
					title: "Thêm Vào Giỏ Hàng?",
					text: "Sản phẩm hiện tại đang hết hàng, bạn vẫn có thêm vào giỏ hàng nhưng chưa thể mua ngay được!",
					icon: "warning",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "Thêm Vào Giỏ Hàng!"
				}).then((result) => {
					if (result.isConfirmed) {
						$http.post(`/rest/cart?id=${id}&size=${size.sizeID}&color=${color.colorID}&qty=${qty}`)

							.then(function (response) {
								console.log('Added to cart: ');
								const Toast = Swal.mixin({
									toast: true,
									position: 'top-right',
									showConfirmButton: false,
									timer: 3000,
									timerProgressBar: true,
									didOpen: (toast) => {
										toast.addEventListener('mouseenter', Swal.stopTimer)
										toast.addEventListener('mouseleave', Swal.resumeTimer)
									},
									customClass: {
										// Add your custom CSS class here
										popup: 'custom-toast-class',
									}
								})
								Toast.fire({
									icon: 'success',
									title: 'Đã Thêm Sản Phẩm Vào Giỏ Hàng',

								})
								$scope.countcartItems()
								updateCartCount()
								$scope.initialize()

							})

							.catch(function (error) {
								console.error('Failed to add to cart:', error);
							});

					}
				});
			} else {
				$http.post(`/rest/cart?id=${id}&size=${size.sizeID}&color=${color.colorID}&qty=${qty}`)

					.then(function (response) {
						console.log('Added to cart: ');
						const Toast = Swal.mixin({
							toast: true,
							position: 'top-right',
							showConfirmButton: false,
							timer: 3000,
							timerProgressBar: true,
							didOpen: (toast) => {
								toast.addEventListener('mouseenter', Swal.stopTimer)
								toast.addEventListener('mouseleave', Swal.resumeTimer)
							},
							customClass: {
								// Add your custom CSS class here
								popup: 'custom-toast-class',
							}
						})
						Toast.fire({
							icon: 'success',
							title: 'Đã Thêm Sản Phẩm Vào Giỏ Hàng',

						})
						$scope.countcartItems()
						updateCartCount()
						$scope.initialize()

					})

					.catch(function (error) {
						console.error('Failed to add to cart:', error);
					});
			}

		}
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


		$http.put(`/rest/cart/updateCartItem?cartDetailID=${cartDetailID}&prodID=${prodID}&size=${sizeID}&color=${colorID}`)
			.then(function (response) {
				//cartDetail.productDetail.color.colorID = colorID
				console.log('Updated cart item:', response.data);
				$scope.initialize()

			})
			.catch(function (error) {
				console.error('Failed to update cart item:', error);

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

			})
			.catch(function (error) {
				console.error('Failed to update cart item:', error);

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
			if (item.quantity < 1) {
				item.quantity = 1
				Swal.fire({
					title: `<h2 class="text-danger">Bạn có chắc muốn xóa sản phẩm này</h2>`,
					html: `<h3>${item.product.productName} (Màu:${item.productDetail.color.colorName}, Size:${item.productDetail.size.sizeNumber}) </h3>`,

					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "Có",
					cancelButtonText: "Hủy",
					customClass: {
						title: 'my-title-class',
						popup: 'containerPopup'
					}
				}).then((result) => {
					if (result.isConfirmed) {

						$scope.delete(item.cartDetailId)

						const Toast = Swal.mixin({
							toast: true,
							position: 'top',
							showConfirmButton: false,
							timer: 3000,
							timerProgressBar: true,
							didOpen: (toast) => {
								toast.addEventListener('mouseenter', Swal.stopTimer)
								toast.addEventListener('mouseleave', Swal.resumeTimer)
							}

						})
						Toast.fire({
							icon: 'success',
							title: 'Xóa thành công',

						})
						$scope.initialize()

					}
				});
			}
		} else {
			var maxQuantity = item.productDetail.quantity;
			console.log(maxQuantity);
			// var qty = item.quantity;

			var newValue = $scope.items[index].quantity;
			console.log("New value:", newValue);


			if (newValue > maxQuantity) {
				item.quantity = maxQuantity;
				console.log(item.quantity);
			} else if (newValue < 1 || isNaN(newValue)) {
				
				item.quantity = 1
			} else {
				item.quantity = newValue;
				console.log(newValue);
			}

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
		// The updated value of item.quantity real-time
		var newValue = $scope.items[index].quantity;
		console.log("New value:", newValue);
		$scope.$apply();


	};
	$scope.discount = []
	function setTongTien() {
		var tongTien = 0;
		angular.forEach($scope.items, function (value, key) {
			$http.get("/rest/discount/loadbyproduct/" + value.product.productID).then(resp => {
				value.product.directDiscounts = resp.data
				if (!value.product.directDiscounts.length>0) {
					
					
						if (value.isSelected == true) {
							console.log("e",value.product.price);
							console.log(value.isSelected);
							tongTien += value.product.price * value.quantity;
							
						}
						$scope.tongTien = tongTien;
				}else{

					if (value.product.directDiscounts[0].status=="Đang diễn ra") {
						
						if (value.isSelected == true) {
							console.log(value.isSelected);
							tongTien +=value.product.directDiscounts[0].priceDiscount * value.quantity;
						}
						$scope.tongTien = tongTien;
					} 
					else {
						
						if (value.isSelected == true) {
							console.log(value.isSelected);
							tongTien += value.product.price * value.quantity;
						}
						$scope.tongTien = tongTien;
					}
				}
					
				
			})
		});
		console.log(tongTien);

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
				}
			})
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
				}
			})

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
	}).then(function (response) {
		$scope.provinces = response.data.data.sort(function (a, b) {
			return a.ProvinceName.localeCompare(b.ProvinceName);
			console.log(response.data);
		})
	})
		.catch(function (error) {
			console.error('Error fetching provinces:', error);
		});




	$scope.calculateShipping = function () {
		if ($scope.selectedWard) {
			// Gửi yêu cầu tính tiền ship dựa trên địa chỉ đã chọn
			$scope.dataAddress = {
				// Truyền thông tin địa chỉ vào yêu cầu
				province_id: $scope.selectedProvince.ProvinceID,
				district_id: $scope.selectedDistrict.DistrictID,
				ward_id: $scope.selectedWard.WardID,

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

				method: 'POST',
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
					$scope.shippingFee = shippingCost;
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