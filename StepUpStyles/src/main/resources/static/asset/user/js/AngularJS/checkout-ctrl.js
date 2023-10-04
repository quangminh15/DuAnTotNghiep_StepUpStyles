app.controller("checkout-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
	$scope.address = []
	$scope.cartDetails = []


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

		$http.get(`/rest/address/default`)
			.then(resp => {
				$scope.addressDefault = resp.data
				console.log(resp.data);
				$scope.getAddressToShippingFee($scope.addressDefault.province, $scope.addressDefault.district, $scope.addressDefault.ward)

			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});

		$http.get(`/rest/address`)
			.then(response => {
				$scope.check = true
				$scope.address = response.data
				console.log(response.data);
				if (Array.isArray(response.data) && response.data.length === 0) {
					console.log(1); // This will execute for an empty array.
					$scope.check = false
					$('#ModalAddress').modal('show');
				} else {
					$scope.check = true
					console.log(2); // This will execute for non-empty arrays or any other non-null values.
				}



			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});
			
			
	}
	$scope.loadFromLocalStorage = function () {
		var storedItems = localStorage.getItem('selectedItems');
		if (storedItems) {
			var selectedItems = JSON.parse(storedItems);
			$scope.cartIs = selectedItems;

			// Update the isSelected property of items based on the loaded data
			$scope.cartIs.forEach(function (item) {
				item.isSelected = selectedItems.some(function (selectedItem) {
					return selectedItem.id === item.id; // Adjust the condition as per your data structure
				});
			});
			setTongTien()
		}
	};
	function setTongTien() {
        var tongTien = 0;
        angular.forEach($scope.cartIs, function (value, key) {
			
            tongTien += value.product.price * value.quantity;
            
        });
		console.log(tongTien);
        $scope.tongTien = tongTien;
    }
	$scope.sendDataToJava = function () {
		$http({
			method: 'POST',
			url: `/rest/order/receiveCartData?initialPrice=${$scope.tongTien}&fee=${$scope.shippingFee}&addressId=${$scope.addressDefault.shippingAddressId}`,
			data: $scope.cartIs, // Assuming $scope.cartIs is an array
			headers: { 'Content-Type': 'application/json' }
		})
		.then(function (response) {
			console.log('Order created:', response.data);
			localStorage.removeItem('selectedItems');
		})
		.catch(function (error) {
			console.error('Error:', error);
		});
	};

	// Function to create an order
	$scope.createOrder = function () {
		// Create an order object with the order details
		if (!$scope.cartIs || !$scope.cartIs.length) {
			console.error('Error: cartIs is null or empty.');
			return;
		} else
			console.log($scope.cartIs);
		const cartDetails = Array.from($scope.cartIs);
		const order = {

			deliveryStatus: null,
			initialPrice: null,
			orderDate: null,
			paymentStatus: null,
			shippingFee: $scope.shippingFee,
			totalAmount: 666,
			discountPrice: 0,
			shippingAddress: $scope.addressDefault,
			cartDetails: cartDetails
		};
		console.log($scope.cartDetails);
		//Send the order object to your Spring Boot service
		$http.post('/rest/order/createOrder', order)
			.then(function (response) {

				console.log('Order created:', response.data);

				localStorage.removeItem('selectedItems');
			})
			.catch(function (error) {
				console.error('Error:', error);

			});
	};

	// Call this function on page load or wherever it's needed in your controller.
	$scope.loadFromLocalStorage();

	$scope.getAddressToShippingFee = function (p, d, w) {
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
			console.log($scope.current_province);
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
					console.log($scope.ward);
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
						alert('Tiền ship là: ' + Math.floor(shippingCost));
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
	$scope.initialize()

	// clearForm
	$scope.reset = function () {
		$scope.form = {

			checked: false
		}
		$scope.current_province = {}
	}

	$scope.edit = function (addr) {
		//console.log(addr.province);
		if (addr) {


			$('#ModalAddress').modal('show');
			$scope.form = angular.copy(addr);


			$http({
				method: 'GET',
				url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/province',
				headers: {
					'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
				}
			}).then(function successCallback(response) {
				$scope.province = response.data.data;
				// console.log($scope.province);
				$scope.current_province = $scope.province[$scope.index_of_province(addr.province)]

				// $scope.form.selectedProvince = $scope.current_province

				console.log("Selected Province:", $scope.form.selectedProvince);

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
					$scope.current_district = $scope.district[$scope.index_of_district(addr.district)]
					$scope.form.selectedDistrict = $scope.current_district
					$http({
						method: 'GET',
						url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + $scope.current_district.DistrictID,
						headers: {
							'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
						}
					}).then(function successCallback(response) {
						$scope.ward = response.data.data
						$scope.current_ward = $scope.ward[$scope.index_of_ward(addr.ward)]
						$scope.form.selectedWard = $scope.current_ward
					})
				})
			})
		}
		else {
			return
		}
	}

	$scope.updateDefault = function (id) {

		$http.put(`/rest/address/updateDefault?shipid=${id}`)
			.then(resp => {
				console.log(id);
				$scope.initialize();
			}).catch(function (error) {
				console.error('Error fetching cart items:', error);

			});

	}
	$scope.createAddress = function (checked, name, phone, detail) {


		if (!$scope.form.selectedWard || !$scope.form.nameReceiver || !$scope.form.phone || !$scope.form.addressDetails) {
			alert("vui longf nhap day du thong tin")
		} else {
			// Gửi yêu cầu tính tiền ship dựa trên địa chỉ đã chọn
			$scope.dataAddress = {
				// Truyền thông tin địa chỉ vào yêu cầu
				province_name: $scope.form.selectedProvince.ProvinceName,
				district_name: $scope.form.selectedDistrict.DistrictName,
				ward_name: $scope.form.selectedWard.WardName,
				// Các thông tin khác cần thiết
			}
			$http.post(`/rest/address/create?defaultCheck=${$scope.form.checked}&province=${$scope.dataAddress.province_name}&district=${$scope.dataAddress.district_name}&ward=${$scope.dataAddress.ward_name}&addressDtail=${detail}&nameReceiver=${name}&phoneReceiver=${phone}`)
				.then(resp => {
					console.log("add");
					$scope.reset()
					$scope.initialize()
				}).catch(function (error) {
					console.error('Error fetching districts:', error);
				});

		}
	}

	//address load
	$scope.loadDistricts = function () {
		console.log('loadDistricts function called');
		if ($scope.form.selectedProvince) {
			$http({
				method: 'GET',
				url: `https://online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=${$scope.form.selectedProvince.ProvinceID}`,
				headers: {
					'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
				}
			})
				.then(function (response) {
					console.log(response.data.data);
					$scope.form.selectedProvince.Districts = response.data.data;

				})
				.catch(function (error) {
					console.error('Error fetching districts:', error);
				});
		} else {
			$scope.form.selectedDistrict = null;
			$scope.form.selectedWard = null;
		}
	};

	$scope.loadWards = function () {
		if ($scope.form.selectedDistrict) {
			$http({
				method: 'GET',
				url: `https://online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=${$scope.form.selectedDistrict.DistrictID}`,
				headers: {
					'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
				}
			})

				.then(function (response) {
					console.log($scope.form.selectedDistrict.DistrictID);
					$scope.form.selectedDistrict.Wards = response.data.data;
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
				province_id: $scope.form.selectedProvince.ProvinceID,
				district_id: $scope.form.selectedDistrict.DistrictID,
				ward_id: $scope.form.selectedWard.WardID,
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
					$scope.shippingFee = shippingCost;
				})
				.catch(function (error) {
					console.error('Error calculating shipping:', error);
				});
		} else {
			alert('Vui lòng chọn địa chỉ đầy đủ để tính tiền ship.');
		}
	};
}])