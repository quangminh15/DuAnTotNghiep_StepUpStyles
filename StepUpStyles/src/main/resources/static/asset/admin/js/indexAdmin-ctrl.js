app.controller("indexAdmin-ctrl", function($scope, $http) {
    $scope.totalQuantity = 0;

    //Tính tổng số lượng sản phẩm sản phẩm
    function SumQuantity(productdetailitems) {
        let total = 0;
        for (let i = 0; i < productdetailitems.length; i++) {
            total += productdetailitems[i].quantity;
        }
        return total;
    }

    // Load danh sách sản phẩm và tính tổng quantity
    $http.get("/rest/productdetails/loadall").then(resp => {
        $scope.productdetailitems = resp.data;

        // Tính tổng quantity từ danh sách sản phẩm
        $scope.totalQuantity = SumQuantity(resp.data);
    });
});
