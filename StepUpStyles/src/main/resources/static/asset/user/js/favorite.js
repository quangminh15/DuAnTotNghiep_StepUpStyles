app.controller("favorite-ctrl", function($scope, $http) {
	$scope.userItemsFavorite = [];
//Linh
    $scope.check = function(productID){
        $http.get('/rest/favorites/check/' + productID)
            .then(function(response) {
                $scope.productbyids = response.data;
                console.log($scope.productbyids.favoriteId);
                if(!$scope.productbyids){
                    $http.post('/rest/favorites/' + productID)
                .then(function(response) {
                    $scope.isFavorite = true;
                    console.log("bat thich");
                    // alert("Đã thích sản phẩm ")
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công',
                        text: 'Thích sp thành công!'
                    })
                })
                .catch(function(error) {
                    console.error('Lỗi khi thêm sản phẩm vào danh sách yêu thích: ' + error);
                });
                    console.log(1);
                }else{
                    $http.delete('/rest/favorites/delete/' + productID)
                .then(function(response) {
                    $scope.isFavorite = false;
                    console.log("tat thich");
                    alert("Đã hủy thích sản phẩm")
                })
                .catch(function(error) {
                    console.error('Lỗi khi xóa sản phẩm khỏi danh sách yêu thích: ' + error);
                });
                }
            })
            .catch(function(error) {
                console.error('Error ' + error);
            });
    }
    

    $scope.getAllUserFavorite = function(){
        $http.get("/rest/favorites/getUserFavorite").then(function(response){
            $scope.userItemsFavorite = response.data
            console.log(response.data);
        })
    }

	$scope.isFavorite = function(productID) {
		return $scope.userItemsFavorite.some(function(item) {
			return item.product.productID === productID;
		});
	}

    $scope.getAllUserFavorite();

    $scope.getReviewByProduct = function(productID) {
			$http.get("/rest/reviews/loadbyproducts/" + productID).then(resp => {
				$scope.allreviews = resp.data;
                console.log(resp.data);
			}).catch(error => {
                console.log("Error", error);
			});
	};
    $scope.getReviewByProduct(3);
    
    //Linh end

	// quangminh bắt đầu


	// quangminh kết thúc
});
