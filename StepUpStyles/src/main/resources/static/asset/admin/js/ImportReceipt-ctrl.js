app.controller("ImportReceipt-ctrl", function ($scope, $http) {
  $scope.items = [];
  $scope.importReceipt = [];
  $scope.importSup = [];
  $scope.form = {};
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

    $scope.exportPdf = function () {
        $http({
            method: 'POST',
            url: '/export-pdf',
            data: $scope.importDetail,
            responseType: 'arraybuffer', // Đặt responseType thành 'arraybuffer' để nhận dữ liệu PDF dưới dạng ArrayBuffer
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(function (response) {
            // Tạo một đối tượng Blob từ dữ liệu PDF và tạo URL để tải xuống
            var blob = new Blob([response.data], { type: 'application/pdf' });
            var url = URL.createObjectURL(blob);

            // Tạo một thẻ a để tải xuống tệp PDF
            var a = document.createElement('a');
            a.href = url;
            a.download = 'import_receipt.pdf';
            document.body.appendChild(a);
            a.click();
            URL.revokeObjectURL(url);
        }).catch(function (error) {
            console.error('Xuất PDF thất bại:', error);
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

  // Hàm để xuất file PDF từ nội dung HTML
  $scope.exportToPDF = function () {
    // Tạo một đối tượng jsPDF
    var doc = new jsPDF();

    // Tạo biến để theo dõi vị trí dòng trong tài liệu PDF
    var yPos = 20;

    // Đặt tiêu đề cho tài liệu PDF
    doc.setFontSize(18);
    doc.text(
      "Phiếu nhập " + $scope.importDetail[0].importReceipt.importReceiptId,
      10,
      yPos
    );
    yPos += 10;

    // Tạo bảng trong tài liệu PDF
    var columns = ["Tên sản phẩm", "Số lượng", "Size", "Màu sắc", "Đơn giá"];
    var data = [];
    data.push([
      $scope.importDetail[0].productDetail.product.productName,
      $scope.importDetail[0].quantity,
      $scope.importDetail[0].productDetail.size.sizeNumber,
      $scope.importDetail[0].productDetail.color.colorName,
      $scope.formatToVND($scope.importDetail[0].price),
    ]);

    doc.autoTable(columns, data, { startY: yPos });
    yPos += 40;

    // Hiển thị tổng tiền
    doc.setFontSize(14);
    doc.text(
      "Tổng tiền: " +
        $scope.formatToVND($scope.importDetail[0].importReceipt.totalAmount),
      10,
      yPos
    );

    // Tạo tên file PDF và tải nó
    var fileName = "phieu_nhap.pdf";
    doc.save(fileName);
  };

  $scope.initialize();

  //	Hiển thị lên form
  $scope.edit = function (items) {
    $scope.form = angular.copy(items);
  };

  //	Xóa form
  $scope.reset = function () {
    $scope.form = {};
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
    if (!$scope.form.supplier || !$scope.form.supplier.supplierID) {
      $scope.errorMessage = "Vui lòng chọn nhà cung cấp!";
      $("#errorModal").modal("show"); // Show the modal
      return;
    }
    $http.get("/api/user").then((resp) => {
      const email = resp.data.username; // Lấy email từ userDetails
      // Truy vấn cơ sở dữ liệu để lấy userID từ email
      $http
        .get("/rest/ImportReceipt/usersByEmail/" + email)
        .then((userResp) => {
          var userID = userResp.data.userID;
          $scope.form.user = { userID: userID }; // Gán userID cho phiếu nhập
          let newItem = angular.copy($scope.form);
          newItem.importDate = new Date(); // Lấy ngày giờ hiện tại
          $http
            .post(`/rest/ImportReceipt/createImp`, newItem)
            .then((response) => {
              let data = response.data;
              data.importDate = new Date(data.importDate); // Chuyển đổi ngày giờ từ response
              data.totalAmount = 0;
              $scope.items.push(data);
              $scope.reset();
              $scope.messageSuccess = "Thêm thành công phiếu nhập";
              $scope.initialize();
              $("#errorModal1").modal("show"); // Show the modal
            })
            .catch((error) => {
              $scope.initialize();
              $scope.errorMessage = "Lỗi!!";
              $("#errorModal").modal("show"); // Show the modal
              console.log("Error", error);
            });
        });
    });
  };

  //ham update phiếu nhập
  $scope.update = function () {
    //khong chon nha cung cap
    if (!$scope.form.supplier || !$scope.form.supplier.supplierID) {
      $scope.errorMessage = "Vui lòng chọn nhà cung cấp!";
      $("#errorModal").modal("show"); // Show the modal
      return;
    }
    //ham update

    $http.get("/api/user").then((resp) => {
      const email = resp.data.username; // Lấy email từ userDetails
      // Truy vấn cơ sở dữ liệu để lấy userID từ email
      $http
        .get("/rest/ImportReceipt/usersByEmail/" + email)
        .then((userResp) => {
          var userID = userResp.data.userID;
          $scope.form.user = { userID: userID }; // Gán userID cho phiếu nhập

          let item = angular.copy($scope.form);
          item.user.userID = userID;
          $http
            .put("/rest/ImportReceipt/updateImp/" + item.importReceiptID, item)
            .then((resp) => {
              var index = $scope.items.findIndex(
                (p) => p.importReceiptID == item.importReceiptID
              );
              $scope.items[index] = item;
              $scope.initialize();
              $scope.messageSuccess = "Cập nhật thành công phiếu nhập";
              $("#errorModal1").modal("show"); // Show the modal
            })
            .catch((error) => {
              alert("Loi cap nhat");
              console.log("Error", error);
            });
        });
    });
  };

  //Gọi đến modal xác nhận
  $scope.confirmDeleteModal = function () {
    $("#confirmDeleteModal").modal("show");
  };

  $scope.confirmDeleteModal1 = function (item) {
    $scope.form = angular.copy(item); // Set form data for confirmation modal
    $("#confirmDeleteModal").modal("show"); // Show the confirmation modal
  };

  //sau khi xác nhận thành công thì xóa
  $scope.confirmDelete = function () {
    // Thực hiện xóa nhóm sản phẩm
    $http
      .delete("/rest/ImportReceipt/deleteImp/" + $scope.form.importReceiptID)
      .then((resp) => {
        var index = $scope.items.findIndex(
          (p) => p.importReceiptID == $scope.form.importReceiptID
        );
        $scope.items.splice(index, 1);
        $scope.reset();
        $scope.messageSuccess = "Xóa thành công phiếu nhập";
        $("#errorModal1").modal("show"); // Show the modal
      })
      .catch((error) => {
        $scope.errorMessage = "Xóa thất bại";
        $("#errorModal").modal("show"); // Show the modal
        console.log("Error", error);
      });

    // Đóng modal xác nhận xóa
    $("#confirmDeleteModal").modal("hide");
  };

  // Thêm chi tiết phiếu nhập
  $scope.createDetail = function () {
    //khong chon phieu nhap
    if (
      !$scope.form.importReceipt ||
      !$scope.form.importReceipt.importReceiptId
    ) {
      $scope.errorMessage = "Vui lòng chọn phiếu nhập!";
      $("#errorModal").modal("show"); // Show the modal
      return;
    }
    //khong chon san pham
    if (
      !$scope.form.productDetail ||
      !$scope.form.productDetail.productDetailID
    ) {
      $scope.errorMessage = "Vui lòng chọn sản phẩm!";
      $("#errorModal").modal("show"); // Show the modal
      return;
    }
    //bo trong so luong
    if (!$scope.form.quantity) {
      $scope.errorMessage = "Vui lòng nhập số lượng!!!";
      $("#errorModal").modal("show"); // Show the modal
      return;
    }
    if (
      !/^\d+$/.test($scope.form.quantity) ||
      parseInt($scope.form.quantity) <= 0
    ) {
      $scope.errorMessage = "Số lượng phải là số dương!!!";
      $("#errorModal").modal("show"); // Show the modal
      return; // Ngừng thực hiện hàm nếu có lỗi
    }
    //bo trong gia
    if (!$scope.form.price) {
      $scope.errorMessage = "Vui lòng nhập giá!!!";
      $("#errorModal").modal("show"); // Show the modal
      return;
    }
    if (!/^\d+$/.test($scope.form.price) || parseInt($scope.form.price) <= 0) {
      $scope.errorMessage = "Giá phải là số dương!!!";
      $("#errorModal").modal("show"); // Show the modal
      return; // Ngừng thực hiện hàm nếu có lỗi
    }

    let newItem = angular.copy($scope.form);
    newItem.deleted = false;
    $http
      .post(`/rest/importReceiptDetails/createImpDetails`, newItem)
      .then((response) => {
        let data = response.data;
        $scope.importDetail.push(data);
        $scope.reset();
        $scope.initialize();
        $scope.messageSuccess = "Thêm thành công chi tiết phiếu nhập";
        $("#errorModal1").modal("show"); // Show the modal
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
