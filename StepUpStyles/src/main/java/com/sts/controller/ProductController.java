package com.sts.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sts.dao.ProductDAO;
import com.sts.model.Brand;
import com.sts.model.Category;
import com.sts.model.Color;
import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.ProductImage;
import com.sts.model.Size;
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
		List<Brand> brands = brandService.loadAllNoDeletedAndActivitiesTrue();
		List<Product> featuredProducts = productservice.findFeaturedProducts();

		model.addAttribute("brands", brands);
		model.addAttribute("featuredProducts", featuredProducts);
		return "users/index";
	}

	// Trang sản phẩm
	@RequestMapping("/list_products")
	public String listproducts(Model model, @RequestParam("page") Optional<Integer> page,
			@RequestParam("cid") Optional<Integer> cid, @RequestParam("bid") Optional<Integer> bid) {

		Pageable pageable = PageRequest.of(page.orElse(0), 9);
		Page<Product> products = handleOtherParams(pageable, cid, bid);

		var numberOfPages = products.getTotalPages();
		model.addAttribute("currIndex", page.orElse(0));
		model.addAttribute("numberOfPages", numberOfPages);

		model.addAttribute("productitems", products);

		List<Category> categories = categoryService.loadAllNoDeletedAndActivitiesTrue();
		List<Brand> brands = brandService.loadAllNoDeletedAndActivitiesTrue();
		List<Color> colors = colorService.loadAllNoDeletedAndActivitiesTrue();
		List<Size> sizes = sizeService.loadAllNoDeletedAndActivitiesTrue();

		// Lấy danh sách sản phẩm nổi bật
		List<Product> featuredProducts = productservice.findFeaturedProducts();

		// Giới hạn danh sách sản phẩm nổi bật chỉ hiển thị tối đa 3 sản phẩm
		if (featuredProducts.size() > 3) {
			featuredProducts = featuredProducts.subList(0, 3);
		}

		model.addAttribute("featuredProducts", featuredProducts);

		model.addAttribute("categories", categories);
		model.addAttribute("brands", brands);
		model.addAttribute("colors", colors);
		model.addAttribute("sizes", sizes);

		List<Favorite> item = favoriteService.findByUserId(3);
		model.addAttribute("favoriteitems", item);
		return "users/list_products";
	}

	private Page<Product> handleOtherParams(Pageable pageable, Optional<Integer> cid, Optional<Integer> bid) {
		if (cid.isPresent()) {
			return productservice.findByCategoryIDPaged(cid.get(), pageable);
		} else if (bid.isPresent()) {
			return productservice.findByBrandIDPaged(bid.get(), pageable);
		}

		return productservice.loadAllNoDeletedAndActivitiesTrue(pageable);
	}

	// Trang sản phẩm chi tiết
	@RequestMapping("/single_product/{productID}")
	public String single_product(Model model, @PathVariable("productID") Integer productID) {
		Product item = productservice.findById(productID);
		model.addAttribute("productitem", item);

		List<Size> sizs = sizeService.loadAllNoDeletedAndActivitiesTrue();
		model.addAttribute("sizs", sizs);

		List<Color> cols = colorService.loadAllNoDeletedAndActivitiesTrue();
		model.addAttribute("cols", cols);

		List<ProductImage> productImages = productImageService.getImagesByProduct(productID);
		model.addAttribute("productImages", productImages);

		List<Product> similarProducts = productservice
				.findSimilarProductsByCategory(item.getCategory().getCategoryID());
		model.addAttribute("similarProducts", similarProducts);
		return "users/single_product";
	}

	@RequestMapping("/search_products")
	public String searchProducts(Model model, @RequestParam("search") String searchQuery,
			@RequestParam("page") Optional<Integer> page) {
		Pageable pageable = PageRequest.of(page.orElse(0), 9);
		Page<Product> searchResults = productservice.findByProductNameContaining(searchQuery, pageable);

		var numberOfPages = searchResults.getTotalPages();
		model.addAttribute("currIndex", page.orElse(0));
		model.addAttribute("numberOfPages", numberOfPages);

		model.addAttribute("productitems", searchResults);

		List<Category> categories = categoryService.loadAllNoDeletedAndActivitiesTrue();
		List<Brand> brands = brandService.loadAllNoDeletedAndActivitiesTrue();
		List<Color> colors = colorService.loadAllNoDeletedAndActivitiesTrue();
		List<Size> sizes = sizeService.loadAllNoDeletedAndActivitiesTrue();

		// Lấy danh sách sản phẩm nổi bật
		List<Product> featuredProducts = productservice.findFeaturedProducts();

		// Giới hạn danh sách sản phẩm nổi bật chỉ hiển thị tối đa 3 sản phẩm
		if (featuredProducts.size() > 3) {
			featuredProducts = featuredProducts.subList(0, 3);
		}

		model.addAttribute("featuredProducts", featuredProducts);

		model.addAttribute("categories", categories);
		model.addAttribute("brands", brands);
		model.addAttribute("colors", colors);
		model.addAttribute("sizes", sizes);

		List<Favorite> item = favoriteService.findByUserId(3);
		model.addAttribute("favoriteitems", item);

		return "users/list_products";
	}

}
