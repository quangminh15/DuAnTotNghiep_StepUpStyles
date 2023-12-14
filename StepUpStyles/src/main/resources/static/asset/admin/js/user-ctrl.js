app.controller("user-ctrl", function($scope, $http) {
	$scope.uList = [];
	$scope.prodcates = [];
	$scope.subcates = [];
	$scope.orderdetails = [];
	$scope.form = {};
	$scope.form.productCategory = {};
	$scope.form.subCategory = {};
	$scope.errorMessage = '';
	$scope.userDetails = null;

	$scope.initialize = function() {
		//load user
		$http.get("/user").then(resp => {
			$scope.uList = resp.data;
			$scope.pager.first();
		});
	}

	$scope.sortableColumns = [
		{ name: 'categoryID', label: 'Mã người dùng' },
		{ name: 'categoryName', label: 'Họ và tên' },
		{ name: 'categoryID', label: 'Hình ảnh' },
		{ name: 'categoryImage', label: 'Email' },
		{ name: 'modifyDate', label: 'Số điện thoại' },
		{ name: 'activities', label: 'Quyền' },
	];

	//	Xóa form
	$scope.reset = function() {
		$scope.form = {
			  userID: 0,
			  address: "",
			  birthday: null,
			  email: "",
			  fullName: "",
			  gender: false,
			  lockStatus: null ,
			  loginPermission: false,
			  password: "",
			  phoneNumber: "",
			  registrationDate: null,
			  username: "",
			  role: ""

		};
	}
	
	//	Khởi đầu
	$scope.initialize();
	$scope.reset();

	//	Hiển thị lên form
	$scope.edit = function(user) {
		$scope.form = angular.copy(user);
		$scope.form.birthday = $scope.convertDateFormat($scope.form.birthday);

	}

	// convertDateFormat
	$scope.convertDateFormat = function(input) {
		if (!input) return '';
		var date = new Date(input);
		var formattedDate =
			('0' + date.getDate()).slice(-2) +
			'/' +
			('0' + (date.getMonth() + 1)).slice(-2) +
			'/' +
			date.getFullYear();
		return formattedDate;
	};


	$scope.changeDateFormat = function() {
		var originalDate = new Date($scope.form.birthday);
		if (!isNaN(originalDate.getTime())) {
			var formattedDate = ('0' + (originalDate.getMonth() + 1)).slice(-2) + '/' + ('0' + originalDate.getDate()).slice(-2) + '/' + originalDate.getFullYear();
			$scope.form.birthday = formattedDate;
		}
	};



	//	Thêm sản phẩm mới 
	$scope.create = function() {
		//Không chọn danh mục
		



		// Lấy thông tin người dùng từ API /api/user (email)
		$http.get("/api/user").then(resp => {
			const email = resp.data.username; // Lấy email từ userDetails
			// Truy vấn cơ sở dữ liệu để lấy userID từ email
			$http.get("/rest/users/by-email/" + email).then(userResp => {
				var userID = userResp.data.userID;
				$scope.form.user = { userID: userID }; // Gán userID cho sản phẩm

				var currentDate = new Date(); // Lấy ngày hiện tại
				$scope.form.createdDate = currentDate; // Gán ngày hiện tại cho createdDate

				var user = angular.copy($scope.form);
				user.user.userID = userID;
				user.createdDate = currentDate;
				$http.post('/rest/products/create', user).then(resp => {
					resp.data.createdDate = new Date(resp.data.createdDate);
					$scope.uList.push(resp.data);
					$scope.reset();
					$scope.errorMessage = ''; // Xóa thông báo lỗi khi thành công
					$scope.messageSuccess = "Thêm mới thành công";
					$scope.initialize();
					$('#errorModal1').modal('show'); // Show the modal
				}).catch(error => {
					if (error.status === 400) {
						$scope.errorMessage = error.data;
					} else {
						$scope.errorMessage = "Thêm mới thất bại";
						$scope.initialize();
						$('#errorModal').modal('show'); // Show the modal
						console.log("Error", error);
					}
				});
			}).catch(error => {
				console.log("Error fetching userID from email", error);
				// Xử lý lỗi khi không lấy được userID từ email
			});
		}).catch(error => {
			console.log("Error fetching user data", error);
			// Xử lý lỗi khi không lấy được dữ liệu người dùng
		});
	}

	//	Cập nhật người dùng
	$scope.update = function() {

		//Lỗi bỏ trống tên người dùng 
		if (!$scope.form.username) {
			$scope.errorMessage = "Vui lòng nhập tên người dùng!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống tên đầy đủ
		if (!$scope.form.fullName) {
			$scope.errorMessage = "Vui lòng nhập tên đày đủ!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		//Lỗi bỏ trống sđt
		if (!$scope.form.phoneNumber) {
			$scope.errorMessage = "Vui lòng nhập số điện thoại!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		console.log('Date from form: ',$scope.form.dateOfBirth )
		//Lỗi ngày sinh
		if (!$scope.form.dateOfBirth) {
			$scope.errorMessage = "Vui lòng nhập ngày sinh!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
			console.log(typeof $scope.form.dateOfBirth);
           	var date = $scope.form.dateOfBirth;
           	var year = date.getFullYear(); 
           	var month = date.getMonth() + 1;
			var day = date.getDate();
			
			var dateNow = new Date();
           	var yearNow = dateNow.getFullYear(); 
           	var monthNow = dateNow.getMonth() + 1;
			var dayNow = dateNow.getDate();
		if ((yearNow - year < 15) || (yearNow - year === 15 && monthNow >= month) || (yearNow - year === 15 && monthNow === month && dayNow >= day)) {
			$scope.errorMessage = "Người dùng phải từ 15 tuổi!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}
		
		
		//Lỗi bỏ trống địa chỉ
		if (!$scope.form.address) {
			$scope.errorMessage = "Vui lòng nhập địa chỉ người dùng!!";
			$('#errorModal').modal('show'); // Show the modal
			return;
		}

		// Lấy thông tin người dùng từ API /api/user (email)
		
			

				var user = angular.copy($scope.form); console.log('cc', user)
				console.log('xz: ', $scope.form)
				$http.put('/rest/Users/update/3', $scope.form).then(resp => {
					
			//		var index = $scope.uList.findIndex(p => p.productID == user.productID);
			//		resp.data.createdDate = new Date(resp.data.createdDate);
			//		$scope.uList[index] = user;
					$scope.messageSuccess = "Cập nhật thành công";
					$scope.initialize();
					$('#errorModal1').modal('show'); // Show the modal
				}).catch(error => {
					$scope.errorMessage = "Cập nhật thất bại";
					$('#errorModal').modal('show'); // Show the modal
					$scope.initialize();
					console.log("Error", error);
				})
		
	}

	//	Xóa người dùng
	$scope.delete = function() {
		var user = angular.copy($scope.form); 
		user.loginPermission = false;
				$http.put('/rest/Users/update/' + user.userID, user).then(resp => {
					var index = $scope.uList.findIndex(p => p.productID == user.productID);
					resp.data.createdDate = new Date(resp.data.createdDate);
					$scope.uList[index] = user;
					$scope.messageSuccess = "Xoá thành công";
					$scope.initialize();
					$('#errorModal1').modal('show'); // Show the modal
				}).catch(error => {
					$scope.errorMessage = "Xoá thất bại";
					$('#errorModal').modal('show'); // Show the modal
					$scope.initialize();
					console.log("Error", error);
				})
				
		$('#confirmDeleteModal').modal('hide');
	}
	
	//Gọi đến modal xác nhận để xóa
	$scope.confirmDeleteModal = function() {
		$('#confirmDeleteModal').modal('show');
	}
	$scope.confirmDeleteModal1 = function(user) {
		$scope.form = angular.copy(user);
		var formattedDate = moment($scope.form.dateOfBirth).format("yyyy-MM-DD");
         //       $scope.form.dateOfBirth = formattedDate;
                $scope.form.dateOfBirth = new Date(formattedDate);
		$('#confirmDeleteModal').modal('show');
	}

	//Phân trang
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
		get uList() {
			var start = this.page * this.size;
			return $scope.uList.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.uList.length / this.size);
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
	
	//Mở modal tìm kiếm
	$scope.openSearchForm = function() {
		// Reset searchKeyword
		$scope.searchKeyword = '';
		$('#searchModal').modal('show');
	};
	
	// Tìm kiếm 
	$scope.searchUserByName = function() {console.log('key: ',$scope.searchKeyword)
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/Users/search/", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {console.log('resp data: ',$scope.uList)
				$scope.uList = resp.data;
				$scope.pager.first();
				
				if (resp.data.length === 0) {
					$scope.initialize();
					$scope.errorMessage = `Không tìm thấy người dùng có tên "${$scope.searchKeyword}"`;
					$('#errorModal').modal('show');
				}
			}).catch(error => {
				$scope.errorMessage = "Lỗi khi tìm kiếm người dùng!";
				$('#errorModal').modal('show'); // Hiển thị modal lỗi
				console.log("Error", error);
				$scope.pager.first();
			});
		} else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
			$scope.errorMessage = "Không tìm thấy người dùng mà bạn mong muốn!";
			$('#errorModal').modal('show'); // Hiển thị modal lỗi
		}
		$('#searchModal').modal('hide');
	};


})