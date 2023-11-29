app.controller("revenues-ctrl", function ($scope, $http) {
    $scope.sortableColumns = [
		{ name: 'orderId', label: 'STT' },
		{ name: 'shippingAddress.nameReceiver', label: 'Người Nhận' },
		{ name: 'orderorderDate', label: 'Ngày đặt' },
		{ name: 'paymentStatus', label: 'Tình trạng thanh toán' },
		{ name: 'totalAmount', label: 'Tổng thanh toán' },
		{ name: 'paymentMenthod.paymentMethodName', label: 'Thanh toán' },
		{ name: 'orderStatus', label: 'Trạng thái đơn hàng' },

	];
    $scope.yearlyData = {
        labels: [], // Years will go here
        datasets: [
            {
                label: 'Total tổng doanh thu theo từng Năm',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1,
                hoverBackgroundColor: 'rgba(75, 192, 192, 0.4)',
                hoverBorderColor: 'rgba(75, 192, 192, 1)',
                data: [] // Revenue data per year will go here
            }
        ]
    };
    
    const currentYear = new Date().getFullYear();
    $scope.allOrders=[]
    // bieu do doanh thu theo  nam 

    $http.get(`/rest/order/listOrder/all`)
        .then(resp => {
            const orders = resp.data;
            $scope.allOrders= resp.data
            $scope.filterOrdersByYear(currentYear);
            // Extract years and calculate revenue for each year
            const yearlyRevenue = orders.reduce((acc, order) => {
                if (order.orderStatus === 'Delivered') {
                    const orderYear = new Date(order.orderDate).getFullYear();

                    if (!acc[orderYear]) {
                        acc[orderYear] = 0;
                    }

                    acc[orderYear] += order.totalAmount; // Assuming totalAmount is the revenue
                }
                return acc;
            }, {});

            // Populate chart data
            for (const year in yearlyRevenue) {
                if (yearlyRevenue.hasOwnProperty(year)) {
                    $scope.yearlyData.labels.push(year);
                    $scope.yearlyData.datasets[0].data.push(yearlyRevenue[year]);
                }
            }

            // Render chart
            var ctx = document.getElementById('yearlyChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: $scope.yearlyData,
                options: {
                    onClick: function (event, chartElement) {
                        if (chartElement.length > 0) {
                            const selectedYear = $scope.yearlyData.labels[chartElement[0]._index];
                            updateMonthlyChart(selectedYear);
                            $scope.filterOrdersByYear(selectedYear);
                            
                        }
                    },
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                callback: function (value) {
                                    // Format value as VND
                                    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                                }
                            }
                        }]
                    },
                    tooltips: {
                        callbacks: {
                            label: function (tooltipItem, data) {
                                let value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];

                                return "Doanh Thu:" + new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                            }
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error('Error fetching orders:', error);
        });

    $scope.monthlyData = {
        labels: [], // Months will go here
        datasets: [
            {
                label: 'Tổng doanh thu theo từng Tháng',
                backgroundColor: 'rgba(0, 40, 150,0.6)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1,
                hoverBackgroundColor: 'rgba(75, 192, 192, 0.4)',
                hoverBorderColor: 'rgba(75, 192, 192, 1)',
                data: [] // Revenue data per month will go here
            }
        ]
    };
    $scope.filteredOrders=[]
    $scope.filterOrdersByYear = function(selectedYear) {
        
        // Assuming your orders have an 'orderDate' attribute containing the order date
        $scope.filteredOrders = $scope.allOrders.filter(function(order) {
            return new Date(order.orderDate).getFullYear() === parseInt(selectedYear);
        });
    };
    

    function updateMonthlyChart(selectedYear) {
        
        // Fetch orders and process monthly data for the selected year
        if (!selectedYear) {
            selectedYear = new Date().getFullYear();
            $scope.presentYear =selectedYear// Get the current year if no year is specified
        }
        $scope.presentYear=selectedYear
        $http.get(`/rest/order/listOrder/all`)
            .then(resp => {
                const orders = resp.data;

                // Filter orders for the selected year
                const ordersInSelectedYear = orders.filter(order => {
                    return new Date(order.orderDate).getFullYear() === parseInt(selectedYear);
                });

                // Initialize an array to hold monthly revenue data
                const monthlyRevenue = Array.from({ length: 12 }, () => 0); // 12 months, initialized with 0s

                // Calculate revenue for each month
                ordersInSelectedYear.forEach(order => {
                    const orderMonth = new Date(order.orderDate).getMonth();
                    monthlyRevenue[orderMonth] += order.totalAmount; // Assuming totalAmount is the revenue
                });

                // Update chart data
                const monthNames = [
                    'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
                    'Tháng7', 'Tháng8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'
                ];

                $scope.monthlyData.labels = monthNames;
                $scope.monthlyData.datasets[0].data = monthlyRevenue;
                // Render chart
                var ctx = document.getElementById('monthlyChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: $scope.monthlyData,
                    options: {
                       
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    callback: function (value) {
                                        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                                    }
                                }
                            }]
                        },
                        tooltips: {
                            callbacks: {
                                label: function (tooltipItem, data) {
                                    let value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                                    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                                }
                            }
                        }
                    }
                });
            })
            .catch(error => {
                console.error('Error fetching orders:', error);
            });
            
    }
    //chạy biểu đồ tháng từ đầu với năm hiện tại
    updateMonthlyChart()

    $scope.orderDetail=[]
    $scope.calculateItemTotal = function (item) {
		let totalQuantity = 0;
		for (let i = 0; i < $scope.orderDetail.length; i++) {
			totalQuantity += $scope.orderDetail[i].quantity;
		}
		return totalQuantity;
	};
    $scope.viewDetail = function (id) {
		$http.get(`/rest/order/single?orderid=${id}`)
			.then(resp => {
				$scope.singleOrder = resp.data
			}).catch(function (error) {
				console.error('Error update:', error);
			});
		$http.get(`/rest/order/listOrder/detail?orderid=${id}`)
			.then(respone => {
				$scope.orderDetail = respone.data
				console.log("orderdetaill", $scope.orderDetail);

				$scope.orderDetail.forEach(orderdetails => {
					$scope.calculateItemTotal(orderdetails)
					
					$http.get("/rest/productimages/loadbyproduct/" + orderdetails.productDetail.product.productID).then(resp => {
						orderdetails.image = resp.data;
						

					})

				})
			})
	}
})