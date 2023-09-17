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

import com.sts.model.User;
import com.sts.service.UserService;

@CrossOrigin("*")
@RestController
public class UserRestController {
    @Autowired
	UserService userService;

	@GetMapping("/rest/users/{userID}")
	public User getOne(@PathVariable("userID") Integer userID) {
		return userService.findById(userID);
	}

	@GetMapping("/rest/users/loadall")
	public List<User> getAll() {
		return userService.findAll();
	}

	@PostMapping("/rest/users/create")
	public User create(@RequestBody User user) {
		return userService.create(user);
	}

	@PutMapping("/rest/users/update/{userID}")
	public User update(@PathVariable("userID") Integer userID, @RequestBody User user) {
		return userService.update(user);
	}

	@DeleteMapping("/rest/users/delete/{productDetailID}")
	public void delete(@PathVariable("userID") Integer userID) {
		userService.delete(userID);
	}

	@GetMapping("/rest/users/search")
	public List<User> searchProductDetailByName(@RequestParam("keyword") String keyword) {
		return userService.searchByName(keyword);
	}
}
