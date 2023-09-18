app.controller("favorite-ctrl", function ($scope, $http) {
    $scope.toggleFavorite = function (productId) {
        // Tạo một đối tượng để gửi thông tin sản phẩm và trạng thái thích
        var product = {
            id: productId,
        };

        // var product = $scope.productitems.find(function (p) {
        //     return p.productID === productId;
        // });

        // if (!product) {
        //     return; // Không tìm thấy sản phẩm, thoát
        // }
        
        // Kiểm tra nếu sản phẩm đã được thích
        if (product.liked) {
            // Gửi API để xóa sản phẩm ra khỏi danh sách yêu thích
            var url = '/rest/favorites/delete/' + 4 + '/' + product.id;
            $http.delete(url)
                .then(function (response) {
                    // Xóa thành công, cập nhật trạng thái thích
                    product.liked = false;
                    console.log(response.data);
                    alert("Đã tắt thích sản phẩm");
                })
                .catch(function (error) {
                    // Xử lý lỗi nếu có
                    console.error(error);
                });
        } else {
            // Gửi API để thêm sản phẩm vào danh sách yêu thích
            var url = '/rest/favorites/' + 4 + '/' + product.id;
            $http.post(url)
                .then(function (response) {
                    // Thêm thành công, cập nhật trạng thái thích
                    product.liked = true;
                    console.log(response.data);
                    alert("Đã thích sản phẩm");
                })
                .catch(function (error) {
                    // Xử lý lỗi nếu có
                    console.error(error);
                });
        }
    };
});
