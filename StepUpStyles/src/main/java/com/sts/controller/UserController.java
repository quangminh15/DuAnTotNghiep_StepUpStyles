package com.sts.controller;

import com.sts.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	@Autowired
	UserService userService;

	

	@RequestMapping("/about")
	public String about(Model model) {

		return "users/about";
	}
	@RequestMapping("/paysuccess")
	public String success(Model model) {

		return "users/vnpay-success";
	}
	@RequestMapping("/listorder")
	public String listorder(Model model) {

		return "users/listorder";
	}

	@RequestMapping("/blog")
	public String blog(Model model) {

		return "users/blog";
	}

	@RequestMapping("/blog-single")
	public String blogsingle(Model model) {

		return "users/blog-single";
	}

	@RequestMapping("/contact")
	public String contact(Model model) {

		return "users/contact";
	}

	@RequestMapping("/cart")
	public String cart(Model model) {
		return "users/cart";
	}

	@RequestMapping("/checkout")
	public String checkout(Model model) {

		return "users/checkout";
	}

	@RequestMapping("/loginSTS")
	public String login(Model model) {

		return "users/LoginSTS";
	}

	@RequestMapping("/accessdenied")
	public String ad(Model model) {
		model.addAttribute("messageLoginFail", "Access denied");
		return "users/LoginSTS";
	}

	@RequestMapping("/login/error")
	public String ad2(Model model) {
		model.addAttribute("messageLoginFail", "Thông tin chưa đúng");
		return "users/LoginSTS";
	}
}
