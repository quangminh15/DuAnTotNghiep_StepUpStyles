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

import com.sts.model.Size;
import com.sts.service.SizeService;


@CrossOrigin("*")
@RestController
public class SizeRestController {
	@Autowired
	SizeService sizeService;

	@GetMapping("/rest/sizes/{sizeID}")
	public Size getOne(@PathVariable("sizeID") Integer sizeID) {
		return sizeService.findById(sizeID);
	}

	@GetMapping("/rest/sizes/loadall")
	public List<Size> getAll() {
		return sizeService.findAll();
	}
	
	@GetMapping("/rest/sizes/loadallDeleted")
	public List<Size> getAllDeleted() {
		return sizeService.loadAllDeleted();
	}
	
	@GetMapping("/rest/sizes/loadallNoDeleted")
	public List<Size> getAllNoDeleted() {
		return sizeService.loadAllNoDeleted();
	}
	
	@GetMapping("/rest/sizes/loadallNoDeletedAndActivitiesTrue")
	public List<Size> getAllNoDeletedAndActivitiesTrue() {
		return sizeService.loadAllNoDeletedAndActivitiesTrue();
	}

	@PostMapping("/rest/sizes/create")
	public Size create(@RequestBody Size size) {
		return sizeService.create(size);
	}

	@PutMapping("/rest/sizes/update/{sizeID}")
	public Size update(@PathVariable("sizeID") Integer sizeID, @RequestBody Size size) {
		return sizeService.update(size);
	}

	@DeleteMapping("/rest/sizes/delete/{sizeID}")
	public void delete(@PathVariable("sizeID") Integer sizeID) {
		sizeService.delete(sizeID);
	}

	@GetMapping("/rest/sizes/search")
	public List<Size> searchSizeByName(@RequestParam("keyword") Float keyword) {
	    return sizeService.searchByName(keyword);
	}

}
