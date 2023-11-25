package com.sts.controller;

import java.util.Iterator;
import java.util.List;

import com.sts.model.User;
import com.sts.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sts.dao.ProductDAO;
import com.sts.model.ProductImage;

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

	@Autowired
	UserService userService;

	@RequestMapping("/index")
	public String index(Model model) {
		Integer userIdCurrent = userService.getUserIdCurrent();
		if(userIdCurrent == null){
			model.addAttribute("loginStatus","no");
		}else{
			model.addAttribute("loginStatus","ok");
		}
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
		List<ProductImage> productImageList = productImageService.getImagesByProduct(productID);
		for (ProductImage productImage : productImageList) {
			System.out.println(productImage.getImagePath());
		}
		model.addAttribute("productImageList",productImageList);
		
		return "users/single_product";
	}

}
