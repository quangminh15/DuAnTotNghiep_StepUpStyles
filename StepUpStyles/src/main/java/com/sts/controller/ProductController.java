package com.sts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sts.dao.ProductDAO;
import com.sts.service.BrandService;
import com.sts.service.CategoryService;
import com.sts.service.ColorService;
import com.sts.service.FavoriteService;
import com.sts.service.ProductDetailService;
import com.sts.service.ProductImageService;
import com.sts.service.ProductService;
import com.sts.service.SizeService;

@Controller
public class ProductController {
	@Autowired
	ProductService productservice;

	@Autowired
	ProductDetailService productDetailService;

	@Autowired
	SizeService sizeService;

	@Autowired
	ColorService colorService;

	@Autowired
	BrandService brandService;

	@Autowired
	CategoryService categoryService;

	@Autowired
	ProductDAO pdao;

	@Autowired
	FavoriteService favoriteService;

	@Autowired
	ProductImageService productImageService;

	@RequestMapping("/index")
	public String index(Model model) {
		return "users/index";
	}

	// Trang sản phẩm
	@RequestMapping("/list_products")
	public String listproducts() {
		return "users/list_products";
	}

	// Trang sản phẩm chi tiết
	@RequestMapping("/single_product/{productID}")
	public String single_product(Model model, @PathVariable("productID") Integer productID) {
		return "users/single_product";
	}

}
