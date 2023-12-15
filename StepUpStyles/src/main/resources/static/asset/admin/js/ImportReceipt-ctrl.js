app.controller("ImportReceipt-ctrl", function ($scope, $http) {
  $scope.items = [];
  $scope.importReceipt = [];
  $scope.importSup = [];
  $scope.form = {};
  $scope.formDetal = {};
  $scope.form.supplier = {};
  $scope.form.user = {};
  $scope.importDetail = [];
  $scope.form.importDetail = {};
  $scope.importReceiptDetailItems = [];
  $scope.prods = [];
  $scope.form.productDetail = {};
  $scope.showPhieuNhapForm = true; // Hiển thị form phiếu nhập mặc định
  $scope.showChiTietForm = false; // Ẩn form chi tiết mặc định
  $scope.showThemChiTietButton = true; // Hiển thị nút "Thêm chi tiết" mặc định
  $scope.form.totalAmount = 0;

  $scope.exportPdf = function () {
    $http({
      method: "POST",
      url: "/export-pdf",
      data: $scope.importDetail,
      responseType: "arraybuffer", // Đặt responseType thành 'arraybuffer' để nhận dữ liệu PDF dưới dạng ArrayBuffer
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then(function (response) {
        // Tạo một đối tượng Blob từ dữ liệu PDF và tạo URL để tải xuống
        var blob = new Blob([response.data], { type: "application/pdf" });
        var url = URL.createObjectURL(blob);

        // Tạo một thẻ a để tải xuống tệp PDF
        var a = document.createElement("a");
        a.href = url;
        a.download = "PhieuNhapStepUpStyle.pdf";
        document.body.appendChild(a);
        a.click();
        URL.revokeObjectURL(url);
      })
      .catch(function (error) {
        console.error("Xuất PDF thất bại:", error);
      });
  };

  $scope.exportExcel = function () {
    $http({
      method: "POST",
      url: "/export-excel", // Thay thế với URL phía máy chủ đúng
      data: $scope.importDetail,
      responseType: "arraybuffer", // Đặt responseType thành 'arraybuffer' để nhận dữ liệu Excel dưới dạng ArrayBuffer
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then(function (response) {
        // Tạo một đối tượng Blob từ dữ liệu Excel và tạo URL để tải xuống
        var blob = new Blob([response.data], {
          type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        });
        var url = URL.createObjectURL(blob);

        // Tạo một thẻ <a> để tải xuống tệp Excel
        var a = document.createElement("a");
        a.href = url;
        a.download = "PhieuNhapStepUpStyle.xlsx"; // Đặt tên tệp Excel mong muốn
        document.body.appendChild(a);
        a.click();
        URL.revokeObjectURL(url);
      })
      .catch(function (error) {
        console.error("Xuất ra Excel thất bại:", error);
      });
  };

  $scope.sortableColumns = [
    { name: "importReceiptId", label: "Mã phiếu nhập" },
    // { name: 'modifyDate', label: 'Thời gian' },
    { name: "user.fullName", label: "Tên người nhập" },
    { name: "supplier.supplierName", label: "Tên nhà cung cấp" },
    { name: "totalAmount", label: "Tổng tiền" },
    { name: "importDate", label: "Ngày nhập" },
  ];

  $scope.sortByColumn = function (columnName) {
    if ($scope.sortColumn === columnName) {
      $scope.sortReverse = !$scope.sortReverse;
    } else {
      $scope.sortColumn = columnName;
      $scope.sortReverse = false;
    }

    $scope.items.sort(function (a, b) {
      var aValue = a[columnName];
      var bValue = b[columnName];
      if (columnName === "user.fullName") {
        aValue = a.user.fullName;
        bValue = b.user.fullName;
      }

      if (columnName === "supplier.supplierName") {
        aValue = a.supplier.supplierName;
        bValue = b.supplier.supplierName;
      }
      if (typeof aValue === "string") {
        aValue = aValue.toLowerCase();
      }
      if (typeof bValue === "string") {
        bValue = bValue.toLowerCase();
      }

      if (aValue < bValue) {
        return $scope.sortReverse ? 1 : -1;
      } else if (aValue > bValue) {
        return $scope.sortReverse ? -1 : 1;
      }
      return 0;
    });
  };

  $scope.initialize = function () {
    // Load product
    $http.get("/rest/productdetails/loadall").then((resp) => {
      $scope.prods = resp.data;
      $scope.prods.sort((a, b) =>
        a.product.productName.localeCompare(b.product.productName)
      );
    });

    //load import
    $http.get("/rest/importReceipt").then((resp) => {
      $scope.items = resp.data;
      $scope.items.forEach((item) => {
        item.importDate = new Date(item.importDate);
        item.totalAmount = 0; // Khởi tạo giá trị totalAmount
      });
      $scope.items.sort((a, b) => b.importDate - a.importDate);
      $scope.pager.first();
    });

    //load supplier
    $http.get("/rest/supplier/displaysupplier").then((resp) => {
      $scope.importSup = resp.data;
      $scope.pager.first();
    });

    $http.get("/rest/importReceiptDetails").then((resp) => {
      $scope.importDetail = resp.data;
      $scope.pager.first();
      $scope.importDetail.forEach((detail) => {
        //tinh tong tien tu phieu nhap chi tiet
        detail.totalAmount = detail.price * detail.quantity;

        //tim nhung id phieu nhap tuong ung dua tren importReceiptID
        const tuongungItem = $scope.items.find(
          (item) =>
            item.importReceiptId === detail.importReceipt.importReceiptId
        );

        //Neu tim thay id phieu nhap tuong ung trong danh sach
        if (tuongungItem) {
          //tinh tong tien cho phieu nhap bang cach cong them tong tien chi tiet vua tinh vao tong hien tai
          tuongungItem.totalAmount += detail.totalAmount;
        } else {
          console.log(`khong tim thay ${detail.importReceipt.importReceiptId}`);
        }

        // tao bien updatetotaldata gui yeu cau len may chu
        const updateTotalData = {
          totalAmount: tuongungItem.totalAmount,
        };

        $http
          .put(
            `/rest/importReceipt/updateTotal/${tuongungItem.importReceiptId}`,
            updateTotalData
          )
          .then((response) => {})
          .catch((error) => {
            // Xử lý lỗi
          });
      });
    });
  };

  $scope.initialize();

  //	Hiển thị lên form
  $scope.edit = function (items) {
    $scope.form = angular.copy(items);
  };

  //	Xóa form
  $scope.reset = function () {
    $scope.form = {};
    $scope.form.totalAmount = 0;
  };

  $scope.resetDetail = function () {
    $scope.formDetal = {};
  };

  //load chi tiết phiếu nhập
  $scope.loadImportDetail = function (importReceiptId) {
    $http
      .get("/rest/importReceiptDetails/getImportDetails/" + importReceiptId)
      .then((resp) => {
        console.log(resp.data);
        $scope.importDetail = resp.data;
        $("#detailsModal").modal("show");
      });
  };

  //format tien te vnd
  $scope.formatToVND = function (amount) {
    // Logic để định dạng số amount sang định dạng VND
    return amount.toLocaleString("vi-VN", {
      style: "currency",
      currency: "VND",
    });
  };

  //	Thêm mới phiếu nhập
  $scope.create = function () {
    //khong chon nha cung cap
    if (!$scope.form.supplier || !$scope.form.supplier.supplierId) {
      Swal.fire({
        icon: "error",
        title: "Thất bại",
        text: "Vui lòng chọn nhà cung cấp!",
      });
      return;
    }
    $http.get("/user/Idprofile").then((resp) => {
      var userID = resp.data;
      // Gọi API để lấy đầy đủ thông tin người dùng
			$http.get("/user/" + userID).then(userResp => {
        var fullUserData = userResp.data;
				$scope.form.user = fullUserData;

        var importItem = angular.copy($scope.form);
				importItem.user = fullUserData;
        importItem.deleted = false;
        importItem.importDate = new Date();
        importItem.totalAmount = 0;
        $http.post('/rest/importReceipt/createImport', importItem).then((resp) => {
          resp.data.importDate = new Date(resp.data.importDate);
          resp.data.totalAmount = 0;
          $scope.items.push(resp.data);
          $scope.initialize();
          $scope.reset();
          Swal.fire({
						icon: 'success',
						title: 'Thành công',
						text: 'Thêm mới thành công!',
					});
          $scope.initialize();
        })
        .catch((error) => {
          $scope.initialize();
          $scope.errorMessage = "Lỗi!!";
          $("#errorModal").modal("show"); // Show the modal
          console.log("Error", error);
        });
    });
      })
          
  };

  // Thêm chi tiết phiếu nhập
  $scope.createDetail = function () {
    //khong chon phieu nhap
    if (
      !$scope.formDetal.importReceipt ||
      !$scope.formDetal.importReceipt.importReceiptId
    ) {
      Swal.fire({
        icon: "error",
        title: "Thất bại",
        text: "Vui lòng chọn phiếu nhập!",
      });
      return;
    }
    //khong chon san pham
    if (
      !$scope.formDetal.productDetail ||
      !$scope.formDetal.productDetail.productDetailID
    ) {
      Swal.fire({
        icon: "error",
        title: "Thất bại",
        text: "Vui lòng chọn sản phẩm!",
      });
      return;
    }
    //bo trong so luong
    if (!$scope.formDetal.quantity) {
      Swal.fire({
        icon: "error",
        title: "Thất bại",
        text: "Vui lòng nhập số lượng là số lớn hơn 0!",
      });
      return;
    }
    if (
      !/^\d+$/.test($scope.formDetal.quantity) ||
      parseInt($scope.formDetal.quantity) <= 0
    ) {
      Swal.fire({
        icon: "error",
        title: "Thất bại",
        text: "Số lượng phải là số dương!!!",
      });
      return;
    }
    //bo trong gia
    if (!$scope.formDetal.price) {
      Swal.fire({
        icon: "error",
        title: "Thất bại",
        text: "Vui lòng nhập đơn giá là số lớn hơn 0!!",
      });
      return;
    }
    if (
      !/^\d+$/.test($scope.formDetal.price) ||
      parseInt($scope.form.price) <= 0
    ) {
      Swal.fire({
        icon: "error",
        title: "Thất bại",
        text: "Giá phải là số dương!!!",
      });
      return;
    }

    let newItem = angular.copy($scope.formDetal);
    newItem.deleted = false;
    $http
      .post(`/rest/importReceiptDetails/createImportDetailss`, newItem)
      .then((response) => {
        let data = response.data;
        $scope.importDetail.push(data);
        $scope.reset();
        $scope.initialize();
        Swal.fire({
          icon: 'success',
          title: 'Thành công',
          text: 'Thêm chi tiết phiếu nhập thành công!',
        })
      })
      .catch((error) => {
        alert("Lỗi");
        console.log("Error", error);
      });
  };

  $scope.updateSizes = function () {
    // Lấy sản phẩm chi tiết được chọn
    var selectedProductDetailID = $scope.form.productDetail.productDetailID;

    // Tạo một mảng mới để lưu trữ các size tương ứng
    $scope.filteredSizes = [];

    // Lặp qua danh sách sản phẩm để tìm sản phẩm chi tiết đã chọn
    angular.forEach($scope.prods, function (product) {
      if (product.productDetailID === selectedProductDetailID) {
        // Nếu tìm thấy, thêm size của sản phẩm vào mảng filteredSizes
        $scope.filteredSizes.push(product.size);
      }
    });
  };

  // Hàm lọc danh sách prods để loại bỏ các sản phẩm trùng tên và màu
  $scope.uniqueProducts = function (products) {
    var uniqueProducts = [];
    var seen = {};

    angular.forEach(products, function (product) {
      var key = product.product.productName;
      if (!seen[key]) {
        seen[key] = true;
        uniqueProducts.push(product);
      }
    });

    return uniqueProducts;
  };

  $scope.selectedProduct = null;
  $scope.selectedSize = null;
  $scope.selectedColor = null;

  $scope.updateSizesAndColors = function () {
    if ($scope.selectedProduct) {
      $scope.sizes = $scope.selectedProduct.sizes;
      $scope.colors = $scope.selectedProduct.colors;
    } else {
      $scope.sizes = [];
      $scope.colors = [];
    }
  };
  console.log($scope.updateSizesAndColors());

  $(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})

  $('.exportPdf').click(function() {

		let timerInterval
		Swal.fire({
			icon: 'info',
			title: 'Đang xuất file',
			html: 'Cần phải chờ trong <b></b>s.',
			timer: 2000,
			timerProgressBar: true,
			didOpen: () => {
				Swal.showLoading()
				const b = Swal.getHtmlContainer().querySelector('b')
				timerInterval = setInterval(() => {
					b.textContent = Swal.getTimerLeft()
				}, 100)
			},
			willClose: () => {
				clearInterval(timerInterval)
			}
		}).then((result) => {
			/* Read more about handling dismissals below */
			if (result.dismiss === Swal.DismissReason.timer) {
				console.log('I was closed by the timer')

				//code xuất file
				$scope.exportPdf();
			}

		})

	});

  $('.exportExcel').click(function() {

		let timerInterval
		Swal.fire({
			icon: 'info',
			title: 'Đang xuất file',
			html: 'Cần phải chờ trong <b></b>s.',
			timer: 2000,
			timerProgressBar: true,
			didOpen: () => {
				Swal.showLoading()
				const b = Swal.getHtmlContainer().querySelector('b')
				timerInterval = setInterval(() => {
					b.textContent = Swal.getTimerLeft()
				}, 100)
			},
			willClose: () => {
				clearInterval(timerInterval)
			}
		}).then((result) => {
			/* Read more about handling dismissals below */
			if (result.dismiss === Swal.DismissReason.timer) {
				console.log('I was closed by the timer')

				//code xuất file
				$scope.exportExcel();
			}

		})

	});

  //search
	$scope.searchByName = function(){
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/importReceipt/searchImport", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.items = resp.data;
				$scope.pager.first();
			}).catch(error => {
				console.log("Error", error);
				$scope.pager.first();
			});
		}else {
			// Nếu không có từ khóa tìm kiếm, hiển thị tất cả danh mục
			$scope.initialize();
		}
	}

  //	Phân trang
  $scope.pager = {
    page: 0,
    size: 5,
    getPageNumbers: function () {
      var pageCount = this.count;
      var currentPage = this.page + 1;
      var visiblePages = [];

      if (pageCount <= 3) {
        for (var i = 1; i <= pageCount; i++) {
          visiblePages.push({ value: i });
        }
      } else {
        if (currentPage <= 2) {
          visiblePages.push(
            { value: 1 },
            { value: 2 },
            { value: 3 },
            { value: "..." }
          );
        } else if (currentPage >= pageCount - 1) {
          visiblePages.push(
            { value: "..." },
            { value: pageCount - 2 },
            { value: pageCount - 1 },
            { value: pageCount }
          );
        } else {
          visiblePages.push(
            { value: "..." },
            { value: currentPage - 1 },
            { value: currentPage },
            { value: currentPage + 1 },
            { value: "..." }
          );
        }
      }
      console.log("visiblePages", visiblePages);
      return visiblePages;
    },
    get items() {
      var start = this.page * this.size;
      return $scope.items.slice(start, start + this.size);
    },
    get count() {
      return Math.ceil((1.0 * $scope.items.length) / this.size);
    },
    first() {
      this.page = 0;
      $scope.visiblePages = this.getPageNumbers();
      console.log("Đã click nút first");
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