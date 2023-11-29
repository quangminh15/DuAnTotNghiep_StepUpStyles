app.controller("order-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    $scope.orders = []
    $scope.orderDetail = []
    $scope.filterStaus = []
    $scope.reviewedOrderDetails = []
    $scope.initialize = function () {

        $http.get(`/rest/order/listOrder`)
            .then(resp => {

                $scope.orders = resp.data

                console.log("orders", $scope.orders);

                console.log("1", $scope.orders.shippingAddress)


                $scope.orders.forEach(item => {
                    // $scope.checkReviewd(item.orderId)

                    //    
                    $http.get(`/rest/order/find?orderId=${item.orderId}`)
                        .then(function (response) {
                            $scope.reviewedOrderDetails = response.data;
                        }).catch(function (error) {
                            console.error('Error fetching cart items:', error);
                        });
                    //


                    $http.get(`/rest/order/listOrder/detail?orderid=${item.orderId}`)
                        .then(respone => {
                            item.orderDetail = respone.data
                            $scope.filterByStatusAndCheck(null)
                            console.log("order", $scope.orderDetail);
                            item.orderDetail.forEach(orderdetails => {
                                console.log("id", orderdetails.orderDetailId);
                                $scope.checkrv = false
                                // Kiểm tra nếu orderDetail.orderId tồn tại trong reviewedOrderDetails
                                const isReviewed = $scope.reviewedOrderDetails.some(reviewedItem => reviewedItem.orderDetailId === orderdetails.orderDetailId);
                                orderdetails.hasReviewed = isReviewed;
                                if (isReviewed) {
                                    console.log(`Order ${orderdetails.orderDetailId} đã được đánh giá.`);
                                    // Gán thuộc tính hasReviewed vào orderDetail
                                    $scope.checkrv = true;
                                } else {
                                    console.log(`Order ${orderdetails.orderDetailId} chưa được đánh giá.`);
                                    $scope.checkrv = false;
                                }
                                $http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
                                    orderdetails.productDetail.product.productImages = resp.data;
                                })
                                console.log($scope.checkrv);

                            })

                        })
                });
            })
            .catch(function (error) {
                console.error('Error fetching cart items:', error);
            });

        console.log("orders", $scope.orders);

        console.log("1", $scope.orders.shippingAddress)
        }
        $scope.initialize()

        $scope.updateStatus = function (id, status) {

            $http.put(`/rest/order/updateStatus?id=${id}&status=${status}`)
                .then(respone => {
                    alert("status update")
                    $scope.initialize()
                }).catch(function (error) {
                    console.error('Error update:', error);
                });
        }

        // 
        $scope.filterByStatus = function (status) {

            if (status == null) {
                $scope.filterStaus = $scope.orders;

            } else {
                $scope.filterStaus = $scope.orders.filter(function (order) {

                    return order.orderStatus == status;
                })

            }
        }
        $scope.activeStatus = null
        $scope.filterByStatusAndCheck = function (status) {

            $scope.filterByStatus(status)
            $scope.activeStatus = status;
            if ($scope.filterStaus.length < 1) {
                $scope.checkList = true;
            } else {

                $scope.checkList = false;
            }

        }

        $scope.isActiveStatus = function (status) {
            return $scope.activeStatus === status;
        };

    
    $scope.prodOrder = []
    $scope.showModalReview = function (product) {
        $http.get("/rest/products/" + product.productID)
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
            .then(function (snapshot) {
                return snapshot.ref.getDownloadURL();
            })
            .then(function (downloadURL) {
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
            .catch(function (error) {
                console.error('Lỗi khi tải ảnh lên Firebase:', error);
            });
    }

    function handleImageUpload(inputElement, imageNumber) {
        const file = inputElement.files[0];
        if (file) {
            uploadImageToFirebase(file, imageNumber);
        }
    }

    document.getElementById('image1').addEventListener('change', function () {
        handleImageUpload(this, 1);
    });

    document.getElementById('image2').addEventListener('change', function () {
        handleImageUpload(this, 2);
    });

    document.getElementById('image3').addEventListener('change', function () {
        handleImageUpload(this, 3);
    });
    $scope.rating = 5;
    $scope.selectStar = function (value) {
        if (value) {
            $scope.rating = value;
        } else {
            $scope.rating = 5;
        }
    };
    $scope.resetReviewForm = function () {
        $scope.title = '';
        // Xác định các phần tử sao và lưu trữ chúng trong một biến
        var stars = $('#stars li');

        // Xóa lớp 'selected' khỏi tất cả các phần tử sao
        stars.removeClass('selected');

        // Thêm lớp 'selected' cho 5 phần tử sao ban đầu
        for (var i = 0; i < 5; i++) {
            $(stars[i]).addClass('selected');
        }

        var imageElements = [
            document.getElementById('selectedImage1'),
            document.getElementById('selectedImage2'),
            document.getElementById('selectedImage3')
        ];
        imageElements.forEach(function (imageElement) {
            if (imageElement) {
                imageElement.src = '';
                imageElement.style.display = 'none';
            }
        });
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

        let reviewData = {
            title: $scope.title,
            rating: $scope.rating,
            image1: $scope.review.image1,
            image2: $scope.review.image2,
            image3: $scope.review.image3
        };
        let dta = JSON.stringify(reviewData);
        $http.post("/rest/reviews/create/" + productId, dta)
            .then(function (response) {
                $('#reviewModal').modal('hide');
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
                    title: 'Đã thêm đánh giá thành công',

                })
                $scope.initialize()
                $scope.resetReviewForm();
            }, function (error) {
                console.error('Lỗi khi tạo đánh giá:', error);
            });
    };

    $scope.showModalReviewDetail = function(od){
        // alert(od.orderDetailId)
        // $http.get("/rest/order/reviewDetail/"+od.orderDetailId)
        // .then((res) => {
        //     $scope.dataReview = res.data
        //     console.log("Có dữ liệu hông",$scope.dataReview);
        // }).catch((err) => {
            
        // });
        $('#reviewDetail').modal('show');
    }

    

}])
