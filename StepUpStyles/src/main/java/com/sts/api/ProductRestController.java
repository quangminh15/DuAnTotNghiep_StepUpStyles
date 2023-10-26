package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.dao.ProductImageDAO;
import com.sts.model.Product;
import com.sts.model.DTO.CategoryProductCountDTO;
import com.sts.service.ProductService;
import com.sts.serviceImpl.ProductDetailServiceImpl;

@CrossOrigin("*")
@RestController
public class ProductRestController {
	@Autowired
	ProductService productService;

	@Autowired
	ProductImageDAO imgDAO;
	
	@Autowired
	ProductDetailServiceImpl productDetail;

	@GetMapping("/rest/products/{productID}")
	public Product getOne(@PathVariable("productID") Integer productID) {
		return productService.findById(productID);
	}

	@GetMapping("/rest/products/loadall")
	public List<Product> getAll() {
		return productService.findAll();
	}

	@GetMapping("/rest/products/loadallDeleted")
	public List<Product> getAllDeleted() {
		return productService.loadAllDeleted();
	}

	@GetMapping("/rest/products/loadallNoDeleted")
	public List<Product> getAllNoDeleted() {
		return productService.loadAllNoDeleted();
	}

	@GetMapping("/rest/products/loadallNoDeletedAndActivitiesTrue")
	public List<Product> getAllNoDeletedAndActivitiesTrue() {
		return productService.loadAllNoDeletedAndActivitiesTrue();
	}

	@GetMapping("/rest/products/loadallNoDeletedAndActivitiesTrueSort")
	public List<Product> getAllNoDeletedAndActivitiesTrueSort() {
		List<Product> products = productService.loadAllNoDeletedAndActivitiesTrue();
		return products;
	}

	@PostMapping("/rest/products/create")
	public Product create(@RequestBody Product product) {
		return productService.create(product);
	}

	@PutMapping("/rest/products/update/{productID}")
	public Product update(@PathVariable("productID") Integer productID, @RequestBody Product product) {
		return productService.update(product);
	}

	@DeleteMapping("/rest/products/delete/{productID}")
	public void delete(@PathVariable("productID") Integer productID) {
		productService.delete(productID);
	}

	@GetMapping("/rest/products/search")
	public List<Product> searchProductByName(@RequestParam("keyword") String keyword) {
		return productService.searchByName(keyword);
	}

	@GetMapping("/api/category-product-count")
	public ResponseEntity<List<CategoryProductCountDTO>> getCategoryProductCount() {
		List<CategoryProductCountDTO> categoryProductCounts = productService.getCategoryProductCount();
		return ResponseEntity.ok(categoryProductCounts);
	}

	// Load danh sách sản phẩm theo Brand
	@GetMapping("/rest/products/loadByBrandId/{brandID}")
	public List<Product> getProductsByBrandID(@PathVariable Integer brandID) {
		return productService.getProductsByBrandID(brandID);
	}

	// Load danh sách sản phẩm theo category
	@GetMapping("/rest/products/loadByCategoryId/{categoryID}")
	public List<Product> getProductsByCategoryID(@PathVariable Integer categoryID) {
		return productService.getProductsByCategoryID(categoryID);
	}

	@GetMapping("/rest/products/product-featured")
	public List<Product> findFeaturedProducts() {
		// Viết mã để lấy các sản phẩm dựa trên brandID ở đây
		return productService.findFeaturedProducts();
	}
	
}
