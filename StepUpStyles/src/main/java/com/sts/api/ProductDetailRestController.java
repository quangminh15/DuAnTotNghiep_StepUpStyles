package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.ProductDetail;
import com.sts.service.ProductDetailService;


@CrossOrigin("*")
@RestController
public class ProductDetailRestController {
	@Autowired
	ProductDetailService productDetailService;

	@GetMapping("/rest/productdetails/{productDetailID}")
	public ProductDetail getOne(@PathVariable("productDetailID") Integer productDetailID) {
		return productDetailService.findById(productDetailID);
	}

	@GetMapping("/rest/productdetails/loadall")
	public List<ProductDetail> getAll() {
		return productDetailService.findAll();
	}

	@PostMapping("/rest/productdetails/create")
	public ProductDetail create(@RequestBody ProductDetail productDetail) {
		return productDetailService.create(productDetail);
	}

	@PutMapping("/rest/productdetails/update/{productDetailID}")
	public ProductDetail update(@PathVariable("productDetailID") Integer productDetailID, @RequestBody ProductDetail productDetail) {
		return productDetailService.update(productDetail);
	}

	@DeleteMapping("/rest/productdetails/delete/{productDetailID}")
	public void delete(@PathVariable("ProductDetailID") Integer productDetailID) {
		productDetailService.delete(productDetailID);
	}

	@GetMapping("/rest/productdetails/search")
	public List<ProductDetail> searchProductDetailByName(@RequestParam("keyword") String keyword) {
		return productDetailService.searchByName(keyword);
	}
}
