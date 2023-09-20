app.controller("favorite-ctrl", function ($scope, $http) {
    $scope.userItemsFavorite = [];

    $scope.begin = function(){
        $http.get('/rest/favorites/loadall')
            .then(function(response) {
                $scope.favorites = response.data;
            })
    }

    $scope.check = function(productID){
        $http.get('/rest/favorites/check/' + productID)
            .then(function(response) {
                $scope.productbyids = response.data;
                console.log($scope.productbyids.favoriteId);
                if(!$scope.productbyids){
                    $http.post('/rest/favorites/' + productID)
                .then(function(response) {
                    console.log("bat thich");
                    $scope.begin();
                })
                .catch(function(error) {
                    console.error('Lỗi khi thêm sản phẩm vào danh sách yêu thích: ' + error);
                });
                    console.log(1);
                }else{
                    $http.delete('/rest/favorites/delete/' + $scope.productbyids.favoriteId)
                .then(function(response) {
                    console.log("tat thich");
                    $scope.begin();
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
            $scope.userItemsFavorite = response.data;
            console.log(hi);
            console.log($scope.userItemsFavorite)
            console.log(response.data)
        })
    }

    $scope.getAllUserFavorite();

    $scope.begin();
});
