app.controller("favorite-ctrl", function ($scope, $http) {
    $scope.userItemsFavorite = [];
    $scope.userRatings = []
    //Linh
    $scope.check = function (productID) {
        $http.get('/rest/favorites/check/' + productID)
            .then(function (response) {
                $scope.productbyids = response.data;
                console.log($scope.productbyids.favoriteId);
                if (!$scope.productbyids) {
                    $http.post('/rest/favorites/' + productID)
                        .then(function (response) {
                            $scope.isFavorite = true;
                            console.log("bat thich");
                            // alert("Đã thích sản phẩm ")
                            Swal.fire({
                                icon: 'success',
                                title: 'Thành công',
                                text: 'Thích sp thành công!'
                            })
                        })
                        .catch(function (error) {
                            console.error('Lỗi khi thêm sản phẩm vào danh sách yêu thích: ' + error);
                        });
                    console.log(1);
                } else {
                    $http.delete('/rest/favorites/delete/' + productID)
                        .then(function (response) {
                            $scope.isFavorite = false;
                            console.log("tat thich");
                            alert("Đã hủy thích sản phẩm")
                        })
                        .catch(function (error) {
                            console.error('Lỗi khi xóa sản phẩm khỏi danh sách yêu thích: ' + error);
                        });
                }
            })
            .catch(function (error) {
                console.error('Error ' + error);
            });
    }


    $scope.getAllUserFavorite = function () {
        $http.get("/rest/favorites/getUserFavorite").then(function (response) {
            $scope.userItemsFavorite = response.data
            console.log(response.data);
        })
    }

    $scope.isFavorite = function (productID) {
        return $scope.userItemsFavorite.some(function (item) {
            return item.product.productID === productID;
        });
    }

    $scope.getAllUserFavorite();

    $scope.getReviewByProduct = function (productID) {
        $http.get("/rest/reviews/loadbyproducts/" + productID).then(resp => {
            $scope.allreviews = resp.data;     
            $scope.countReviews($scope.allreviews);
      
            // Tạo danh sách sao để hiển thị
            $scope.starList = createStarList($scope.averageRating);
            console.log("Sao " + $scope.starList);
            // Tính toán điểm số trung bình
            $scope.ratings = $scope.allreviews.map(function(review) {
                return review.rating;
            });
            $scope.averageRating = calculateAverageRating($scope.ratings);
            // Đếm số lượng đánh giá
            $scope.numRatings = $scope.allreviews.length;
        }).catch(error => {
            console.log("Error", error);
        });
    };

    $scope.saveProductID = function (productID) {
        localStorage.setItem('productID', productID);
        $scope.getReviewByProduct(productID);
    };

    var productID = localStorage.getItem('productID');
    if (productID) {
        $scope.getReviewByProduct(productID);
    } else {
    }

    // Hàm tính toán điểm số trung bình
    function calculateAverageRating(ratings) {
        if (ratings.length === 0) return 0;

        var totalRating = ratings.reduce(function(acc, rating) {
            return acc + rating;
        }, 0);
        return (totalRating / ratings.length).toFixed(1);
    }

    $scope.getStars = function(rating) {
        var stars = [];
        for (var i = 0; i < rating; i++) {
            stars.push(i);
        }
        return stars;
    };

    $scope.reviewCounts = {
        total: 0,
        5: 0,
        4: 0,
        3: 0,
        2: 0,
        1: 0
    };

    $scope.countReviews = function(reviews) {
        $scope.reviewCounts.total = reviews.length;
        reviews.forEach(function(review) {
            $scope.reviewCounts[review.rating] += 1;
        });
    };

    function createStarList(rating) {
        var starList = [];
        for (var i = 0; i < 5; i++) {
            if (rating >= i + 1) {
                starList.push('fa fa-star yellow-star');
            } else if (rating > i) {
                starList.push('fa fa-star-half-o yellow-star');
            } else {
                starList.push('fa fa-star-o yellow-star');
            }
        }
        return starList;
    }
    

    //Linh end

    // quangminh bắt đầu


    // quangminh kết thúc
});
