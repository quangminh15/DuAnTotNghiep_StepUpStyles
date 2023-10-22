app.controller("favorite-ctrl", function ($scope, $http) {
    $scope.userItemsFavorite = [];
    $scope.userRatings = []
    //Linh
    $scope.check = function (productID) {
        $http.get('/rest/favorites/check/' + productID)
            .then(function (response) {
                $scope.productbyids = response.data;
                console.log($scope.productbyids.favoriteId);
                if (!$scope.productbyids) {
                    $http.post('/rest/favorites/' + productID)
                        .then(function (response) {
                            console.log("bat thich");
                            // alert("Đã thích sản phẩm ")
                            Swal.fire({
                                icon: 'success',
                                title: 'Thành công',
                                text: 'Sản phẩm đã được thêm vào yêu thích!'
                            })
                        })
                        .catch(function (error) {
                            console.error('Lỗi khi thêm sản phẩm vào danh sách yêu thích: ' + error);
                        });
                    console.log(1);
                } else {
                    $http.delete('/rest/favorites/delete/' + productID)
                        .then(function (response) {
                            console.log("tat thich");
                            alert("Đã hủy thích sản phẩm")
                        })
                        .catch(function (error) {
                            console.error('Lỗi khi xóa sản phẩm khỏi danh sách yêu thích: ' + error);
                        });
                }
            })
            .catch(function (error) {
                console.error('Error ' + error);
            });
    }


	$scope.deleteFavoriteProduct = function(productID) {
        Swal.fire({
            title: 'Xác nhận xóa sản phẩm yêu thích?',
            text: 'Bạn có chắc chắn muốn xóa sản phẩm này khỏi danh sách yêu thích?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy',
        }).then(function(result) {
            if (result.isConfirmed) {
                // Nếu người dùng xác nhận xóa, thì gửi yêu cầu xóa sản phẩm yêu thích
                $http.delete('/rest/favorites/delete/' + productID)
                    .then(function(response) {
                        $scope.getAllUserFavorite();
                    })
                    .catch(function(error) {
                        console.error('Lỗi khi xóa sản phẩm yêu thích: ' + error);
                    });
            }
        });
    };


    $scope.getAllUserFavorite = function () {
        $http.get("/rest/favorites/getUserFavorite").then(function (response) {
            $scope.userItemsFavorite = response.data
            console.log(response.data);
        })
    }

    // $scope.isFavorite = function (productID) {
    //     return $scope.userItemsFavorite.some(function (item) {
    //         return item.product.productID === productID;
    //     });
    // }



	$scope.getAllUserFavorite();

    $scope.getReviewByProduct = function (productID) {
        $http.get("/rest/reviews/loadbyproducts/" + productID).then(resp => {
            $scope.allreviews = resp.data;     
            $scope.countReviews($scope.allreviews);
      
            // Tạo danh sách sao để hiển thị
            $scope.starList = createStarList($scope.averageRating);
            console.log("Sao " + $scope.starList);
            // Tính toán điểm số trung bình
            $scope.ratings = $scope.allreviews.map(function(review) {
                return review.rating;
            });
            $scope.averageRating = calculateAverageRating($scope.ratings);
            // Đếm số lượng đánh giá
            $scope.numRatings = $scope.allreviews.length;
        }).catch(error => {
            console.log("Error", error);
        });
    };

    $scope.saveProductID = function (productID) {
        localStorage.setItem('productID', productID);
        $scope.getReviewByProduct(productID);
    };

    var productID = localStorage.getItem('productID');
    if (productID) {
        $scope.getReviewByProduct(productID);
    } else {
    }

    // Hàm tính toán điểm số trung bình
    function calculateAverageRating(ratings) {
        if (ratings.length === 0) return 0;

        var totalRating = ratings.reduce(function(acc, rating) {
            return acc + rating;
        }, 0);
        return (totalRating / ratings.length).toFixed(1);
    }

    $scope.getStars = function(rating) {
        var stars = [];
        for (var i = 0; i < rating; i++) {
            stars.push(i);
        }
        return stars;
    };

    $scope.reviewCounts = {
        total: 0,
        5: 0,
        4: 0,
        3: 0,
        2: 0,
        1: 0
    };

    $scope.countReviews = function(reviews) {
        $scope.reviewCounts.total = reviews.length;
        reviews.forEach(function(review) {
            $scope.reviewCounts[review.rating] += 1;
        });
    };

    function createStarList(rating) {
        var starList = [];
        for (var i = 0; i < 5; i++) {
            if (rating >= i + 1) {
                starList.push('fa fa-star yellow-star');
            } else if (rating > i) {
                starList.push('fa fa-star-half-o yellow-star');
            } else {
                starList.push('fa fa-star-o yellow-star');
            }
        }
        return starList;
    }

	///////

	

	//Linh end 

	// quangminh bắt đầu
	$scope.productitems = [];

	$scope.initialize = function() {
		//load product
		$http.get("/rest/products/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.productitems = resp.data;
			console.log("123", resp)
			for (var i = 0; i < $scope.productitems.length; i++) {
				var product = $scope.productitems[i];
				var imagePaths = product.imagePaths;
				console.log("Đây nè: " + product.productID + ":", imagePaths);
			}
			$scope.pager.first();
		});

		//load category
		$http.get("/rest/categories/loadallNoDeletedAndActivitiesTrue").then(resp => {
			// Kiểm tra nếu có sản phẩm trong danh mục
			let catesWithData = resp.data.filter(category => {
				return $scope.productitems.some(product => product.category.categoryID === category.categoryID);
			});

			$scope.cates = catesWithData;
			$scope.pager.first();
		});

		//load brand
		$http.get("/rest/brands/loadallNoDeletedAndActivitiesTrue").then(resp => {
			// Kiểm tra nếu có sản phẩm trong danh mục
			let brandsWithData = resp.data.filter(brand => {
				return $scope.productitems.some(product => product.brand.brandID === brand.brandID);
			});

			$scope.brans = brandsWithData;
			$scope.pager.first();
		});


		//load color
		$http.get("/rest/colors/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.colors = resp.data;
			$scope.pager.first();
		});

		//load size
		$http.get("/rest/sizes/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.sizes = resp.data;
			$scope.pager.first();
		});

		//load image
		$http.get("/rest/productimages/loadall").then(resp => {
			$scope.images = resp.data;
			console.log($scope.images)
			$scope.pager.first();
		});
	}

	$scope.getImagePath = function(imagePath) {
		if (imagePath) {
			return imagePath;
		}
		return 'https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg';
	};


	//	Khởi đầu
	$scope.initialize();

	//phân trang
	$scope.pager = {
		page: 0,
		size: 9,
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
		get productitems() {
			var start = this.page * this.size;
			return $scope.productitems.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.productitems.length / this.size);
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

	$scope.goToSinglePage = function(productID) {
		window.location.href = `/single_product/${productID}`;
	};

	//sắp xếp bắt đầu
	$scope.sortByPropertyName = function() {
		$scope.productitems.sort(function(a, b) {
			var nameA = a.productName.toUpperCase();
			var nameB = b.productName.toUpperCase();
			if (nameA < nameB) {
				return -1;
			}
			if (nameA > nameB) {
				return 1;
			}
			return 0;
		});
	};

	$scope.sortByPrice = function() {
		$scope.productitems.sort(function(a, b) {
			return a.price - b.price;
		});
	};

	$scope.filterByOption = function() {
		var selectBox = document.getElementById("sortSelect");
		var selectedValue = selectBox.options[selectBox.selectedIndex].value;

		switch (selectedValue) {
			case 'name_asc':
				$scope.sortByPropertyName();
				$scope.pager.first();
				break;
			case 'name_desc':
				$scope.productitems.reverse();
				$scope.pager.first();
				break;
			case 'price_asc':
				$scope.sortByPrice();
				$scope.pager.first();
				break;
			case 'price_desc':
				$scope.productitems.sort(function(a, b) {
					return b.price - a.price;
				});
				$scope.pager.first();
				break;
			case 'price_0_1tr':
				filteredItems = $scope.productitems.filter(function(item) {
					return item.price >= 0 && item.price <= 1000000;
				});
				if (filteredItems.length === 0) {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không có sản phẩm nào trong khoảng giá đó. Hãy chọn sản phẩm khác nhé',
					});
					$scope.initialize();
				} else {
					$scope.productitems = filteredItems;
				}
				$scope.pager.first();
				break;
			case 'price_1tr_2tr':
				filteredItems = $scope.productitems.filter(function(item) {
					return item.price > 1000000 && item.price <= 2000000;
				});
				if (filteredItems.length === 0) {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không có sản phẩm nào trong khoảng giá đó. Hãy chọn sản phẩm khác nhé',
					});
					$scope.initialize();
				} else {
					$scope.productitems = filteredItems;
				}
				$scope.pager.first();
				break;
			case 'price_2tr_plus':
				filteredItems = $scope.productitems.filter(function(item) {
					return item.price > 2000000;
				});
				if (filteredItems.length === 0) {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không có sản phẩm nào trong khoảng giá đó. Hãy chọn sản phẩm khác nhé',
					});
					$scope.initialize();
				} else {
					$scope.productitems = filteredItems;
				}
				$scope.pager.first();
				break;
			default:
				$scope.initialize();
				break;
		}
	};

	//Bộ lọc nâng cao
	$scope.filterProducts = function() {
		var selectedBrands = document.querySelectorAll('input[name=brand]:checked');
		var selectedCategories = document.querySelectorAll('input[name=category]:checked');
		var selectedColors = document.querySelectorAll('input[name=color]:checked');
		var selectedSizes = document.querySelectorAll('input[name=size]:checked');

		// Biến lưu trữ sản phẩm sau khi lọc
		var filteredItems = $scope.productitems;

		// Lọc dựa trên brand
		if (selectedBrands.length > 0) {
			var selectedBrandIds = [];
			for (var i = 0; i < selectedBrands.length; i++) {
				selectedBrandIds.push(parseInt(selectedBrands[i].value));
			}
			filteredItems = filteredItems.filter(function(item) {
				return selectedBrandIds.includes(item.brand.brandID);
			});
		}

		// Lọc dựa trên category
		if (selectedCategories.length > 0) {
			var selectedCategoryIds = [];
			for (var i = 0; i < selectedCategories.length; i++) {
				selectedCategoryIds.push(parseInt(selectedCategories[i].value));
			}
			filteredItems = filteredItems.filter(function(item) {
				return selectedCategoryIds.includes(item.category.categoryID);
			});
		}

		// Lọc dựa trên color
		if (selectedColors.length > 0) {
			var selectedColorIds = [];
			for (var i = 0; i < selectedColors.length; i++) {
				selectedColorIds.push(parseInt(selectedColors[i].value));
			}
			filteredItems = filteredItems.filter(function(item) {
				return item.productDetails && item.productDetails.some(function(detail) {
					return detail.color && selectedColorIds.includes(detail.color.colorID);
				});
			});
		}

		// Lọc dựa trên size
		if (selectedSizes.length > 0) {
			var selectedSizeIds = [];
			for (var i = 0; i < selectedSizes.length; i++) {
				selectedSizeIds.push(parseInt(selectedSizes[i].value));
			}
			filteredItems = filteredItems.filter(function(item) {
				return item.productDetails && item.productDetails.some(function(detail) {
					return detail.size && selectedSizeIds.includes(detail.size.sizeID);
				});
			});
		}
		if (filteredItems.length === 0) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không có sản phẩm nào cả. Hãy thử các lựa chọn khác nhé',
			});
			//load product
			$http.get("/rest/products/loadallNoDeletedAndActivitiesTrue").then(resp => {
				$scope.productitems = resp.data;
				$scope.pager.first();
			});
		} else {
			$scope.productitems = filteredItems;
		}
		$scope.pager.first();
	};

	//Hủy trạng thái đã chọn của check box
	$scope.clearFilters = function() {
		var checkboxes = document.querySelectorAll('input[type=checkbox]');
		checkboxes.forEach(function(checkbox) {
			checkbox.checked = false;
		});
	};
	//sắp xếp kết thúc

	$scope.getProductsByBrand = function(brandID) {
		$http.get("/rest/products/loadByBrandId/" + brandID).then(function(resp) {
			$scope.productitems = resp.data;
			$scope.pager.first();
		}).catch(function(error) {
			console.error('Error occurred while fetching products by brand:', error);
		});
	};
	// quangminh kết thúc
});
