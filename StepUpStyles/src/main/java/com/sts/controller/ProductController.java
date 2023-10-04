package com.sts.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sts.model.Color;
import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.Size;
import com.sts.service.ColorService;
import com.sts.service.FavoriteService;
import com.sts.service.ProductDetailService;
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
    FavoriteService favoriteService;

	// Trang sản phẩm
	@RequestMapping("/list_products")
	public String listproducts(Model model) {
		List<Product> productss = productservice.findAll();
		model.addAttribute("productitems", productss);

		List<Favorite> item = favoriteService.findByUserId(3);
        model.addAttribute("favoriteitems", item);
		return "users/list_products";
	}

	// Trang sản phẩm chi tiết
	@RequestMapping("/single_product/{productID}")
	public String single_product(Model model, @PathVariable("productID") Integer productID) {
		Product item = productservice.findById(productID);
		model.addAttribute("productitem", item);
		
		List<Size> sizs = sizeService.findAll();
		model.addAttribute("sizs",sizs);
		
		List<Color> cols = colorService.findAll();
		model.addAttribute("cols",cols);
		return "users/single_product";
	}
}
