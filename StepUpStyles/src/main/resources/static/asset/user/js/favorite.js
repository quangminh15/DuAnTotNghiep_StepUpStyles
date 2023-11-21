app.filter('unsafeHtml', ['$sce', function($sce) {
	return function(val) {
		return $sce.trustAsHtml(val);
	};
}]);

app.controller("favorite-ctrl", function($scope, $http) {
	//Linh
	$scope.userItemsFavorite = [];
	$scope.userRatings = []
	$scope.allreviews = []
	$scope.check = function(product) {
		$http.get('/rest/favorites/check/' + product.productID)
			.then(function(response) {
				$scope.productbyids = response.data;
				console.log($scope.productbyids.favoriteId);
				console.log($scope.productbyids);
				if (!$scope.productbyids) {
					$http.post('/rest/favorites/' + product.productID)
						.then(function(response) {
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
								title: 'Đã thêm sản phẩm ' + product.productName + ' vào danh sách yêu thích',

							})
							$scope.getAllUserFavorite();
							updateFavoriteCount();
						})
						.catch(function(error) {
							console.error('Lỗi khi thêm sản phẩm vào danh sách yêu thích: ' + error);
						});
				} else {
					$http.delete('/rest/favorites/delete/' + product.productID)
						.then(function(response) {
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
								icon: 'error',
								title: 'Đã xóa sản phẩm ' + $scope.productbyids.product.productName + ' khỏi danh sách yêu thích',

							})
							$scope.getAllUserFavorite();
							updateFavoriteCount();
						})
						.catch(function(error) {
							console.error('Lỗi khi xóa sản phẩm khỏi danh sách yêu thích: ' + error);
						});
				}
			})
			.catch(function(error) {
				console.error('Error ' + error);
			});

	}


	$scope.deleteFavoriteProduct = function(product) {
		Swal.fire({
			title: 'Xác nhận xóa sản phẩm yêu thích?',
			text: 'Bạn có chắc chắn muốn xóa sản phẩm ' + product.productName + ' khỏi danh sách yêu thích?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonText: 'Xóa',
			cancelButtonText: 'Hủy',
		}).then(function(result) {
			if (result.isConfirmed) {
				// Nếu người dùng xác nhận xóa, thì gửi yêu cầu xóa sản phẩm yêu thích
				$http.delete('/rest/favorites/delete/' + product.productID)
					.then(function(response) {
						$scope.getAllUserFavorite();
						updateFavoriteCount();
					})
					.catch(function(error) {
						console.error('Lỗi khi xóa sản phẩm yêu thích: ' + error);
					});
			}
		});
	};


	$scope.getAllUserFavorite = function() {
		$http.get("/rest/favorites/getUserFavorite").then(function(response) {
			$scope.userItemsFavorite = response.data
			$scope.favoritePager.first()
			$scope.userItemsFavorite.forEach(items => {
				$http.get("/rest/productimages/loadbyproduct/" + items.product.productID).then(resp => {
					items.product.image = resp.data;
				})
				$http.get("/rest/discount/loadbyproduct/" + items.product.productID).then(resp => {
					items.product.discount = resp.data.filter(discount => !discount.deleted);
				})
			})
		})
	}

	$scope.isFavorited = function(productId) {
		// Kiểm tra productId có trong danh sách sản phẩm yêu thích
		return $scope.userItemsFavorite.some(function(item) {
			return item.product.productID === productId;
		});
	};

	// Hàm cập nhật trạng thái yêu thích
	$scope.getAllUserFavorite();

	//Hiển thị đánh giá theo mã sản phẩm
	$scope.getReviewByProduct = function(productID) {
		$http.get("/rest/reviews/loadbyproducts/" + productID).then(resp => {
			$scope.allreviews = resp.data;
			$scope.reviewPager.first()
			$scope.filterByRating(null);
			$scope.countReviews($scope.allreviews);
			$scope.ratings = $scope.allreviews.map(function(review) {
				return review.rating;
			});
			$scope.averageRating = calculateAverageRating($scope.ratings);
			if ($scope.reviewCounts.total === 0) {
				$scope.noRating = "Chưa có đánh giá nào";
				$scope.noReviewsMessage = "Chưa có đánh giá nào";
			} else {
				$scope.noRating = "";
			}
		}).catch(error => {
			console.log("Error", error);
		});

	};

	//Đếm số lượng đánh giá
	$scope.countRating = function() {

	}

	//Lưu mã sp trên local storage
	$scope.saveProductID = function(productID) {
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

	//Đếm số lượt đánh giá
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


	//Phân trang đánh giá sản phẩm
	$scope.reviewPager = {
		page: 0,
		size: 4,
		length: 0,
		getReviewPageNumbers: function() {
			var reviewPageCount = this.count;
			var reviewCurrentPage = this.page + 1;
			var reviewVisiblePages = [];

			if (reviewPageCount <= 3) {
				for (var i = 1; i <= reviewPageCount; i++) {
					reviewVisiblePages.push({ value: i });
				}
			} else {
				if (reviewCurrentPage <= 2) {
					reviewVisiblePages.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
				} else if (reviewCurrentPage >= reviewPageCount - 1) {
					reviewVisiblePages.push({ value: '...' }, { value: reviewPageCount - 2 }, { value: reviewPageCount - 1 }, { value: reviewPageCount });
				} else {
					reviewVisiblePages.push({ value: '...' }, { value: reviewCurrentPage - 1 }, { value: reviewCurrentPage }, { value: reviewCurrentPage + 1 }, { value: '...' });
				}
			}
			return reviewVisiblePages;
		},
		get allreviews() {
			var start = this.page * this.size;

			return $scope.filterItemRating.slice(start, start + this.size);
		},
		get count() {
			if ($scope.filterItemRating) {
				length = $scope.filterItemRating.length;
			} else {
				length = $scope.allreviews.length
			}
			return Math.ceil(1.0 * length / this.size);
		},
		first() {
			this.page = 0;
			$scope.reviewVisiblePages = this.getReviewPageNumbers();
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
			$scope.reviewVisiblePages = this.getReviewPageNumbers();
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
			$scope.reviewVisiblePages = this.getReviewPageNumbers();
		},
		last() {
			this.page = this.count - 1;
			$scope.reviewVisiblePages = this.getReviewPageNumbers();
		},
		gotoReview(reviewPageNumber) {
			if (reviewPageNumber >= 1 && reviewPageNumber <= this.count) {
				this.page = reviewPageNumber - 1;
				$scope.reviewVisiblePages = this.getReviewPageNumbers();
			}
		},
	};

	//Phân trang yêu thích sản phẩm
	$scope.favoritePager = {
		page: 0,
		size: 8,
		getFavoritePageNumbers: function() {
			var favoritePageCount = this.count;
			var favoriteCurrentPage = this.page + 1;
			var favoriteVisiblePages = [];

			if (favoritePageCount <= 3) {
				for (var i = 1; i <= favoritePageCount; i++) {
					favoriteVisiblePages.push({ value: i });
				}
			} else {
				if (favoriteCurrentPage <= 2) {
					favoriteVisiblePages.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
				} else if (favoriteCurrentPage >= favoritePageCount - 1) {
					favoriteVisiblePages.push({ value: '...' }, { value: favoritePageCount - 2 }, { value: favoritePageCount - 1 }, { value: favoritePageCount });
				} else {
					favoriteVisiblePages.push({ value: '...' }, { value: favoriteCurrentPage - 1 }, { value: favoriteCurrentPage }, { value: favoriteCurrentPage + 1 }, { value: '...' });
				}
			}
			return favoriteVisiblePages;
		},
		get userItemsFavorite() {
			var start = this.page * this.size;
			return $scope.userItemsFavorite.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.userItemsFavorite.length / this.size);
		},
		first() {
			this.page = 0;
			$scope.favoriteVisiblePages = this.getFavoritePageNumbers();
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
			$scope.favoriteVisiblePages = this.getFavoritePageNumbers();
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
			$scope.favoriteVisiblePages = this.getFavoritePageNumbers();
		},
		last() {
			this.page = this.count - 1;
			$scope.favoriteVisiblePages = this.getFavoritePageNumbers();
		},
		gotoFavorite(favoritePageNumber) {
			if (favoritePageNumber >= 1 && favoritePageNumber <= this.count) {
				this.page = favoritePageNumber - 1;
				$scope.favoriteVisiblePages = this.getFavoritePageNumbers();
			}
		},
	};

	// Hàm lọc đánh giá theo số sao
	$scope.filterByRating = function(rating) {
		if (rating == null) {
			$scope.filterItemRating = $scope.allreviews;
		} else {
			$scope.filterItemRating = $scope.allreviews.filter(function(review) {
				return review.rating == rating;
			})
		}
	}

	$scope.filterByRatingAndCheck = function(rating) {
		$scope.selectedRating = rating
		$scope.filterByRating(rating)
		if ($scope.filterItemRating.length === 0) {
			$scope.noReviewsMessage = "Chưa có đánh giá nào";
		} else {
			$scope.noReviewsMessage = "";
		}
		$scope.reviewPager.first()
	}


	//Kiểm tra selected nút chọn 
	$scope.selectedRating = null;
	$scope.isButtonSelected = function(rating) {
		return $scope.selectedRating === rating;
	};

	//Hiển thị điếm đánh giá trên sản phẩm
	$scope.getStarAvgs = function(avgRating) {
		console.log("rate", avgRating);
		var numStars = Math.floor(avgRating); // Số sao nguyên
		var hasHalfStar = avgRating % 1 !== 0; // Có nửa sao hay không
		var stars = [];
		for (var i = 0; i < 5; i++) {
			if (i < numStars) {
				stars.push("fa fa-star");
			} else if (hasHalfStar) {
				stars.push("fa fa-star-half-o");
				hasHalfStar = false; // Đảm bảo chỉ thêm 1 lần nửa sao
			} else {
				stars.push("fa fa-star-o");
			}
		}
		//		console.log("Start", stars);
		return stars;
	};
	//Lọc đánh giá theo điểm đánh giá
	// Add this inside your AngularJS controller
	$scope.filterByAvgs = function(selectedRating) {
		// Existing filtering code...

		// Lọc dựa trên điểm đánh giá
		if (selectedRating) {
			filteredRates = filteredRates.filter(function(item) {
				// Assuming the star rating is stored in item.rating
				return item.rating >= selectedRating;
			});
		}

		// Continue with the rest of your filtering logic...

		// Update the filtered items in the scope
		$scope.productitems = filteredRates;

		// Reset or update your pagers as needed
		$scope.pager.first();
		$scope.DiscountPager.first();
		$scope.FeaturedPager.first();
	};




	//Linh end 

	//quangminh bắt đầu
	$scope.productitems = [];
	$scope.sizess = [];
	$scope.colorss = [];
	$scope.colors = [];
	$scope.sizes = [];
	$scope.brans = [];
	$scope.filteredColors = [];
	$scope.productDetails = [];
	$scope.size = '';
	$scope.color = '';
	$scope.searchKeyword = '';
	$scope.searchedProductItems = [];
	$scope.discountedProducts = [];
	$scope.featureds = [];
	$scope.productitems = [];

	$scope.allProductitems = [];

	$scope.trustedHtml = function(htmlCode) {
		return $sce.trustAsHtml(htmlCode);
	};

	// Lắng nghe sự kiện click trên lớp phủ
	var overlay = document.getElementById("overlay");
	if (overlay) {
		overlay.addEventListener("click", function(event) {
			// Kiểm tra xem phần tử được ấn có phải là lớp phủ hay không
			if (event.target === overlay) {
				// Ẩn lớp phủ khi vùng trống được ấn
				overlay.style.display = "none";
			}
		});
	} else {
		console.error("Không tìm thấy lớp phủ.");
	}
	// Lắng nghe sự kiện click trên lớp phủ

	$scope.getProductsAndNavigate = function(brandID) {
		localStorage.setItem('brandID', brandID);
		window.location.href = '/list_products';
	};

	$scope.chuyenTrang = function() {
		$scope.pager.first();
		$scope.DiscountPager.first();
		$scope.FeaturedPager.first();
	};



	// Tìm kiếm START 

	// Hàm ẩn lớp phủ bắt đầu 
	$scope.hideOverlay = function() {
		var overlay = document.getElementById("overlay");
		if (overlay) {
			overlay.style.display = "none";
		} else {
			console.error("Không tìm thấy lớp phủ.");
		}
	}
	// Hàm ẩn lớp phủ kết thúc

	// Sử dụng hàm ẩn lớp phủ trong hàm searchProductByName
	$scope.searchProductByName = function() {
		if ($scope.searchKeyword && $scope.searchKeyword.trim() !== "") {
			$http.get("/rest/products/search", {
				params: { keyword: $scope.searchKeyword }
			}).then(resp => {
				$scope.searchedProductItems = resp.data.filter(item => item.deleted === false && item.activities === true);
				$scope.searchedProductItems.forEach(items => {
					$http.get("/rest/productimages/loadbyproduct/" + items.productID).then(resp => {
						items.image = resp.data;
					})
				})

				$scope.searchedProductItems.forEach(item => {
					$http.get("/rest/discount/loadbyproduct/" + item.productID).then(resp => {
						item.discount = resp.data.filter(discount => !discount.deleted);
					})
				})

				if ($scope.searchedProductItems.length === 0) {
					$scope.initialize();
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không tìm thấy sản phẩm có tên ' + $scope.searchKeyword,
					});

					// Gọi hàm ẩn lớp phủ
					hideOverlay();
				} else {
					// Hiển thị lớp phủ khi có sản phẩm được tìm thấy
					var overlay = document.getElementById("overlay");
					if (overlay) {
						overlay.style.display = "block";
					} else {
						console.error("Không tìm thấy lớp phủ.");
					}
				}

			}).catch(error => {
				Swal.fire({
					icon: 'error',
					title: 'Thất bại',
					text: 'Lỗi khi tìm kiếm sản phẩm!',
				});
				console.log("Error", error);
				$scope.chuyenTrang();
			});
		} else {
			$scope.initialize();
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không tìm thấy tên sản phẩm mà bạn mong muốn!',
			});

			// Gọi hàm ẩn lớp phủ
			hideOverlay();
		}
	};

	// Tìm kiếm END 

	//load product trang sản phẩm bắt đầu
	$scope.loadproduct = function() {
		$http.get("/rest/products/loadallNoDeletedAndActivitiesTrue").then(resp => {
			$scope.productitems = resp.data;

			const productImagePromises = $scope.productitems.map(item => {
				return $http.get("/rest/productimages/loadbyproduct/" + item.productID);
			});

			const discountPromises = $scope.productitems.map(item => {
				return $http.get("/rest/discount/loadbyproduct/" + item.productID);
			});

			const productDetailPromises = $scope.productitems.map(item => {
				return $http.get("/rest/productdetails/loadbyproduct/" + item.productID);
			});

			Promise.all(productImagePromises)
				.then(responses => {
					responses.forEach((resp, index) => {
						$scope.productitems[index].image = resp.data;
					});
				})
				.catch(error => {
					console.error(error);
				});

			Promise.all(discountPromises)
				.then(responses => {
					responses.forEach((resp, index) => {
						$scope.productitems[index].discount = resp.data.filter(discount => !discount.deleted);
					});
					$scope.chuyenTrang();
				})
				.catch(error => {
					console.error(error);
				});

			Promise.all(productDetailPromises)
				.then(responses => {
					responses.forEach((resp, index) => {
						$scope.productitems[index].productDetails = resp.data.filter(productDetails => !productDetails.deleted);
						$scope.productitems[index].productDetails.forEach(item => {
							if (item.size && item.size.activities && !item.size.deleted && !$scope.sizes.some(c => c.sizeID === item.size.sizeID)) {
								$scope.sizes.push(item.size);
							}
							if (item.color && item.color.activities && !item.color.deleted && !$scope.colors.some(c => c.colorID === item.color.colorID)) {
								$scope.colors.push(item.color);
							}
						});
					});
				})
				.then(() => {
					//Linh hển thị sao trên sản phẩm
					$scope.productitems.forEach(item => {
						$http.get("/rest/reviews/loadbyproducts/" + item.productID).then(resp => {
							$scope.all = resp.data;
							$scope.ratings = $scope.all.map(review => review.rating);
							$scope.average = calculateAverageRating($scope.ratings);
							item.avgrev = $scope.average;
						}).catch(error => {
							console.log("Error", error);
						});
					});
					//Linh end
					$scope.chuyenTrang();
					$scope.allProductitems = JSON.parse(JSON.stringify($scope.productitems));
					console.log("$scope.allProductitems: 0", $scope.allProductitems);
					console.log("$scope.productitems: 0", $scope.productitems);
					$scope.$apply();
				})
				.catch(error => {
					console.error(error);
				});
		});
	};
	//load product trang sản phẩm kết thúc

	//load sản phẩm theo brand bắt đầu
	$scope.getProductsByBrand = function(brandID) {
		$http.get("/rest/products/loadByBrandId/" + brandID).then(function(resp) {
			// Lưu trữ các sản phẩm mới vào biến mới
			$scope.productitems = resp.data.filter(item => item.activities && !item.deleted);

			$scope.productitems.forEach(items => {
				$http.get("/rest/productimages/loadbyproduct/" + items.productID).then(resp => {
					items.image = resp.data;
				});
			});

			$scope.productitems.forEach(item => {
				$http.get("/rest/discount/loadbyproduct/" + item.productID).then(resp => {
					item.discount = resp.data.filter(discount => !discount.deleted);
				});
			});

			// Cập nhật các biến đếm và dữ liệu liên quan bắt đầu
			$http.get("/rest/products/loadallNoDeletedAndActivitiesTrue").then(resp => {
				// Sử dụng biến mới để không đè lên giá trị của $scope.productitems
				const productImagePromises = $scope.productitems.map(item => {
					return $http.get("/rest/productimages/loadbyproduct/" + item.productID);
				});

				const discountPromises = $scope.productitems.map(item => {
					return $http.get("/rest/discount/loadbyproduct/" + item.productID);
				});

				const productDetailPromises = $scope.productitems.map(item => {
					return $http.get("/rest/productdetails/loadbyproduct/" + item.productID);
				});

				Promise.all(productImagePromises)
					.then(responses => {
						responses.forEach((resp, index) => {
							$scope.productitems[index].image = resp.data;
						});
					})
					.catch(error => {
						console.error(error);
					});

				Promise.all(discountPromises)
					.then(responses => {
						responses.forEach((resp, index) => {
							$scope.productitems[index].discount = resp.data.filter(discount => !discount.deleted);
						});
						$scope.chuyenTrang();
					})
					.catch(error => {
						console.error(error);
					});

				Promise.all(productDetailPromises)
					.then(responses => {
						responses.forEach((resp, index) => {
							$scope.productitems[index].productDetails = resp.data.filter(productDetails => !productDetails.deleted);
							$scope.productitems[index].productDetails.forEach(item => {
								if (item.size && item.size.activities && !item.size.deleted && !$scope.sizes.some(c => c.sizeID === item.size.sizeID)) {
									$scope.sizes.push(item.size);
								}
								if (item.color && item.color.activities && !item.color.deleted && !$scope.colors.some(c => c.colorID === item.color.colorID)) {
									$scope.colors.push(item.color);
								}
							});
						});
					})
					.then(() => {
						$scope.chuyenTrang();
						// Gán giá trị của biến mới vào $scope.productitems
						$scope.allProductitems = JSON.parse(JSON.stringify($scope.productitems));
					})
					.catch(error => {
						console.error(error);
					});
			});
			// Cập nhật các biến đếm và dữ liệu liên quan kết thúc
		}).catch(function(error) {
			console.error('Error occurred while fetching products by brand:', error);
		});
	};
	//load sản phẩm theo brand kết thúc

	//Đếm sản phẩm hiển thị trang sản phẩm bắt đầu
	$scope.getProductCountCategory = function(categoryID) {
		return $scope.allProductitems.filter(product => product.category.categoryID === categoryID).length;
	};
	$scope.getProductCountBrand = function(brandID) {
		return $scope.allProductitems.filter(product => product.brand.brandID === brandID).length;
	};

	// Hàm đếm số lượng sản phẩm theo size
	$scope.getSizeCount = function(sizeID) {
		return $scope.allProductitems.filter(item => {
			return item.productDetails.some(detail => {
				return detail.size && detail.size.sizeID === sizeID;
			});
		}).length;
	};

	// Hàm đếm số lượng sản phẩm theo màu sắc
	$scope.getColorCount = function(colorID) {
		return $scope.allProductitems.filter(item => {
			return item.productDetails.some(detail => {
				return detail.color && detail.color.colorID === colorID;
			});
		}).length;
	};
	//Đếm sản phẩm hiển thị trang sản phẩm kết thúc

	$scope.initialize = function() {
		$scope.loadproduct();

		// Tạo danh sách sản phẩm nổi bật
		$http.get("/rest/products/product-featured").then(resp => {
			$scope.featureds = resp.data;
			$scope.featureds.forEach(items => {
				$http.get("/rest/productimages/loadbyproduct/" + items.productID).then(resp => {
					items.image = resp.data;
				})
			})

			$scope.featureds.forEach(item => {
				$http.get("/rest/discount/loadbyproduct/" + item.productID).then(resp => {
					item.discount = resp.data.filter(discount => !discount.deleted);
				})
			})
			$scope.chuyenTrang();
		});


		//load category
		$http.get("/rest/categories/loadallNoDeletedAndActivitiesTrue").then(resp => {
			// Kiểm tra nếu có sản phẩm trong danh mục
			let catesWithData = resp.data.filter(category => {
				return $scope.productitems.some(product => product.category.categoryID === category.categoryID);
			});
			$scope.cates = catesWithData;
			$scope.chuyenTrang();
		});

		//load brand
		$http.get("/rest/brands/loadallNoDeletedAndActivitiesTrue").then(resp => {
			// Kiểm tra nếu có sản phẩm trong thương hiệu
			let brandsWithData = resp.data.filter(brand => {
				return $scope.productitems.some(product => product.brand.brandID === brand.brandID);
			});

			$scope.brans = brandsWithData;
			$scope.chuyenTrang();
		});

		//chuyển sang trang sản phẩm
		var storedBrandID = localStorage.getItem('brandID');
		if (storedBrandID) {
			$scope.getProductsByBrand(storedBrandID);
			localStorage.removeItem('brandID');
		}
	}

	//	Khởi đầu
	$scope.initialize();

	//load trang sản phẩm chi tiết START
	$scope.goToSinglePage = function(productID) {
		window.location.href = `/single_product/${productID}`;
	};

	// Hàm load thông tin sản phẩm từ API
	$scope.loadProductFromLocalStorage = function() {
		var storedProductID = localStorage.getItem('productID');

		$http.get('/rest/products/' + storedProductID).then(function(response) {

			$scope.productDetails = response.data;

			$http.get('/rest/productimages/loadbyproduct/' + storedProductID).then(function(response) {
				$scope.productDetails.image = response.data;
				if ($scope.productDetails.image && $scope.productDetails.image.length > 0) {
					$scope.productDetails.featuredImage = $scope.productDetails.image[0].imagePath;
				}

			}).catch(function(error) {
				console.error('Error fetching product images', error);
			});

			$http.get('/rest/discount/loadbyproduct/' + storedProductID).then(function(response) {
				$scope.productDetails.discount = response.data;
			}).catch(function(error) {
				console.error('Error fetching product discount', error);
			});

			// Gọi API để lấy sản phẩm chi tiết
			$http.get('/rest/productdetails/loadbyproduct/' + storedProductID).then(function(response) {
				$scope.productDetails.productDetail = response.data;
				$scope.productDetails.productDetail.forEach(function(item) {
					if (item.size) {
						$scope.sizess.push(item.size);
					}
					if (item.color) {
						$scope.colorss.push(item.color);
					}
				});
				$scope.sizess = $scope.sizess.filter((v, i, a) => a.findIndex(t => t.sizeNumber === v.sizeNumber) === i);
			}).catch(function(error) {
				console.error('Error fetching product details', error);
			});
			//			console.log('loadProductFromLocalStorage', $scope.productDetails);
		}).catch(function(error) {
			console.error('Error fetching product details', error);
		});
	};

	$scope.loadProductFromLocalStorage();

	$scope.setSelectedSize = function(selectedSize) {
		$scope.size = selectedSize;
		console.log("size đã chọn: ", selectedSize);

		// Lọc danh sách màu dựa trên size đã chọn
		$scope.filteredColors = $scope.productDetails.productDetail
			.filter(function(item) {
				return item.size.sizeNumber === parseFloat(selectedSize);
			})
			.map(function(item) {
				return item.color;
			});

		console.log("Màu lọc được: ", $scope.filteredColors);
	};

	$scope.setSelectedColor = function(selectedColor) {
		$scope.color = selectedColor;

		console.log("color đã chọn: ", selectedColor);
	};

	$scope.updateFeaturedImage = function(imagePath) {
		$scope.productDetails.featuredImage = imagePath;
	};

	//load sản phẩm tương tự START
	$scope.getProductsByCategory = function() {
		var storedProductID = localStorage.getItem('productID');

		$http.get('/rest/products/' + storedProductID).then(function(response) {
			$scope.products = response.data;

			$http.get('/rest/productimages/loadbyproduct/' + storedProductID).then(function(response) {
				$scope.products.image = response.data;
			}).catch(function(error) {
				console.error('Error fetching product images', error);
			});

			$http.get('/rest/discount/loadbyproduct/' + storedProductID).then(function(response) {
				$scope.products.discount = response.data;
			}).catch(function(error) {
				console.error('Error fetching product discount', error);
			});

			$http.get("/rest/products/loadByCategoryId/" + $scope.products.category.categoryID).then(function(resp) {
				$scope.productDetailss = resp.data;

				$scope.productDetailss.forEach(items => {
					$http.get("/rest/productimages/loadbyproduct/" + items.productID).then(resp => {
						items.image = resp.data;
					})
				})

				$scope.productDetailss.forEach(item => {
					$http.get("/rest/discount/loadbyproduct/" + item.productID).then(resp => {
						item.discount = resp.data;
					})
				})
			}).catch(function(error) {
				console.error('Error occurred while fetching products by category:', error);
			});
		}).catch(function(error) {
			console.error('Error fetching product details', error);
		});
	};

	$scope.getProductsByCategory();
	//load sản phẩm tương tự END

	//Load trang sản phẩm chi tiết END

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
				$scope.chuyenTrang();
				break;
			case 'name_desc':
				$scope.productitems.reverse();
				$scope.chuyenTrang();
				break;
			case 'price_asc':
				$scope.sortByPrice();
				$scope.chuyenTrang();
				break;
			case 'price_desc':
				$scope.productitems.sort(function(a, b) {
					return b.price - a.price;
				});
				$scope.chuyenTrang();
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
				$scope.chuyenTrang();
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
					$scope.chuyenTrang();
				} else {
					$scope.productitems = filteredItems;
					$scope.chuyenTrang();
				}
				$scope.chuyenTrang();
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
					$scope.chuyenTrang();
				} else {
					$scope.productitems = filteredItems;
					$scope.chuyenTrang();
				}
				$scope.chuyenTrang();
				break;
			default:
				$scope.initialize();
				$scope.chuyenTrang();
				break;
		}
	};

	//Bộ lọc bắt đầu
	$scope.filterProducts = function() {
		var selectedBrands = document.querySelectorAll('input[name=brand]:checked');
		var selectedCategories = document.querySelectorAll('input[name=category]:checked');
		var selectedColors = document.querySelectorAll('input[name=color]:checked');
		var selectedSizes = document.querySelectorAll('input[name=size]:checked');

		var filteredItems = JSON.parse(JSON.stringify($scope.allProductitems));

		var filterItemByProperty = function(property, selectedIds) {
			if (selectedIds.length > 0) {
				filteredItems = filteredItems.filter(item => {
					return selectedIds.includes(item[property][property + 'ID']);
				});
			}
		};

		var loadProductDetails = function() {
			var promises = filteredItems.map(item => {
				return $http.get("/rest/productdetails/loadbyproduct/" + item.productID);
			});

			return Promise.all(promises).then(responses => {
				responses.forEach((resp, index) => {
					var data = resp.data.filter(productDetails => !productDetails.deleted);
					filteredItems[index].productDetails = data;
					data.forEach(items => {
						if (items.size && items.size.activities && !items.size.deleted && !$scope.sizes.some(c => c.sizeID === items.size.sizeID)) {
							$scope.sizes.push(items.size);
						}
						if (items.color && items.color.activities && !items.color.deleted && !$scope.colors.some(c => c.colorID === items.color.colorID)) {
							$scope.colors.push(items.color);
						}
					});
				});
			}).catch(error => {
				console.error(error);
			});
		};

		filterItemByProperty('brand', Array.from(selectedBrands).map(brand => parseInt(brand.value)));
		filterItemByProperty('category', Array.from(selectedCategories).map(category => parseInt(category.value)));

		if (selectedColors.length > 0) {
			var selectedColorIds = Array.from(selectedColors).map(color => parseInt(color.value));
			console.log("selectedColorIds", selectedColorIds);

			loadProductDetails().then(() => {
				filteredItems = filteredItems.filter(item => {
					if (item.productDetails && Array.isArray(item.productDetails)) {
						return item.productDetails.some(detail => {
							if (detail.color && detail.color.colorID) {
								return selectedColorIds.includes(detail.color.colorID);
							}
							return false;
						});
					}
					return false;
				});

				console.log("filteredItems:", filteredItems);

				if (filteredItems.length === 0) {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không có sản phẩm nào cả. Hãy thử các lựa chọn khác nhé',
					});
					$scope.clearFilters();
				} else {
					filteredItems.forEach(items => {
						$http.get("/rest/productimages/loadbyproduct/" + items.productID).then(resp => {
							items.image = resp.data;
						});
					});

					filteredItems.forEach(item => {
						$http.get("/rest/discount/loadbyproduct/" + item.productID).then(resp => {
							item.discount = resp.data.filter(discount => !discount.deleted);
						});
					});

					loadProductDetails().then(() => {
						$scope.productitems = filteredItems;
						$scope.chuyenTrang();
					});
					$scope.chuyenTrang();
				}
			});
		}

		if (selectedSizes.length > 0) {
			var selectedSizeIds = Array.from(selectedSizes).map(size => parseInt(size.value));
			console.log("selectedSizeIds", selectedSizeIds);

			loadProductDetails().then(() => {
				filteredItems = filteredItems.filter(item => {
					if (item.productDetails && Array.isArray(item.productDetails)) {
						return item.productDetails.some(detail => {
							if (detail.size && detail.size.sizeID) {
								return selectedSizeIds.includes(detail.size.sizeID);
							}
							return false;
						});
					}
					return false;
				});

				console.log("filteredItems:", filteredItems);

				if (filteredItems.length === 0) {
					Swal.fire({
						icon: 'error',
						title: 'Thất bại',
						text: 'Không có sản phẩm nào cả. Hãy thử các lựa chọn khác nhé',
					});
					$scope.chuyenTrang();
					$scope.clearFilters();
				} else {
					filteredItems.forEach(items => {
						$http.get("/rest/productimages/loadbyproduct/" + items.productID).then(resp => {
							items.image = resp.data;
						});
					});

					filteredItems.forEach(item => {
						$http.get("/rest/discount/loadbyproduct/" + item.productID).then(resp => {
							item.discount = resp.data.filter(discount => !discount.deleted);
						});
					});

					loadProductDetails().then(() => {
						$scope.productitems = filteredItems;
					});
					$scope.chuyenTrang();
				}
			});
		}

		if (filteredItems.length === 0) {
			Swal.fire({
				icon: 'error',
				title: 'Thất bại',
				text: 'Không có sản phẩm nào cả. Hãy thử các lựa chọn khác nhé',
			});
			$scope.clearFilters();
			$scope.chuyenTrang();
		} else {
			filteredItems.forEach(items => {
				$http.get("/rest/productimages/loadbyproduct/" + items.productID).then(resp => {
					items.image = resp.data;
				});
			});

			filteredItems.forEach(item => {
				$http.get("/rest/discount/loadbyproduct/" + item.productID).then(resp => {
					item.discount = resp.data.filter(discount => !discount.deleted);
				});
			});

			loadProductDetails().then(() => {
				$scope.productitems = filteredItems;
			});
			$scope.chuyenTrang();
		}

		$scope.chuyenTrang();
	};

	//Hủy trạng thái đã chọn của check box
	$scope.clearFilters = function() {
		var checkboxes = document.querySelectorAll('input[type=checkbox]');
		checkboxes.forEach(function(checkbox) {
			checkbox.checked = false;
		});
		$scope.loadproduct();
		$scope.chuyenTrang();
	};
	//Bộ lọc kết thúc

	//sắp xếp kết thúc

	//load sản phẩm theo danh mục của trang sản phẩm bắt đầu 
	$scope.getProductsByCategory1 = function(categoryID) {
		$http.get("/rest/products/loadByCategoryId/" + categoryID).then(function(resp) {
			$scope.productitems = resp.data;
			$scope.productitems.forEach(items => {
				$http.get("/rest/productimages/loadbyproduct/" + items.productID).then(resp => {
					items.image = resp.data;
				})
				//Linh hàm gọi điểm sao đánh giá
				$http.get("/rest/reviews/loadbyproducts/" + items.productID).then(resp => {
					$scope.all = resp.data;
					$scope.ratings = $scope.all.map(function(review) {
						return review.rating;
					});
					$scope.average = calculateAverageRating($scope.ratings);
					items.avgrev = $scope.average
				}).catch(error => {
					console.log("Error", error);
				});
				//Linh end
			})
			$scope.productitems.forEach(item => {
				$http.get("/rest/discount/loadbyproduct/" + item.productID).then(resp => {
					item.discount = resp.data;
				})
			})

			$scope.chuyenTrang();
		}).catch(function(error) {
			console.error('Error occurred while fetching products by category:', error);
		});
	};
	//load sản phẩm theo danh mục của trang sản phẩm Kết thúc

	//phân trang trang sản phẩm bắt đầu
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
	//phân trang trang sản phẩm kết thúc

	//phân trang trang chủ product featureds START
	$scope.FeaturedPager = {
		page: 0,
		size: 8,
		getFeaturedPageNumbers: function() {
			var FeaturedPageCount = this.count;
			var FeaturedCurrentPage = this.page + 1;
			var FeaturedVisiblePages = [];

			if (FeaturedPageCount <= 3) {
				for (var i = 1; i <= FeaturedPageCount; i++) {
					FeaturedVisiblePages.push({ value: i });
				}
			} else {
				if (FeaturedCurrentPage <= 2) {
					FeaturedVisiblePages.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
				} else if (FeaturedCurrentPage >= FeaturedPageCount - 1) {
					FeaturedVisiblePages.push({ value: '...' }, { value: FeaturedPageCount - 2 }, { value: FeaturedPageCount - 1 }, { value: FeaturedPageCount });
				} else {
					FeaturedVisiblePages.push({ value: '...' }, { value: FeaturedCurrentPage - 1 }, { value: FeaturedCurrentPage }, { value: FeaturedCurrentPage + 1 }, { value: '...' });
				}
			}
			return FeaturedVisiblePages;
		},
		get featureds() {
			var start = this.page * this.size;
			return $scope.featureds.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.featureds.length / this.size);
		},
		first() {
			this.page = 0;
			$scope.FeaturedVisiblePages = this.getFeaturedPageNumbers();
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
			$scope.FeaturedVisiblePages = this.getFeaturedPageNumbers();
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
			$scope.FeaturedVisiblePages = this.getFeaturedPageNumbers();
		},
		last() {
			this.page = this.count - 1;
			$scope.FeaturedVisiblePages = this.getFeaturedPageNumbers();
		},
		FeaturedGoto(FeaturedPageNumber) {
			if (FeaturedPageNumber >= 1 && FeaturedPageNumber <= this.count) {
				this.page = FeaturedPageNumber - 1;
				$scope.FeaturedVisiblePages = this.getFeaturedPageNumbers();
			}
		},
	};
	//phân trang trang chủ product featureds END

	//phân trang trang chủ product discount START
	$scope.DiscountPager = {
		page: 0,
		size: 8,
		getDiscountPageNumbers: function() {
			var DiscountPageCount = this.count;
			var DiscountCurrentPage = this.page + 1;
			var DiscountVisiblePages = [];

			if (DiscountPageCount <= 3) {
				for (var i = 1; i <= DiscountPageCount; i++) {
					DiscountVisiblePages.push({ value: i });
				}
			} else {
				if (DiscountCurrentPage <= 2) {
					DiscountVisiblePages.push({ value: 1 }, { value: 2 }, { value: 3 }, { value: '...' });
				} else if (DiscountCurrentPage >= DiscountPageCount - 1) {
					DiscountVisiblePages.push({ value: '...' }, { value: DiscountPageCount - 2 }, { value: DiscountPageCount - 1 }, { value: DiscountPageCount });
				} else {
					DiscountVisiblePages.push({ value: '...' }, { value: DiscountCurrentPage - 1 }, { value: DiscountCurrentPage }, { value: DiscountCurrentPage + 1 }, { value: '...' });
				}
			}
			return DiscountVisiblePages;
		},
		get discountedProducts() {
			var start = this.page * this.size;
			return $scope.discountedProducts.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.discountedProducts.length / this.size);
		},
		first() {
			this.page = 0;
			$scope.DiscountVisiblePages = this.getDiscountPageNumbers();
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
			$scope.DiscountVisiblePages = this.getDiscountPageNumbers();
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
			$scope.DiscountVisiblePages = this.getDiscountPageNumbers();
		},
		last() {
			this.page = this.count - 1;
			$scope.DiscountVisiblePages = this.getDiscountPageNumbers();
		},
		DiscountGoto(DiscountPageNumber) {
			if (DiscountPageNumber >= 1 && DiscountPageNumber <= this.count) {
				this.page = DiscountPageNumber - 1;
				$scope.DiscountVisiblePages = this.getDiscountPageNumbers();
			}
		},
	};
	//phân trang trang chủ product discount END
	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})
	//quangminh kết thúc
});
