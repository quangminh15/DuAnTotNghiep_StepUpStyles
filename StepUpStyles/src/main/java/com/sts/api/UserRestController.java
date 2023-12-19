package com.sts.api;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sts.dao.UserDAO;
import com.sts.model.DTO.DResponseUser;
import com.sts.model.DTO.LResponseUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

	@GetMapping("/loadallCUSTOMER")
	public List<User> getAllC() {
		return userDAO.findCUSTOMER();
	}

	@GetMapping("/loadallEAA")
	public List<User> getAllEAA() {
		List<String> roles = Arrays.asList("ADMIN", "EMPLOYEE");
		return userDAO.findByRoleIn(roles);
	}

	@PostMapping("/create")
	public User create(@RequestBody User user) {
		return userService.create(user);
	}

	@PutMapping("/update")
	public User update(@RequestBody User user) {
		System.out.println("id: "+user.getUsersId());
		System.out.println("img: "+user.getImage());
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

	@GetMapping("/EmailProfile")
	public ResponseEntity<String> getEmailProfile() {
		String email = userService.getUserEmailCurrent();
		System.out.println(email);
		return ResponseEntity.ok().body(email);
	}

	@GetMapping("/getRole")
	public ResponseEntity<User> getRole() {
		User u = userService.findById(userService.getUserIdCurrent());
		String role = u.getRole();
		return ResponseEntity.ok().body(u);
	}

	@GetMapping("/getUserCurrent")
	public ResponseEntity<DResponseUser> getUC() {
		DResponseUser dResponseUser = userService.getUserByEmail(userService.getUserEmailCurrent());
		return ResponseEntity.ok().body(dResponseUser);
	}

	@PutMapping("/updateProfile")
	public ResponseEntity<?> updateUserProfile(
			@RequestBody User user,
			@RequestParam("fullName") String fullname,
			@RequestParam("birthday") String birthday,
			@RequestParam("phone") String phone,
			@RequestParam("image") String img,
			@RequestParam("address") String address
	) {
		// Làm logic cập nhật dữ liệu ở đây, ví dụ: lưu vào cơ sở dữ liệu
		// userId có thể được sử dụng để xác định người dùng cần cập nhật


		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate bd = null;
		try {
			// Chuyển chuỗi thành LocalDate bằng phương thức parse của DateTimeFormatter
			bd = LocalDate.parse(birthday, formatter);
			// In ra kết quả
			System.out.println("LocalDate: " + bd);
		} catch (Exception e) {
			// Xử lý nếu có lỗi xảy ra trong quá trình chuyển đổi
			e.printStackTrace();
		}


		// Thực hiện cập nhật dữ liệu người dùng với các giá trị đã nhận được

		Integer id = userService.getUserIdCurrent();

		if(birthday==null){
			userService.updateProfile_noBirthday(fullname,phone,img, address, id);
			return new ResponseEntity<>(user, HttpStatus.OK);
		}
		userService.updateProfile(fullname, bd, phone, img, address, id);

		return new ResponseEntity<>(user, HttpStatus.OK);
	}

	@GetMapping("/sumUser")
	public ResponseEntity<Integer> sumU(){
		Integer su = userDAO.sumU();
		System.out.println("sum: "+su);
		return ResponseEntity.ok(su);
	}

	@GetMapping("/dkgn")
	public ResponseEntity<List<LResponseUser>> dangkygannhat(){
		List<LResponseUser> lResponseUsers = new ArrayList<>();
		lResponseUsers = userDAO.findAllUserForIndexAdmin();
		return ResponseEntity.ok(lResponseUsers);
	}

}
