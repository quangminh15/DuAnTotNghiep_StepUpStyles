app.controller("product-img-ctrl", function($scope, $http) {
	$scope.productimageitems = [];
	$scope.prods = [];
	$scope.form = {};
	$scope.form.product = {};
	$scope.errorMessage = '';

	$scope.initialize = function() {
		// Load productimages
		$http.get("/rest/productimages/loadall").then(resp => {
			$scope.productimageitems = resp.data;
		});

		// Load product
		$http.get("/rest/products/loadall").then(resp => {
			$scope.prods = resp.data;
			$scope.productimageitems.forEach(productitem => {
				productitem.createDate = new Date(productitem.createDate);
			});
		});
	}

	// Hàm giới hạn độ dài của đường dẫn
	$scope.truncateUrl = function(url) {
		const maxLength = 50; // Độ dài tối đa bạn muốn hiển thị
		if (url.length > maxLength) {
			return url.substring(0, maxLength) + '...';
		} else {
			return url;
		}
	};

	// Xóa form
	$scope.reset = function() {
		$scope.form = {};
	}

	// Khởi đầu
	$scope.initialize();
	$scope.reset();

	// Hiển thị lên form
	$scope.edit = function(productimageitem) {
		$scope.form = angular.copy(productimageitem);
	}

	// Thêm mới 
	$scope.create = async function() {
		if (!$scope.form.product.productID) {
			$scope.errorMessage = "Bạn chưa chọn sản phẩm";
			$('#errorModal').modal('show');
			return; // Dừng tiến trình nếu không chọn sản phẩm
		}

		if (!document.querySelector('#photo').files[0]) {
			$scope.errorMessage = "Bạn chưa chọn ảnh";
			$('#errorModal').modal('show');
			return; // Dừng tiến trình nếu không chọn ảnh
		}

		try {
			await $scope.uploadImages(); // Tải ảnh lên Firebase

			// Thực hiện việc lưu vào db
			var productimageitem = angular.copy($scope.form);
			productimageitem.imagePath = $scope.form.imagePath;
			$http.post('/rest/productimages/create', productimageitem).then(resp => {
				$scope.productimageitems.push(resp.data);
				$scope.reset();
				$scope.errorMessage = '';
				$scope.messageSuccess = "Thêm mới thành công";
				$('#errorModal1').modal('show');
			}).catch(error => {
				if (error.status === 400) {
					$scope.errorMessage = error.data;
				} else {
					$scope.errorMessage = "Thêm mới thất bại";
					$('#errorModal').modal('show');
					console.log("Error", error);
				}
			});
		} catch (error) {
			$scope.errorMessage = "Tải ảnh lên firebase thất bại";
			$('#errorModal').modal('show'); // Show the modal
		}
	};


	// Cập nhật  
	$scope.update = async function() {
		if (!$scope.form.product.productID) {
			$scope.errorMessage = "Bạn chưa chọn sản phẩm";
			$('#errorModal').modal('show');
			return; // Dừng tiến trình nếu không chọn sản phẩm
		}

		if (!document.querySelector('#photo').files[0]) {
			$scope.errorMessage = "Bạn chưa chọn ảnh";
			$('#errorModal').modal('show');
			return; // Dừng tiến trình nếu không chọn ảnh
		}


		try {
			await $scope.uploadImages(); // Tải ảnh lên Firebase

			// Thực hiện việc chỉnh sửa và lưu vào db
			var productimageitem = angular.copy($scope.form);
			$http.put('/rest/productimages/update/' + productimageitem.productImageID, productimageitem).then(resp => {
				var index = $scope.productimageitems.findIndex(p => p.productImageID == productimageitem.productImageID);
				$scope.productimageitems[index] = productimageitem;
				$scope.messageSuccess = "Cập nhật thành công";
				$('#errorModal1').modal('show');
			}).catch(error => {
				$scope.errorMessage = "Cập nhật thất bại";
				$('#errorModal').modal('show');
				console.log("Error", error);
			});
		} catch (error) {
			$scope.errorMessage = "Tải ảnh lên firebase thất bại";
			$('#errorModal').modal('show'); // Show the modal
		}
	};

	// Tải ảnh lên Firebase	
	$scope.uploadImages = function() {
		var ref = firebase.storage().ref();
		var folder = 'product';
		var file = document.querySelector('#photo').files[0];
		var metadata = {
			contentType: file.type
		};
		var name = folder + '/' + file.name; // Tạo tên file với thư mục

		var uploadIMG = ref.child(name).put(file, metadata);

		return uploadIMG.then(snapshot => snapshot.ref.getDownloadURL())
			.then(url => {
				// Lưu đường dẫn ảnh vào biến $scope.form.imagePath
				$scope.form.imagePath = url;
			});
	};


	// Xóa 
	$scope.delete = async function(productimageitem) {
		try {
			// Lấy đường dẫn ảnh từ đối tượng productimageitem
			var imagePath = productimageitem.imagePath;

			// Xóa hình ảnh từ Firebase Storage
			await $scope.deleteImageFromStorage(imagePath);

			// Xóa dữ liệu từ cơ sở dữ liệu
			$http.delete('/rest/productimages/delete/' + productimageitem.productImageID).then(resp => {
				var index = $scope.productimageitems.findIndex(p => p.productImageID == productimageitem.productImageID);
				$scope.productimageitems.splice(index, 1);
				$scope.reset();
				$scope.messageSuccess = "Xóa thành công";
				$('#errorModal1').modal('show'); // Show the modal
			}).catch(error => {
				$scope.errorMessage = "Xóa thất bại";
				$('#errorModal').modal('show'); // Show the modal
				console.log("Error", error);
			});
		} catch (error) {
			$scope.errorMessage = "Xóa thất bại";
			$('#errorModal').modal('show'); // Show the modal
			console.log("Error", error);
		}
	};

	// Hàm xóa hình ảnh từ Firebase Storage
	$scope.deleteImageFromStorage = async function(imagePath) {
		const storageRef = firebase.storage().ref();
		const imageRef = storageRef.child(imagePath);

		try {
			await imageRef.delete();
			console.log("Image deleted successfully from Firebase Storage.");
		} catch (error) {
			throw new Error("Error deleting image from Firebase Storage: " + error.message);
		}
	};


	// Phân trang
	$scope.pager = {
		page: 0,
		size: 10,
		get productimageitems() {
			var start = this.page * this.size;
			return $scope.productimageitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productimageitems.length / this.size);
		},
		first() {
			this.page = 0;
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
		},
		last() {
			this.page = this.count - 1;
		}
	};


});