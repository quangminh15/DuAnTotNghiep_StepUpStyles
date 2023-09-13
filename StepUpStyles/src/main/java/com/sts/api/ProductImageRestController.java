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
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.ProductImage;
import com.sts.service.ProductImageService;

@CrossOrigin("*")
@RestController
public class ProductImageRestController {
	@Autowired
	ProductImageService productImageService;

	@GetMapping("/rest/productimages/{productImageID}")
	public ProductImage getOne(@PathVariable("productImageID") Integer productImageID) {
		return productImageService.findById(productImageID);
	}

	@GetMapping("/rest/productimages/loadall")
	public List<ProductImage> getAll() {
		return productImageService.findAll();
	}

	@PostMapping("/rest/productimages/create")
	public ProductImage create(@RequestBody ProductImage productImage) {
		return productImageService.create(productImage);
	}

	@PutMapping("/rest/productimages/update/{productImageID}")
	public ProductImage update(@PathVariable("productImageID") Integer productImageID,
			@RequestBody ProductImage productImage) {
		return productImageService.update(productImage);
	}

	@DeleteMapping("/rest/productimages/delete/{productImageID}")
	public void delete(@PathVariable("ProductImageID") Integer productImageID) {
		productImageService.delete(productImageID);
	}
}
