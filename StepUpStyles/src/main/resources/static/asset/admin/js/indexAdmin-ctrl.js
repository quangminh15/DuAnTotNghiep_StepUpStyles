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
    
    function myCustomFunction() {
			var today = new Date();
			var weekday = new Array(7);
			weekday[0] = "Chủ Nhật";
			weekday[1] = "Thứ Hai";
			weekday[2] = "Thứ Ba";
			weekday[3] = "Thứ Tư";
			weekday[4] = "Thứ Năm";
			weekday[5] = "Thứ Sáu";
			weekday[6] = "Thứ Bảy";
			var day = weekday[today.getDay()];
			var dd = today.getDate();
			var mm = today.getMonth() + 1;
			var yyyy = today.getFullYear();
			var h = today.getHours();
			var m = today.getMinutes();
			var s = today.getSeconds();
			m = checkTime(m);
			s = checkTime(s);
			nowTime = h + " giờ " + m + " phút " + s + " giây";
			if (dd < 10) {
				dd = '0' + dd
			}
			if (mm < 10) {
				mm = '0' + mm
			}
			today = day + ', ' + dd + '/' + mm + '/' + yyyy;
			tmp = '<span class="date"> ' + today + ' - ' + nowTime + '</span>';
			document.getElementById("clock").innerHTML = tmp;
			clocktime = setTimeout("myCustomFunction()", 1000);

			function checkTime(i) {
				if (i < 10) {
					i = "0" + i;
				}
				return i;
			}
		}
		document.addEventListener("DOMContentLoaded", function() {
			myCustomFunction();
		});
});
