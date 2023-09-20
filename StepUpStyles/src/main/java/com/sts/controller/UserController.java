package com.sts.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	@RequestMapping("/index")
	public String index(Model model) {

		return "users/index";
	}

	@RequestMapping("/about")
	public String about(Model model) {

		return "users/about";
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

}
