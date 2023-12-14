app.controller("totalImport-ctrl", function($scope, $http) {

    $scope.productList = [];

    var currentYear = new Date().getFullYear();
    $scope.years = [];
    for (var i = 2023; i <= currentYear; i++) {
        $scope.years.push(i);
    }

    $scope.months = [];
    for (var i = 1; i <= 12; i++) {
        $scope.months.push(i);
    }

    $scope.selectedYear = currentYear;
    $scope.selectedMonth = new Date().getMonth() + 1;
    // $scope.selectedMonth = 9;

    // Khởi tạo biểu đồ
    var ctx = document.getElementById('column-chart').getContext('2d');
    var chart = new Chart(ctx, {
        type: 'bar',  // Thay đổi type thành 'bar' cho biểu đồ cột
        data: {
            labels: [],
            datasets: []
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    min: 0,  // Set a minimum value for the y-axis
                    skipNull: true
                }
            }
        }
    });

    function getRandomColor() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }

    // Hàm cập nhật biểu đồ dựa trên năm được chọn
    $scope.updateChartData = function () {
        $http.get('rest/importReceipt/productQuantity?month=' + $scope.selectedMonth + '&year=' + $scope.selectedYear)
        .then(function (response) {
            var data = response.data;
            console.log(data);
            
            var productNames = data.map(function (item) {
                return item.productName;
            });

            var productQuantities = data.map(function (item) {
                return item.totalQuantity; // Giả sử dữ liệu của bạn có thuộc tính 'quantity'
            });
            console.log(productQuantities)

            var dataset = {
                label: 'Số lượng',
                data: productQuantities,
                backgroundColor: getRandomColor(),
                borderColor: getRandomColor(),
                borderWidth: 1
            };

            chart.data.labels = productNames;
            chart.data.datasets = [dataset]; // Sử dụng một mảng cho datasets
            chart.options.scales = {
                y: {
                    beginAtZero: true,
                    min: 0,  // Set a minimum value for the y-axis
                    skipNull: true
                }
            };
            
            chart.update();
        });

        //hiện sản phẩm phiếu nhập chi tiết
        $http.get('rest/importReceipt/productQuantityDetails?month=' + $scope.selectedMonth + '&year=' + $scope.selectedYear, {
        }).then(function (response) {
            $scope.productList = response.data;
            console.log($scope.productList);
            $scope.pager.first();
        });

        
    };

    // Cập nhật biểu đồ ban đầu
    $scope.updateChartData();

    //format tien te vnd
  $scope.formatToVND = function (amount) {
    // Logic để định dạng số amount sang định dạng VND
    return amount.toLocaleString("vi-VN", {
      style: "currency",
      currency: "VND",
    });
  };

  $scope.pager = {
    page: 0,
    size: 10,
    getPageNumbers: function() {
        var pageCount = this.count;
        var currentPage = this.page + 1;
        var visiblePages = [];

        if (pageCount <= 3) {
            for (var i = 1; i <= pageCount; i++) {
                visiblePages.push({ value: i });
            }
        } else {
            if (currentPage <= 2) {
                visiblePages.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
            } else if (currentPage >= pageCount - 1) {
                visiblePages.push({ value: '...' }, { value: pageCount - 2 }, { value: pageCount - 1 }, { value: pageCount });
            } else {
                visiblePages.push({ value: '...' }, { value: currentPage - 1 }, { value: currentPage }, { value: currentPage + 1 }, { value: '...' });
            }
        }
        return visiblePages;
    },
    get productList() {
        var start = this.page * this.size;
        return $scope.productList.slice(start, start + this.size);
    },
    get count() {
        return Math.ceil(1.0 * $scope.productList.length / this.size);
    },
    first() {
        this.page = 0;
        $scope.visiblePages = this.getPageNumbers();
    },
    prev() {
        this.page--;
        if (this.page < 0) {
            this.last();
        }
        $scope.visiblePages = this.getPageNumbers();
    },
    next() {
        this.page++;
        if (this.page >= this.count) {
            this.first();
        }
        $scope.visiblePages = this.getPageNumbers();
    },
    last() {
        this.page = this.count - 1;
        $scope.visiblePages = this.getPageNumbers();
    },
    goto(pageNumber) {
        if (pageNumber >= 1 && pageNumber <= this.count) {
            this.page = pageNumber - 1;
            $scope.visiblePages = this.getPageNumbers();
        }
    },
};

});
