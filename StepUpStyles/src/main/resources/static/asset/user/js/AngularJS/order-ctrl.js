app.controller("order-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
	$scope.orders = []
	$scope.orderDetail = []
	$scope.initialize = function () {

		$http.get(`/rest/order/listOrder`)
			.then(resp => {

				$scope.orders = resp.data

				console.log("orders", $scope.orders);

				console.log("1", $scope.orders.shippingAddress)


				$scope.orders.forEach(item => {


					$http.get(`/rest/order/listOrder/detail?orderid=${item.orderId}`)
						.then(respone => {
							$scope.orderDetail = respone.data
							console.log("order", $scope.orderDetail);

							$scope.orderDetail.forEach(orderdetails => {
								console.log("s1", orderdetails.productDetail.product.productID);
								$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
									orderdetails.image = resp.data;
									console.log("s2", orderdetails.image);

								})

							})
						})
				});
			})
			.catch(function (error) {
				console.error('Error fetching cart items:', error);
			});




	}
	$scope.prodOrder = []
	$scope.showModalReview = function (productID) {
        $http.get("/rest/products/"+productID)
        .then((res) => {
            $scope.prodOrder = res.data;           
                $http.get("/rest/productimages/loadbyproduct/" + $scope.prodOrder.productID).then(resp => {
                    $scope.prodOrder.image = resp.data;
                })
        }).catch((err) => {
            console.log("Error: ", err);
        });
		$('#reviewModal').modal('show');
	}

	$scope.review = {
        image1: '',
        image2: '',
        image3: ''
    };

    function uploadImageToFirebase(file, imageNumber) {
        const storageRef = firebase.storage().ref();
        const imageRef = storageRef.child('reviews/' + file.name);

        // Thực hiện tải lên
        imageRef.put(file)
            .then(function(snapshot) {
                return snapshot.ref.getDownloadURL();
            })
            .then(function(downloadURL) {
                switch (imageNumber) {
                    case 1:
                        $scope.review.image1 = downloadURL;
                        break;
                    case 2:
                        $scope.review.image2 = downloadURL;
                        break;
                    case 3:
                        $scope.review.image3 = downloadURL;
                        break;
                    default:
                        break;
                }
            })
            .catch(function(error) {
                console.error('Lỗi khi tải ảnh lên Firebase:', error);
            });
    }

    function handleImageUpload(inputElement, imageNumber) {
        const file = inputElement.files[0];
        if (file) {
            uploadImageToFirebase(file, imageNumber);
        }
    }

    document.getElementById('image1').addEventListener('change', function() {
        handleImageUpload(this, 1);
    });

    document.getElementById('image2').addEventListener('change', function() {
        handleImageUpload(this, 2);
    });

    document.getElementById('image3').addEventListener('change', function() {
        handleImageUpload(this, 3);
    });
	$scope.rating = 5;
    $scope.selectStar = function(value) {
        if (value) {
            $scope.rating = value;
            alert($scope.rating)
        } else {
            $scope.rating = 5;
        }
    };
	// Hàm tạo đánh giá
    $scope.createReview = function (productId) {
        if ($scope.review.image1 === '') {
            $scope.review.image1 = null;
        }
        if ($scope.review.image2 === '') {
            $scope.review.image2 = null;
        }
        if ($scope.review.image3 === '') {
            $scope.review.image3 = null;
        }
        
        var reviewData = {
            title: $scope.title,
            rating: $scope.rating,
            image1: $scope.review.image1,
			image2: $scope.review.image2,
			image3: $scope.review.image3
        };
        alert(productId)

        // Gọi API để tạo đánh giá
        $http.post("/rest/reviews/create/"+productId, reviewData)
            .then(function (response) {
                
                console.log(response.data);
                $('#reviewModal').modal('hide');
                alert("Tạo đánh giá thành công");
            })
            .catch(function (error) {
                console.error('Lỗi khi tạo đánh giá:', error);
            });
    };

	$scope.initialize()
}])