app = angular.module("admin-app", ["ngRoute"]);

app.config(function($routeProvider) {
	$routeProvider
		.when("/product", {
			templateUrl: "/templates/admins/products/product.html",
			controller: "product-ctrl"
		})
		.when("/product-img", {
			templateUrl: "/templates/admins/products/product-img.html",
			controller: "product-img-ctrl"
		})
		.when("/phoneConfiguration", {
			templateUrl: "/templates/admins/products/phoneconfiguration.html",
			controller: "phoneconfiguration-ctrl"
		})
		.when("/latopConfiguration", {
			templateUrl: "/templates/admins/products/laptopconfiguration.html",
			controller: "laptopconfiguration-ctrl"
		})
		.when("/productGroup", {
			templateUrl: "/templates/admins/products/productgroup.html",
			controller: "productgroup-ctrl"
		})
		.when("/productCategory", {
			templateUrl: "/templates/admins/products/productcategory.html",
			controller: "productcategory-ctrl"
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
		.when("/statistical", {
			templateUrl: "/templates/statistical.html",
			controller: "statistical"
		})
		.when("/user", {
			templateUrl: "/templates/admins/user/user.html",
			controller: "user-ctrl"
		})
		.when("/productTK", {
			templateUrl: "/templates/product.html",
			controller: "product"
		})
		.otherwise({
			templateUrl: "/templates/admins/products/product.html",
			controller: "product-ctrl"
		});
})

