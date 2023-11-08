package com.sts.api;

import java.security.Principal;
import java.util.List;

import com.sts.dao.UserDAO;
import com.sts.model.DTO.LResponseUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import com.sts.model.User;
import com.sts.model.DTO.OneUserForSecurity;
import com.sts.service.UserService;

@CrossOrigin("*")
@RestController()
@RequestMapping("/user")
public class UserRestController {
    @Autowired
	UserService userService;

    @Autowired
	UserDAO userDAO;


	@GetMapping("/{userID}")
	public User getOne(@PathVariable("userID") Integer userID) {
		return userService.findById(userID);
	}

//	@GetMapping("/rest/users/loadall")
//	public List<User> getAll() {
//		return userService.findAll();
//	}

	@PostMapping("/create")
	public User create(@RequestBody User user) {
		return userService.create(user);
	}

	@PutMapping("/{userID}")
	public User update(@PathVariable("userID") Integer userID, @RequestBody User user) {
		return userService.update(user);
	}

	@DeleteMapping("/{userID}")
	public void delete(@PathVariable("userID") Integer userID) {
		userService.delete(userID);
	}

//	@GetMapping("/search")
//	public List<User> searchProductDetailByName(@RequestParam("keyword") String keyword) {
//		return userService.searchByName(keyword);
//	}

	@GetMapping()
	public List<LResponseUser> finAllBy() {
		return userService.findAll();
	}



	@GetMapping("/Idprofile")
	public ResponseEntity<Object> getIdProfile() {
		Integer id = userService.getUserIdCurrent();
		System.out.println(id);
		return ResponseEntity.ok().body(id);
	}
}
