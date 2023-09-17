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

import com.sts.model.Brand;
import com.sts.service.BrandService;

@CrossOrigin("*")
@RestController
public class BrandRestController {
	@Autowired
	BrandService brandService;

	@GetMapping("/rest/brands/{brandID}")
	public Brand getOne(@PathVariable("brandID") Integer brandID) {
		return brandService.findById(brandID);
	}

	@GetMapping("/rest/brands/loadall")
	public List<Brand> getAll() {
		return brandService.findAll();
	}
	
	@GetMapping("/rest/brands/loadallDeleted")
	public List<Brand> getAllDeleted() {
		return brandService.loadAllDeleted();
	}
	
	@GetMapping("/rest/brands/loadallNoDeleted")
	public List<Brand> getAllNoDeleted() {
		return brandService.loadAllNoDeleted();
	}

	@PostMapping("/rest/brands/create")
	public Brand create(@RequestBody Brand brand) {
		return brandService.create(brand);
	}

	@PutMapping("/rest/brands/update/{brandID}")
	public Brand update(@PathVariable("brandID") Integer brandID, @RequestBody Brand brand) {
		return brandService.update(brand);
	}

	@DeleteMapping("/rest/brands/delete/{brandID}")
	public void delete(@PathVariable("brandID") Integer brandID) {
		brandService.delete(brandID);
	}

	@GetMapping("/rest/brands/search")
	public List<Brand> searchBrandByName(@RequestParam("keyword") String keyword) {
		return brandService.searchByName(keyword);
	}
}
