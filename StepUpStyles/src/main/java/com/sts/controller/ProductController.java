package com.sts.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sts.model.Brand;
import com.sts.model.Category;
import com.sts.model.Color;
import com.sts.model.Product;
import com.sts.model.Size;
import com.sts.model.DTO.CategoryProductCountDTO;
import com.sts.service.BrandService;
import com.sts.service.CategoryService;
import com.sts.service.ColorService;
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
	BrandService brandService;

	@Autowired
	CategoryService categoryService;

	// Trang sản phẩm
	@RequestMapping("/list_products")
	public String listproducts(Model model) {
		List<Product> productss = productservice.loadAllNoDeletedAndActivitiesTrue();
		model.addAttribute("productitems", productss);

		List<Category> categories = categoryService.loadAllNoDeletedAndActivitiesTrue();
		List<Brand> brands = brandService.loadAllNoDeletedAndActivitiesTrue();
		List<Color> colors = colorService.loadAllNoDeletedAndActivitiesTrue();
		List<Size> sizes = sizeService.loadAllNoDeletedAndActivitiesTrue();
		
		// Tạo danh sách danh mục kèm số lượng sản phẩm
//		List<CategoryProductCountDTO> categoryProductCounts = new ArrayList<>();
//		for (Category category : categories) {
//            Long productCount = productservice.countProductsByCategoryWithConditions(category, true, false);
//            CategoryProductCountDTO categoryProductCount = new CategoryProductCountDTO(category.getCategoryName(), productCount);
//            categoryProductCounts.add(categoryProductCount);
//        }
//		model.addAttribute("categoriesWithProductCounts", categoryProductCounts);

		model.addAttribute("categories", categories);
		model.addAttribute("brands", brands);
		model.addAttribute("colors", colors);
		model.addAttribute("sizes", sizes);

		return "users/list_products";
	}

	// Trang sản phẩm chi tiết
	@RequestMapping("/single_product/{productID}")
	public String single_product(Model model, @PathVariable("productID") Integer productID) {
		Product item = productservice.findById(productID);
		model.addAttribute("productitem", item);

		List<Size> sizs = sizeService.findAll();
		model.addAttribute("sizs", sizs);

		List<Color> cols = colorService.findAll();
		model.addAttribute("cols", cols);
		return "users/single_product";
	}
}
