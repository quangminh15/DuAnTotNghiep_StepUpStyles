//var app = angular.module("admin-app", []);
app.controller("statistical", function($scope, $http) {
	$scope.form = {};
	$scope.items = [];
	$scope.topitem = []; // Lưu trữ dữ liệu từ API
	$scope.year = [];
	let myChart;
	$scope.topitem = function() {
		$http.get(`http://localhost:8080/rest/OrderDetail/topSellingItems`).then(resp => {
			$scope.topitem = resp.data; // Gán dữ liệu từ API
			createChart();
		}).catch(error => console.log("Error", error));
	}
	$scope.topitem();

	$scope.search = function(year) {
		if (myChart) {
			myChart.destroy(); // Hủy bỏ biểu đồ cũ nếu tồn tại
		}
		$http.get(`http://localhost:8080/rest/OrderDetail/top-selling-items/${year}`)
			.then(resp => {
				$scope.topitem = resp.data; // Gán dữ liệu từ API
				createChart();
			})
			.catch(error => console.log("Error", error));
	}

	$scope.loadyear = function() {
		$http.get("http://localhost:8080/rest/OrderDetail/loadyear")
			.then(resp => {
				$scope.year = resp.data;
			})
			.catch(error => console.log("Error", error));
	}
	$scope.loadyear();

	function createChart() {
		const uniqueProducts = [...new Set($scope.topitem.map(item => item[0]))];
		const uniqueMonths = [null, "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];

		const datasets = uniqueProducts.map(product => {
			const dataValues = uniqueMonths.map((month, index) => {
				if (index === 0) return product; // Gán tên sản phẩm cho tháng đầu tiên
				const matchingData = $scope.topitem.find(item => item[0] === product && item[1] === index); // Chuyển đổi giá trị tháng từ số sang tên tháng
				return matchingData ? matchingData[2] : 0;
			});

			return {
				label: product,
				data: dataValues.slice(1), // Loại bỏ tên sản phẩm từ mảng dữ liệu
				backgroundColor: getRandomColor(),
				borderColor: getRandomColor(),
				borderWidth: 1
			};
		});

		const ctx = document.getElementById('myChart').getContext('2d');
		myChart = new Chart(ctx, {
			type: 'bar',
			data: {
				labels: uniqueMonths.slice(1), // Loại bỏ tên sản phẩm từ mảng tháng
				datasets: datasets
			},
			options: {
				scales: {
					y: {
						beginAtZero: true,
						ticks: {
							callback: function(value, index, values) {
								return value.toLocaleString('en-US') + ' VND';
							}
						}
					}
				}
			}
		});

	}


	function getRandomColor() {
		const letters = '0123456789ABCDEF';
		let color = '#';
		for (let i = 0; i < 6; i++) {
			color += letters[Math.floor(Math.random() * 16)];
		}
		return color;
	}
});