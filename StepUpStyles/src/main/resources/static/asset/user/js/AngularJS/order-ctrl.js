app.controller("order-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    $scope.orders = []
    $scope.orderDetail = []
    $scope.filterStaus = []
    const reviewedOrderDetails = {}
    $scope.initialize = function () {

        $http.get(`/rest/order/listOrder`)
            .then(resp => {

                $scope.orders = resp.data

                console.log("orders", $scope.orders);

                console.log("1", $scope.orders.shippingAddress)

                $scope.orders.sort((a, b) => {

                    return new Date(b.orderDate) - new Date(a.orderDate);
                });

                $scope.orders.forEach(item => {

                    $http.get(`/rest/order/listOrder/detail?orderid=${item.orderId}`)
                        .then(respone => {
                            item.orderDetail = respone.data
                            $scope.filterByStatusAndCheck(null)
                            console.log("order", item.orderDetail);
                            item.orderDetail.forEach(orderdetails => {
                                $http.get(`/rest/order/find?orderDetailId=${orderdetails.orderDetailId}`)
                                    .then(response => {
                                        // Nếu đã được đánh giá
                                        if (response.data === true) {
                                            $http.get(`/rest/order/find?orderDetailId=${orderdetails.orderDetailId}`)
                                            console.log(`OrderDetailId ${orderdetails.orderDetailId} đã được đánh giá.`);
                                            // Thực hiện các hành động khi đã được đánh giá
                                            orderdetails.hasBeenReviewed = true;
                                        } else {
                                            console.log(`OrderDetailId ${orderdetails.orderDetailId} chưa được đánh giá.`);
                                            // Thực hiện các hành động khi chưa được đánh giá
                                            orderdetails.hasBeenReviewed = false;
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error checking if orderDetail is reviewed:', error);
                                    });
                                $http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
                                    orderdetails.productDetail.product.productImages = resp.data;
                                })

                            })

                        })
                    //


                    // $http.get(`/rest/order/listOrder/detail?orderid=${item.orderId}`)
                    //     .then(respone => {
                    //         item.orderDetail = respone.data
                    //         $scope.filterByStatusAndCheck(null)
                    //         console.log("order", $scope.orderDetail);
                    //         item.orderDetail.forEach(orderdetails => {
                    //             console.log("id", orderdetails.orderDetailId);
                    //             $scope.checkrv = false
                    //             // Kiểm tra nếu orderDetail.orderId tồn tại trong reviewedOrderDetails
                    //             const isReviewed = $scope.reviewedOrderDetails.some(reviewedItem => reviewedItem.orderDetailId === orderdetails.orderDetailId);
                    //             orderdetails.hasReviewed = isReviewed;
                    //             if (isReviewed) {
                    //                 console.log(`Order ${orderdetails.orderDetailId} đã được đánh giá.`);
                    //                 // Gán thuộc tính hasReviewed vào orderDetail
                    //                 $scope.checkrv = true;
                    //             } else {
                    //                 console.log(`Order ${orderdetails.orderDetailId} chưa được đánh giá.`);
                    //                 $scope.checkrv = false;
                    //             }
                    //             console.log($scope.checkrv);
                    //             $http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
                    //                 orderdetails.productDetail.product.productImages = resp.data;
                    //             })

                    //         })

                    //     })
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

        Swal.fire({
            title: "Xác nhận hủy đơn hàng",
            text: "Bạn có chắc muốn hủy đơn hàng này",
            icon: "info",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Hủy Đơn",
            cancelButtonText: "Đóng"
        }).then((result) => {
            if (result.isConfirmed) {
                $http.put(`/rest/order/updateStatus?id=${id}&status=${status}`)
                    .then(respone => {
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
                            title: 'Đơn hàng của bạn đã được hủy',

                        })
                        $scope.initialize()
                    }).catch(function (error) {
                        console.error('Error update:', error);
                    });

            }

        })

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
    $scope.imageSelected = [false, false, false]
    $scope.resetReviewForm = function () {
        $scope.title = null;
        $scope.rating = 5;
        document.getElementById('selectedImage1').src = ''
        document.getElementById('selectedImage2').src = ''
        document.getElementById('selectedImage3').src = ''
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
        imageElements.forEach(function (imageElement, index) {
            if (imageElement) {
                imageElement.src = '';
                imageElement.style.display = 'none';
                $scope.imageSelected[index] = false;
            }
        });
        document.getElementById('label2').style.display = 'none';
        document.getElementById('label3').style.display = 'none';
        document.getElementById('image2').style.display = 'none';
        document.getElementById('image3').style.display = 'none';
        $scope.review.image1 = '';
        $scope.review.image2 = '';
        $scope.review.image3 = '';
        $scope.imageSelected = [false, false, false];
    };
    // Hàm tạo đánh giá

    $scope.prodOrder = []
    $scope.showModalReview = function (orderDetail) {
        $scope.nameProduct = orderDetail.productDetail.product.productName
        $scope.sizeProduct = orderDetail.productDetail.size.sizeNumber
        $scope.colorProduct = orderDetail.productDetail.color.colorName
        $http.get("/rest/productimages/loadbyproduct/" + orderDetail.productDetail.product.productID).then(resp => {
            $scope.prodOrder.image = resp.data;
        })
        $scope.createReview = function () {
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
                image3: $scope.review.image3,
                orderDetailId: orderDetail.orderDetailId
            };
            let dta = JSON.stringify(reviewData);
            $http.post("/rest/reviews/create/" + orderDetail.productDetail.product.productID + "/" + orderDetail.orderDetailId, dta)
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
        $('#reviewModal').modal('show');
    }

    $scope.reviewedOrder = []
    $scope.showModalReviewDetail = function (od) {
        $http.get("/rest/order/reviewDetail/" + od.orderDetailId).then(resp => {
            $scope.reviewedOrder = resp.data;
            $http.get("/rest/productimages/loadbyproduct/" + $scope.reviewedOrder.product.productID).then(resp => {
                $scope.reviewedOrder.product.image = resp.data;
            })
        })
        $('#reviewDetail').modal('show');
    }
}])
