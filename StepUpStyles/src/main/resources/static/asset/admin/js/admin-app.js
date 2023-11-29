app = angular.module("admin-app", ["ngRoute"]);

app.config(function($routeProvider) {
	$routeProvider
		.when("/indexAdmin", {
			templateUrl: "/templates/admins/index.html",
			controller: "indexAdmin-ctrl"
		})
		.when("/product", {
			templateUrl: "/templates/admins/products/product.html",
			controller: "product-ctrl"
		})
		.when("/productImage", {
			templateUrl: "/templates/admins/products/productimage.html",
			controller: "productimage-ctrl"
		})
		.when("/productsize", {
			templateUrl: "/templates/admins/products/size.html",
			controller: "size-ctrl"
		})
		.when("/brand", {
			templateUrl: "/templates/admins/products/brand.html",
			controller: "brand-ctrl"
		})
		.when("/category", {
			templateUrl: "/templates/admins/products/category.html",
			controller: "category-ctrl"
		})
		.when("/subCategory", {
			templateUrl: "/templates/admins/products/subcategory.html",
			controller: "subcategory-ctrl"
		})
		.when("/productDetail", {
			templateUrl: "/templates/admins/products/productdetail.html",
			controller: "productdetail-ctrl"
		})
		.when("/color", {
			templateUrl: "/templates/admins/products/color.html",
			controller: "color-ctrl"
		})
		.when("/review", {
			templateUrl: "/templates/admins/reviews/review.html",
			controller: "review-ctrl"
		})
		.when("/order", {
			templateUrl: "/templates/admins/orders/order.html",
			controller: "order-ctrl"
		})
		.when("/directDiscount", {
			templateUrl: "/templates/admins/discounts/directdiscount.html",
			controller: "directdiscount-ctrl"
		})
		.when("/discount", {
			templateUrl: "/templates/admins/discounts/discount.html",
			controller: "discount-ctrl"
		}).when("/discountProd", {
			templateUrl: "/templates/admins/discounts/productdiscount.html",
			controller: "prodsDiscount-ctrl"
		})
		.when("/discountCate", {
			templateUrl: "/templates/admins/discounts/categorydiscount.html",
			controller: "catesDiscount-ctrl"
		})
		.when("/supplier", {
			templateUrl: "/templates/admins/suppliers/supplier.html",
			controller: "supplier-ctrl"
		})
		.when("/ImportReceipt", {
			templateUrl: "/templates/admins/ImportReceipt/ImportReceipts.html",
			controller: "ImportReceipt-ctrl"
		})
		.when("/ImportReceiptDetail", {
			templateUrl: "/templates/admins/ImportReceipt/ImportReceiptDetail.html",
			controller: "ImportReceiptDetail-ctrl"
		})
		.when("/totalImport", {
			templateUrl: "/templates/admins/statistical/totalImport.html",
			controller: "totalImport-ctrl"
		})
		.when("/user", {
			templateUrl: "/templates/admins/user/user.html",
			controller: "user-ctrl"
		})
		.when("/order", {
			templateUrl: "/templates/admins/order/order.html",
			controller: "order-ctrl"
		})
		.when("/productOFcategory", {
			templateUrl: "/templates/admins/statistical/productofcategory.html",
			controller: "prodofcate-ctrl"
		})
		.when("/totalproductrating", {
			templateUrl: "/templates/admins/statistical/totalproductofrating.html",
			controller: "totalproductrating-ctrl"
		})
		.when("/voucher", {
			templateUrl: "/templates/admins/voucher/voucher.html",
			controller: "voucher-ctrl"
		})
		.when("/profile", {
			templateUrl: "/templates/admins/user/profile.html",
			controller: "profile-ctrl"
		})
		.when("/favorite", {
			templateUrl: "/templates/admins/favorites/favorite.html",
			controller: "favorite-ctrl"
		})
		.when("/revenue", {
			templateUrl: "/templates/admins/statistical/revenues.html",
			controller: "revenues-ctrl"
		})
		.otherwise({
			templateUrl: "/templates/admins/index.html",
			controller: "indexAdmin-ctrl"
		});
})

