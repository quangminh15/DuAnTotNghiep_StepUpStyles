app.controller("voucher-ctrl", function ($scope, $http) {
  $scope.voucher = [];
  $scope.getVoucher = [];

  $scope.getAllVoucher = function () {
    $http.get("/rest/voucher/valid").then((resp) => {
      $scope.voucher = resp.data;
      $scope.voucher.forEach(function (ddI) {
        ddI.formattedStartDate = formatDate(ddI.dateStart);
        ddI.formattedEndDate = formatDate(ddI.dateEnd);
      });
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
  };

  $scope.getAllVoucher();

  $scope.formatToVND = function (amount) {
    // Logic để định dạng số amount sang định dạng VND
    return amount.toLocaleString("vi-VN", {
      style: "currency",
      currency: "VND",
    });
  };

  $scope.openModal = function (voucherId) {
    // Make an HTTP request to your API endpoint
    $http
      .get("/rest/voucher/getIdVoucher/" + voucherId)
      .then(function (response) {
        // Handle the response and display details in the modal
        var getVoucher = response.data; // Assuming the response contains voucher details
        console.log(getVoucher);

        // Update the modal content with the voucher details
        var modalBody = document.querySelector("#voucherModalBody");
        // Example: Display details in the modal
        modalBody.innerHTML = `
                        <div class="voucher-modal-content">
                        <div class="row" style="margin-left: 0px;">
                                            <div class="col-md-3"
                                                style="background-color: orange; display: flex; flex-direction: column; justify-content: center; align-items: center;">
                                                <svg width="50" height="70" xmlns="http://www.w3.org/2000/svg">
                                                    <text x="10" y="70" font-size="40" fill="white">%</text>
                                                </svg>
                                                <div style="margin-bottom: 30px;">
                                                    <div class="gg">Giảm giá</div>
                                                    <div class="sus">SUS</div>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="card-body">
                                                    <div>Giảm: ${getVoucher.discountAmount}%</div>
                                                    <div>Đơn tối thiểu: ${$scope.formatToVND(getVoucher.total)}</div>
                                                    <div style="font-size: 11px; color: red;">Áp dụng: Thứ năm, ${getVoucher.dateStart} - Thứ hai, ${getVoucher.dateEnd}</div>
                                                </div>
                                            </div>
                                        </div>
                            <b>Thời hạn sử dụng</b>
                            <p class="date">${getVoucher.dateStart} - ${getVoucher.dateEnd}</p>
                            <b>Sản phẩm áp dụng</b>
                            <p class="sp">Tất cả sản phẩm</p>
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
        item.saved = true;
				$http.put('/rest/voucher/updateVoucher/' + item.voucherId, item).then(resp => {
					var index = $scope.voucher.findIndex(p => p.voucherId == item.voucherId);
					$scope.voucher[index] = item;
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
          })
          Toast.fire({
            icon: 'success',
            title: 'Đã thêm thành công voucher',

          })
				}).catch(error => {
          console.log("Error", error);
        })
    
    // Sau khi lưu thành công, cập nhật trạng thái đã lưu cho item
    item.saved = true;
  };

});