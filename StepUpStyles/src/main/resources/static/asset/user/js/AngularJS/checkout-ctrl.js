app.controller("checkout-ctrl", ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {


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
    .then(resp=>{
        $scope.address=resp.data
        console.log(resp.data);
})
.catch(function (error) {
    console.error('Error fetching cart items:', error);
});
	}
    $scope.initialize()
}])