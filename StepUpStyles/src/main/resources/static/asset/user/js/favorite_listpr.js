app.controller("favorite-list-ctrl", function ($scope, $http) {
    $scope.userItemsFavorite = [];

    $scope.showDeleteConfirmationModal = function(productID) {
        $scope.productToDeleteID = productID;
        $('#confirmDeleteModal').modal('show');
    }

    $scope.deleteFavoriteProduct = function() {
        var productIDToDelete = $scope.productToDeleteID;
        $http.delete('/rest/favorites/delete/' + productIDToDelete)
            .then(function(response) {
                console.log("Đã xóa sản phẩm yêu thích");
                $scope.getAllUserFavorite();
            })
            .catch(function(error) {
                console.error('Lỗi khi xóa sản phẩm yêu thích: ' + error);
            });
        $('#confirmDeleteModal').modal('hide');
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

});
