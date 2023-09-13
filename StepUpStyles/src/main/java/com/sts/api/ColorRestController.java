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

import com.sts.model.Color;
import com.sts.service.ColorService;

@CrossOrigin("*")
@RestController
public class ColorRestController {
	@Autowired
	ColorService colorService;

	@GetMapping("/rest/colors/{colorID}")
	public Color getOne(@PathVariable("colorID") Integer colorID) {
		return colorService.findById(colorID);
	}

	@GetMapping("/rest/colors/loadall")
	public List<Color> getAll() {
		return colorService.findAll();
	}

	@PostMapping("/rest/colors/create")
	public Color create(@RequestBody Color color) {
		return colorService.create(color);
	}

	@PutMapping("/rest/colors/update/{colorID}")
	public Color update(@PathVariable("colorID") Integer colorID, @RequestBody Color color) {
		return colorService.update(color);
	}

	@DeleteMapping("/rest/colors/delete/{colorID}")
	public void delete(@PathVariable("colorID") Integer colorID) {
		colorService.delete(colorID);
	}

	@GetMapping("/rest/colors/search")
	public List<Color> searchColorByName(@RequestParam("keyword") String keyword) {
		return colorService.searchByName(keyword);
	}
}
