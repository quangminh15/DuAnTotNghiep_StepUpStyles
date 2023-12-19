app.controller("voucher-ctrl", function ($scope, $http) {
  $scope.voucher = [];
  $scope.voucherUse = [];
  $scope.getVoucher = [];

  $scope.getAllVoucher = function () {
    $http.get("/rest/voucher/valid").then((resp) => {
      $scope.voucher = resp.data;
      console.log($scope.voucher)
      $scope.pager.first();
      $scope.voucher.forEach(function (ddI) {
        ddI.formattedStartDate = formatDate(ddI.dateStart);
        ddI.formattedEndDate = formatDate(ddI.dateEnd);
      });
      // $scope.userId = 2;

      $http.get("/user/Idprofile").then((resp) =>{
        var userId = resp.data;
        $http.get("/user/" + userId).then(userResp =>{
          console.log(userId);
          var fullUserData = userResp.data;
          $http.get("/rest/voucherUse").then((resp) => {
            $scope.voucherUse = resp.data;
            console.log($scope.voucherUse);
            $scope.voucher.forEach(function (voucherItem) {
              voucherItem.saved = isVoucherSaved(voucherItem.voucherId, userId);
              console.log(userId);
          });
          });
        })
      })

      

      function isVoucherSaved(voucherId, userId) {
        // Duyệt qua mỗi voucherUse
        for (let i = 0; i < $scope.voucherUse.length; i++) {
            const voucherUseItem = $scope.voucherUse[i];
            if (voucherUseItem.voucher.voucherId === voucherId && voucherUseItem.user.usersId === userId) {
                return true; // Nếu đã lưu, trả về true
            }
        }
        return false; // Nếu chưa lưu, trả về false
    }
      function formatDate(startDate) {
        // Parse the input date string
        const inputDate = new Date(startDate);
    
        // Format options
        const options = {
            weekday: 'long', // 'long' for the full weekday name
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            // hour: '2-digit',
            // minute: '2-digit',
            // second: '2-digit',
            hour12: false, // 24-hour format
            timeZone: 'Asia/Ho_Chi_Minh', // Time zone
        };
    
        // Format the date using Intl.DateTimeFormat
        const formattedDate = new Intl.DateTimeFormat('vi-VN', options).format(inputDate);
    
        return formattedDate;
    }
    });

    $http.get("/rest/voucherUse").then((resp) => {
      $scope.voucherUse = resp.data;
      // Kiểm tra saved và thiết lập isSaved dựa trên giá trị của saved
    
    });

  };

  $scope.formatToVND = function (amount) {
    // Logic để định dạng số amount sang định dạng VND
    return amount.toLocaleString("vi-VN", {
      style: "currency",
      currency: "VND",
    });
  };

  $scope.formatDate = function (startDate) {
    // Parse the input date string
    const inputDate = new Date(startDate);

    // Format options
    const options = {
        weekday: 'long', // 'long' for the full weekday name
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        // hour: '2-digit',
        // minute: '2-digit',
        // second: '2-digit',
        hour12: false, // 24-hour format
        timeZone: 'Asia/Ho_Chi_Minh', // Time zone
    };

    // Format the date using Intl.DateTimeFormat
    const formattedDate = new Intl.DateTimeFormat('vi-VN', options).format(inputDate);

    return formattedDate;
}

  $scope.openModal = function (voucherId) {
    // Make an HTTP request to your API endpoint
    $http
      .get("/rest/voucher/getIdVoucher/" + voucherId)
      .then(function (response) {
        // Handle the response and display details in the modal
         var getVoucher = response.data; // Assuming the response contains voucher details
        console.log("Voucher",getVoucher);
        // Update the modal content with the voucher details
        var modalBody = document.querySelector("#voucherModalBody");
        // Example: Display details in the modal
        modalBody.innerHTML = `
                        <div class="voucher-modal-content">
                        <div class="row" style="margin-left: 0px; box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px; position: relative; margin-bottom: 10px;">
                                            <div class="col-md-3"
                                                style="background-color: #ff7315; display: flex; flex-direction: column; justify-content: center; align-items: center;">
                                                <svg width="50" height="70" xmlns="http://www.w3.org/2000/svg">
                                                    <text x="15" y="50" font-size="30" fill="white">%</text>
                                                </svg>
                                                <div style="margin-bottom: 30px;">
                                                    <div class="gg">Giảm giá</div>
                                                    <div class="sus">FOURSHOE</div>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="card-body">
                                                    <div>Giảm: ${getVoucher.discountAmount}%</div>
                                                    <div>Đơn tối thiểu: ${$scope.formatToVND(getVoucher.total)}</div>
                                                    <div>Giảm tối đa: ${$scope.formatToVND(getVoucher.miniOrder)}</div>
                                                    <div style="font-size: 11px; color: red;">Áp dụng: ${$scope.formatDate(getVoucher.dateStart)} - ${$scope.formatDate(getVoucher.dateEnd)}</div>
                                                </div>
                                            </div>
                                        </div>
                            <b>Thời hạn sử dụng:</b>
                            <p class="date">${$scope.formatDate(getVoucher.dateStart)} - ${$scope.formatDate(getVoucher.dateEnd)}</p>
                            <b>Chi tiết</b>
                            <p class="ct">${getVoucher.description}</p>
                        </div>
                    `;

        // Open the modal
        $("#voucherModal").modal("show");

        
      })
      .catch(function (error) {
        // Handle error
        console.error("Error:", error);
      });
  };
  
  $scope.saveVoucher = function(item) {
    var voucherId = item.voucherId;
    
    $http.get("/user/Idprofile").then((resp) =>{
      var userId = resp.data;
      if (!userId) {
        // User is not logged in, show an error message
        const Toast = Swal.mixin({
            toast: true,
            position: 'top',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });
        Toast.fire({
            icon: 'error',
            title: 'Bạn cần đăng nhập để sử dụng voucher',
        });

        // You might want to return or handle the error in some way
        return;
    }
      $http.get("/user/" + userId).then(userResp =>{
        console.log(userId);
        var fullUserData = userResp.data;
        $http.post('/rest/voucherUse/saveVoucherUse?voucherId=' + voucherId + '&userId=' + userId)
        .then(resp => {
            // Set isSaved to true upon successful save
            console.log(voucherId);
            $scope.getAllVoucher();
            const Toast = Swal.mixin({
                toast: true,
                position: 'top',
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.addEventListener('mouseenter', Swal.stopTimer)
                    toast.addEventListener('mouseleave', Swal.resumeTimer)
                }
            });
            Toast.fire({
                icon: 'success',
                title: 'Đã thêm thành công voucher',
            });
        })
        .catch(error => {
            // Set isSaved to false if there's an error
            console.log("Error", error);
        });
      })
    })
    };

    //phân trang voucher bắt đầu
	$scope.pager = {
		page: 0,
		size: 6,
		getPageNumbers: function() {
			var pageCount = this.count;
			var currentPage = this.page + 1;
			var voucherPage = [];

			if (pageCount <= 3) {
				for (var i = 1; i <= pageCount; i++) {
					voucherPage.push({ value: i });
				}
			} else {
				if (currentPage <= 2) {
					voucherPage.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
				} else if (currentPage >= pageCount - 1) {
					voucherPage.push({ value: '...' }, { value: pageCount - 2 }, { value: pageCount - 1 }, { value: pageCount });
				} else {
					voucherPage.push({ value: '...' }, { value: currentPage - 1 }, { value: currentPage }, { value: currentPage + 1 }, { value: '...' });
				}
			}
			return voucherPage;
		},
		get voucher() {
			var start = this.page * this.size;
      console.log("bat dau", start);
			return $scope.voucher.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.voucher.length / this.size);
		},
		first() {
			this.page = 0;
			$scope.voucherPage = this.getPageNumbers();
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
			$scope.voucherPage = this.getPageNumbers();
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
			$scope.voucherPage = this.getPageNumbers();
		},
		last() {
			this.page = this.count - 1;
			$scope.voucherPage = this.getPageNumbers();
		},
		goto(pageNumber) {
			if (pageNumber >= 1 && pageNumber <= this.count) {
				this.page = pageNumber - 1;
				$scope.voucherPage = this.getPageNumbers();
			}
		},
	};
	//phân trang voucher kết thúc

    $scope.getAllVoucher();
});