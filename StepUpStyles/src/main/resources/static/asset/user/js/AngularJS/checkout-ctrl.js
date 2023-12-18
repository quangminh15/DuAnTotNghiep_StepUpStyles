
app.controller("checkout-ctrl", ['$scope', '$http', '$timeout', '$location', function ($scope, $http, $timeout, $location) {
	$scope.address = []
	$scope.cartDetails = []
	$scope.discouted = 0

	$scope.selectedVoucher = {}

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

				$scope.getAddressToShippingFee($scope.addressDefault.province, $scope.addressDefault.district, $scope.addressDefault.ward)

			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});

		$http.get(`/rest/address`)
			.then(response => {
				$scope.check = true
				$scope.address = response.data

				if (Array.isArray(response.data) && response.data.length === 0) {

					$scope.check = false
					$('#ModalAddress').modal('show');
				} else {
					$scope.check = true
					// This will execute for non-empty arrays or any other non-null values.
				}



			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});

			$scope.checkEdit=false
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
			$scope.cartIs.forEach(cartDetail => {
				$http.get("/rest/productimages/loadbyproduct/" + cartDetail.product.productID).then(resp => {
					cartDetail.product.productImages = resp.data;
					console.log("images", cartDetail.product.productImages);
				})
				$http.get("/rest/discount/loadbyproduct/" + cartDetail.product.productID).then(resp => {
					cartDetail.product.directDiscounts = resp.data.filter(directDiscounts => !directDiscounts.deleted);

				})
			})
			setTongTien()
			localStorage.removeItem('selectedItems');
		}
	};
	$scope.discount = []
	function setTongTien() {
		var tongTien = 0;
		angular.forEach($scope.cartIs, function (value, key) {
			$http.get("/rest/discount/loadbyproduct/" + value.product.productID).then(resp => {
				value.product.directDiscounts = resp.data
				if (!value.product.directDiscounts.length > 0) {


					if (value.isSelected == true) {
						console.log("e", value.product.price);
						console.log(value.isSelected);
						tongTien += value.product.price * value.quantity;

					}
					$scope.tongTien = tongTien;
				} else {

					if (value.product.directDiscounts[0].status == "Đang diễn ra") {

						if (value.isSelected == true) {
							console.log(value.isSelected);
							tongTien += value.product.directDiscounts[0].priceDiscount * value.quantity;
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

		// tongTien += value.product.price * value.quantity;


		$scope.tongTien = tongTien;
	}
	$scope.delete = function (id) {
		$http.delete(`/rest/address/delete?id=${id}`).then(function (respone) {
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
				title: 'Xóa thành công',

			})
			$('#ModalAddress').modal('hide');
					$('#ModalAddress1').modal('show');
			$scope.initialize()
		})
			.catch(function (error) {
				console.error('Failed to delete:', error);
			});
	}

	$scope.sendDataToJava = function () {

		const voucherUseId = $scope.selectedVoucher ? $scope.selectedVoucher.voucherUseId : 0;
		$http({
			method: 'POST',
			url: `/rest/order/receiveCartData?initialPrice=${$scope.tongTien}&fee=${$scope.shippingFee}&addressId=${$scope.addressDefault.shippingAddressId}&discountPrice=${$scope.discouted}&voucherUseId=${voucherUseId}`,
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
		localStorage.setItem('totalAmount', JSON.stringify(($scope.tongTien-$scope.discouted) + $scope.shippingFee));

		window.location.href = '/pay-cod-success'
	};
	$scope.loadTongTienFromLocal = function () {
		$scope.total = localStorage.getItem('totalAmount');

	};
	$scope.loadTongTienFromLocal()

	$scope.getDataPayment = function () {
		const voucherUseId = $scope.selectedVoucher ? $scope.selectedVoucher.voucherUseId : 0;
		$http({
			method: 'POST',
			url: `/payment/getdata?initialPrice=${$scope.tongTien}&fee=${$scope.shippingFee}&addressId=${$scope.addressDefault.shippingAddressId}&discountPrice=${$scope.discouted}&voucherUseId=${voucherUseId}`,
			data: $scope.cartIs, // Assuming $scope.cartIs is an array
			headers: { 'Content-Type': 'application/json' }
		})
			.then(function (response) {
				console.log('done:', response.data);

			})
			.catch(function (error) {
				console.error('Error:', error);
			});
			localStorage.setItem('totalAmount', JSON.stringify(($scope.tongTien-$scope.discouted) + $scope.shippingFee))
	}

	$scope.removeDataPayment = function () {
		$http({
			method: 'GET',
			url: `/payment/removedata`,
			headers: { 'Content-Type': 'application/json' }
		})
			.then(function (response) {
				localStorage.removeItem('selectedItems');
				console.log("remove");
			})
			.catch(function (error) {
				console.error('Error:', error);
			});
	}

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
			cartDetails: cartDetails,

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
	$scope.initialize()

	
	
	$scope.checkButton=function(io){
		$scope.checkEdit = io
	}
	// clearForm
	$scope.reset = function () {
		$scope.form = {

			defaultAddress: false
		}
		$scope.checkEdit=false
		$('#ModalAddress').modal('show');
	}

	$scope.edit = function (addr) {
		$scope.checkEdit=true
		
		console.log(addr.province);
		if (addr) {
			

			$('#ModalAddress').modal('show');
			$scope.form = angular.copy(addr);
			


			// $http({
			// 	method: 'GET',
			// 	url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/province',
			// 	headers: {
			// 		'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
			// 	}
			// }).then(function successCallback(response) {
			// 	$scope.province = response.data.data;
			// 	// console.log($scope.province);
			// 	$scope.current_province = $scope.province[$scope.index_of_province(addr.province)]

			// 	// $scope.form.selectedProvince = $scope.current_province

			// 	console.log("Selected Province:", $scope.form.selectedProvince);

			// 	$http({
			// 		method: 'GET',
			// 		url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=' + $scope.current_province.ProvinceID,
			// 		headers: {
			// 			'Token': 'da60559e-557a-11ee-af43-6ead57e9219a',
			// 			'ShopId': '4551956'
			// 		}
			// 	}).then(function successCallback(response) {
			// 		$scope.district = response.data.data;
			// 		console.log($scope.district);
			// 		$scope.current_district = $scope.district[$scope.index_of_district(addr.district)]
			// 		$scope.form.selectedDistrict = $scope.current_district
			// 		$http({
			// 			method: 'GET',
			// 			url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + $scope.current_district.DistrictID,
			// 			headers: {
			// 				'Token': 'da60559e-557a-11ee-af43-6ead57e9219a'
			// 			}
			// 		}).then(function successCallback(response) {
			// 			$scope.ward = response.data.data
			// 			$scope.current_ward = $scope.ward[$scope.index_of_ward(addr.ward)]
			// 			$scope.form.selectedWard = $scope.current_ward
			// 		})
			// 	})
			// })
		}
		else {
			return
		}
	}


	$scope.update = function () {
		var object = $scope.form

		var phonePattern = /(84|0[3|5|7|8|9])+([0-9]{8})\b/;
		if (!object.nameReceiver) {
			$scope.toast("Vui Lòng nhập họ và tên")
			$scope.checkName = false
		} else if (!object.phoneReceiver) {
			$scope.toast("Vui Lòng nhập số điện thoại")
			$scope.checkName = true
			$scope.checkPhone = false
		} else if (!phonePattern.test(object.phoneReceiver)) {
			$scope.toast("Số điện thoại không hợp lệ");
			$scope.checkPhone = true
			$scope.checkParttenPhone = false
		} else if (!$scope.form.selectedProvince) {
			$scope.checkParttenPhone = true
			$scope.toast("Chưa chọn tỉnh");
		}
		else if (!$scope.form.selectedDistrict) {
			// $scope.checkParttenPhone=true
			$scope.toast("Chưa chọn huyện");
		}
		else if (!$scope.form.selectedWard) {
			// $scope.checkParttenPhone=true
			$scope.toast("Chưa chọn xã");
		} else if (!object.addressDetails) {
			$scope.toast("Vui lòng nhập Địa chỉ cụ thể");

			$scope.checkAddressDetail = false
		} else {
			$scope.checkAddressDetail = true

			// Gửi yêu cầu tính tiền ship dựa trên địa chỉ đã chọn
			$scope.dataAddress = {
				// Truyền thông tin địa chỉ vào yêu cầu
				province_name: $scope.form.selectedProvince.ProvinceName,
				district_name: $scope.form.selectedDistrict.DistrictName,
				ward_name: $scope.form.selectedWard.WardName,
				// Các thông tin khác cần thiết
			}
		


		
		object.province = $scope.dataAddress.province_name
		object.district = $scope.dataAddress.district_name
		object.ward = $scope.dataAddress.ward_name
		
		$http.put('/rest/address/update', object)
			.then(resp => {
				console.log("updated");
				$scope.initialize();
				$('#ModalAddress').modal('hide');
				$('#ModalAddress1').modal('show');
				// $scope.form = angular.copy(addr);
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
					title: 'Cập nhật địa chỉ thành công',

				})
			}).catch(function (error) {
				console.error('Error fetching cart items:', error);

			});
		}

	}

	$scope.updateDefault = function (id) {

		$http.put(`/rest/address/updateDefault?shipid=${id}`)
			.then(resp => {
				console.log("shipaddres", id);
				$scope.initialize();
			}).catch(function (error) {
				console.error('Error fetching cart items:', error);

			});

	}
	$scope.toast = function (title) {
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
			title: title,

		})


	}
	$scope.hideModal = function() {
		$('#ModalAddress1').modal('hide');
		$('#ModalAddress').modal('hide');
	};
	$scope.checkName = true
	$scope.checkPhone = true
	$scope.checkParttenPhone = true
	$scope.checkAddressDetail = true
	$scope.createAddress = function (checked, name, phone, detail) {
		var phonePattern = /(84|0[3|5|7|8|9])+([0-9]{8})\b/;
		if (!name) {
			$scope.toast("Vui Lòng nhập họ và tên")
			$scope.checkName = false
		} else if (!phone) {
			$scope.toast("Vui Lòng nhập số điện thoại")
			$scope.checkName = true
			$scope.checkPhone = false
		} else if (!phonePattern.test(phone)) {
			$scope.toast("Số điện thoại không hợp lệ");
			$scope.checkPhone = true
			$scope.checkParttenPhone = false
		} else if (!$scope.form.selectedProvince) {
			$scope.checkParttenPhone = true
			$scope.toast("Chưa chọn tỉnh");
		}
		else if (!$scope.form.selectedDistrict) {
			// $scope.checkParttenPhone=true
			$scope.toast("Chưa chọn huyện");
		}
		else if (!$scope.form.selectedWard) {
			// $scope.checkParttenPhone=true
			$scope.toast("Chưa chọn xã");
		} else if (!detail) {
			$scope.toast("Vui lòng nhập Địa chỉ cụ thể");

			$scope.checkAddressDetail = false
		} else {
			$scope.checkAddressDetail = true

			// Gửi yêu cầu tính tiền ship dựa trên địa chỉ đã chọn
			$scope.dataAddress = {
				// Truyền thông tin địa chỉ vào yêu cầu
				province_name: $scope.form.selectedProvince.ProvinceName,
				district_name: $scope.form.selectedDistrict.DistrictName,
				ward_name: $scope.form.selectedWard.WardName,
				// Các thông tin khác cần thiết
			}


			if ($scope.addressDefault.length < 1) {

				checked = true
			}$scope.checkParttenPhone = true

			console.log($scope.dataAddress);
			$http.post(`/rest/address/create?defaultCheck=${checked}&province=${$scope.dataAddress.province_name}&district=${$scope.dataAddress.district_name}&ward=${$scope.dataAddress.ward_name}&addressDtail=${detail}&nameReceiver=${name}&phoneReceiver=${phone}`)
				.then(resp => {
					console.log("add");
					
					$('#ModalAddress').modal('hide');
					$('#ModalAddress1').modal('show');
					$scope.initialize();
					
					
					$scope.reset()
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
						title: 'Thêm địa chỉ thành công',

					})
					
					
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

	//select voucher
	$scope.selectedVoucher = null;
	$scope.showVoucher = function (item) {

		$http.get(`/rest/voucher/getIdVoucher/` + item).then(function (response) {
			$scope.vocherSelect = response.data
			console.log($scope.vocherSelect);
		}).catch(function (error) {
			console.error('Error calculating shipping:', error);
		});
		console.log("item", item);
		$scope.selectedVoucher = item
		console.log("Voucher selected:", item); // Hoặc thực hiện các thao tác khác với giá trị item được chọn
		return $scope.selectedVoucher
	};

	$scope.caculatorDiscount = function (item) {
		var discountRate = 0
		var maxOrder = 0;
		$scope.selectedVoucher = item
		if ($scope.selectedVoucher) {
			discountRate = $scope.selectedVoucher.voucher.discountAmount / 100;
			maxOrder = $scope.selectedVoucher.voucher.miniOrder;
		} else {
			discountRate = 0;
			miniOrder = 0;
		}
		
		$scope.discouted = $scope.tongTien * discountRate;

		if($scope.discouted >= maxOrder) {
			$scope.discouted = maxOrder;
			
		}else{
			$scope.discouted = $scope.tongTien * discountRate;
			
		}
		

	}
	$scope.caculatorDiscount()
	//tien start
	$scope.voucherUseTrue = [];
	$scope.listOrder = [];

	$scope.filteredVouchers = [];

	$scope.getVoucher = function () {
		$http.get("/user/Idprofile").then((resp) => {
			var userId = resp.data;
			$http.get("/user/" + userId).then(userResp => {
				console.log(userId);
				var fullUserData = userResp.data;
				// Thực hiện HTTP GET request đến API
				$http.get('/rest/voucherUse/getTrue/' + userId)
					.then(function (response) {
						// Xử lý dữ liệu trả về từ API
						$scope.voucherUseTrue = response.data;
						console.log($scope.voucherUseTrue);

						$scope.voucherUseTrue.forEach(function (item) {

							item.formattedStartDate = formatDate(item.voucher.dateStart);
							item.formattedEndDate = formatDate(item.voucher.dateEnd);
							item.isExpired = isVoucherExpired(item.voucher.dateEnd) || $scope.tongTien < item.voucher.total;
							$scope.voucherUseTrue.sort(function (a, b) {
								return a.isExpired - b.isExpired;
							});
							console.log($scope.tongtien);
							console.log(item.voucher.total)
						});
						function formatDate(startDate) {
							// Parse the input date string
							const inputDate = new Date(startDate);

							// Format options
							const options = {
								weekday: 'long', // 'long' for the full weekday name
								day: '2-digit',
								month: '2-digit',
								year: 'numeric',
								// hour: '2-digit',
								// minute: '2-digit',
								// second: '2-digit',
								hour12: false, // 24-hour format
								timeZone: 'Asia/Ho_Chi_Minh', // Time zone
							};

							// Format the date using Intl.DateTimeFormat
							const formattedDate = new Intl.DateTimeFormat('vi-VN', options).format(inputDate);

							return formattedDate;
						}

						function isVoucherExpired(endDate) {
							// Phân tích chuỗi ngày kết thúc
							const voucherEndDate = new Date(endDate);

							// Lấy ngày hiện tại
							const currentDate = new Date();

							// So sánh ngày kết thúc với ngày hiện tại
							return voucherEndDate < currentDate;
						}

					})

			})
		})


	};

	$scope.formatToVND = function (amount) {
		// Logic để định dạng số amount sang định dạng VND
		return amount.toLocaleString("vi-VN", {
			style: "currency",
			currency: "VND",
		});
	};

	$scope.getVoucher();

	$scope.openRecycleBinForm = function () {
		// Reset searchKeyword
		searchValue = '';
		$('#recycleBinModal').modal('show');
	};

	//khi an button huy thi se set ve null
	$scope.huyChonVoucher = function () {
		// Xóa voucher đã chọn
		$scope.selectedVoucher = null;
		$scope.discouted = 0;

		//dong model
		$('#recycleBinModal').modal('hide');
	}

	//tien end
}])