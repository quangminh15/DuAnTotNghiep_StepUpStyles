package com.sts.api;

import java.security.Principal;
import java.util.List;

import com.sts.dao.UserDAO;
import com.sts.dto.respone.OneUserForSecurity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
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

    @Autowired
	UserDAO userDAO;


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



	@GetMapping("/rest/users/Idprofile")
	public ResponseEntity<Object> getIdProfile() {
		Integer id = userService.getUserIdCurrent();
		System.out.println(id);
		return ResponseEntity.ok().body(id);
	}
}
