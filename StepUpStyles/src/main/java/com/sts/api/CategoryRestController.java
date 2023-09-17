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

import com.sts.model.Category;
import com.sts.service.CategoryService;


@CrossOrigin("*")
@RestController
public class CategoryRestController {
	@Autowired
	CategoryService categoryService;
	
	@GetMapping("/rest/categories/{categoryID}")
	public Category getOne(@PathVariable("categoryID") Integer categoryID) {
		return categoryService.findById(categoryID);
	}

	@GetMapping("/rest/categories/loadall")
	public List<Category> getAll() {
		return categoryService.findAll();
	}
	
	@GetMapping("/rest/categories/loadallDeleted")
	public List<Category> getAllDeleted() {
		return categoryService.loadAllDeleted();
	}
	
	@GetMapping("/rest/categories/loadallNoDeleted")
	public List<Category> getAllNoDeleted() {
		return categoryService.loadAllNoDeleted();
	}

	@PostMapping("/rest/categories/create")
	public Category create(@RequestBody Category category) {
		return categoryService.create(category);
	}

	@PutMapping("/rest/categories/update/{categoryID}")
	public Category update(@PathVariable("categoryID") Integer categoryID, @RequestBody Category category) {
		return categoryService.update(category);
	}

	@DeleteMapping("/rest/categories/delete/{categoryID}")
	public void delete(@PathVariable("categoryID") Integer categoryID) {
		categoryService.delete(categoryID);
	}
	
	@GetMapping("/rest/categories/search")
    public List<Category> searchColorByName(@RequestParam("keyword") String keyword) {
        return categoryService.searchByName(keyword);
    }
}
