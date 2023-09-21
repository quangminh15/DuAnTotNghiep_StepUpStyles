app.controller("checkout-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
$scope.address=[]

    $scope.initialize = function () {
       
        $http.get(`/rest/address/default`)
        .then(resp=>{
            $scope.addressDefault=resp.data
            console.log(resp.data);
    })
    .catch(function (error) {
        console.error('Error fetching cart items:', error);
    });

    $http.get(`/rest/address`)
    .then(response=>{
		$scope.check =true
		$scope.address=response.data
        console.log(response.data);
        if (Array.isArray(response.data) && response.data.length === 0) {
			console.log(1); // This will execute for an empty array.
			$scope.check=false
			$('#ModalAddress').modal('show');
		  } else {
			$scope.check=true
			console.log(2); // This will execute for non-empty arrays or any other non-null values.
		  }
	
       
			
})
.catch(function (error) {
    console.error('Error fetching cart items:', error);
});
	}
    $scope.initialize()
    
	
    $scope.updateDefault=function(id){

        $http.put(`/rest/address/updateDefault?shipid=${id}`)
        .then(resp=>{
            console.log(id);
            $scope.initialize();
        }).catch(function (error) {
            console.error('Error fetching cart items:', error);
            
        });
        
    }
	$scope.createAddress=function(checked,name,phone,detail){
		if (!$scope.selectedWard ||!$scope.name||!$scope.phone||!$scope.addressDetail) {
			alert("vui longf nhap day du thong tin")
		}else{
		// Gửi yêu cầu tính tiền ship dựa trên địa chỉ đã chọn
		$scope.dataAddress= {
		  // Truyền thông tin địa chỉ vào yêu cầu
		  province_name: $scope.selectedProvince.ProvinceName,
		  district_name: $scope.selectedDistrict.DistrictName,
		  ward_name: $scope.selectedWard.WardName,
		  // Các thông tin khác cần thiết
		}
		$http.post(`/rest/address/create?defaultCheck=${checked}&province=${$scope.dataAddress.province_name}&district=${$scope.dataAddress.district_name}&ward=${$scope.dataAddress.ward_name}&addressDtail=${detail}&nameReceiver=${name}&phoneReceiver=${phone}`)
		.then(resp=>{
			console.log("add");
			$scope.initialize()
		}).catch(function (error) {
			console.error('Error fetching districts:', error);
		  });

	}
}

    //address load
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
}])