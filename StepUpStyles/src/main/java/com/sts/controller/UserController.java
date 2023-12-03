package com.sts.controller;

import com.sts.dao.CartDAO;
import com.sts.dao.UserDAO;
import com.sts.model.DTO.DResponseUser;
import com.sts.model.DTO.DataOTP;
import com.sts.model.Cart;
import com.sts.model.OgirinAccount;
import com.sts.model.Role;
import com.sts.model.User;
import com.sts.model.VerificationCode;
import com.sts.service.FormSendMailHTML;
import com.sts.service.MailerService;
import com.sts.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.Random;
import java.util.regex.Pattern;

@Controller
public class UserController {
	@Autowired
	UserService userService;

	@Autowired
	MailerService mailerService;

	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;

	User user = new User();

	VerificationCode vc;

	String emailResetPass;

	@Autowired
	UserDAO userDAO;

	@Autowired
	CartDAO cartDAO;

	@RequestMapping("/listorder")
	public String listorder(Model model) {
		return "users/listorder";
	}

	@RequestMapping("/about")
	public String about(Model model) {
		loadstatuslogin(model);
		return "users/about";
	}

	@RequestMapping("/blog")
	public String blog(Model model) {

		return "users/blog";
	}

	@RequestMapping("/registration")
	public String registration(Model model) {
		model.addAttribute("Customer", new User());
		model.addAttribute("checked", "checked");
		return "users/LoginSTS";
	}

	@RequestMapping("/blog-single")
	public String blogsingle(Model model) {

		return "users/blog-single";
	}

	@RequestMapping("/contact")
	public String contact(Model model) {
		loadstatuslogin(model);
		return "users/contact";
	}

	@RequestMapping("/cart")
	public String cart(Model model) {
		return "users/cart";
	}

	@RequestMapping("/checkout")
	public String checkout(Model model) {
		loadstatuslogin(model);
		return "users/checkout";
	}

	@RequestMapping("/loginSTS")
	public String login(Model model) {
		model.addAttribute("Customer", new User());
		model.addAttribute("checked", "nochecked");
		return "users/LoginSTS";
	}

	@RequestMapping("/accessdenied")
	public String ad(Model model) {
		model.addAttribute("messageLoginFail", "Access denied");
		return "users/LoginSTS";
	}

	@RequestMapping("/loginSTS-error")
	public String ad2(Model model) {
		model.addAttribute("messageLoginFail", "Thông tin chưa đúng");

		model.addAttribute("Customer", new User());
		model.addAttribute("checked", "nochecked");
		return "users/LoginSTS";
	}

	@RequestMapping("/profile")
	public String profile(Model model) {
		loadstatuslogin(model);
		Integer id = 0;
		try {
			id = userService.getUserIdCurrent();
			if (id == null) {
				return "redirect:/loginSTS";
			}
			User user = userService.findById(id);
			DResponseUser dResponseUser = userService.getUserByEmail(user.getEmail());
			model.addAttribute("UserProfile", dResponseUser);
		} catch (Exception exception) {
			return "redirect:/loginSTS";
		}
		return "users/profile";
	}

	@RequestMapping("/profile-edit")
	public String profile_edit(Model model) {
		loadstatuslogin(model);
		Integer id = 0;
		try {
			id = userService.getUserIdCurrent();
			if (id == null) {
				return "redirect:/loginSTS";
			}
			User user = userService.findById(id);
			DResponseUser dResponseUser = userService.getUserByEmail(user.getEmail());
			model.addAttribute("UserProfile", dResponseUser);
		} catch (Exception exception) {
			return "redirect:/loginSTS";
		}
		return "users/profile-edit";
	}

	@PostMapping("/profile-update-data")
	public String process(Model model, @ModelAttribute("UserProfile") User user) {
		loadstatuslogin(model);
		String name = user.getFullName();
		LocalDate birthday = user.getBirthday();
		String phone = user.getPhone();
		String img = getUserImageURL();
		Integer id = userService.getUserIdCurrent();
		System.out.println(name+birthday+phone+img+"ID: "+id);
// check point
		if(birthday==null){
			userService.updateProfile_noBirthday(name,phone,img,id);
			return "redirect:/profile";
		}
		userService.updateProfile(user.getFullName(), user.getBirthday(), user.getPhone(), getUserImageURL(), userService.getUserIdCurrent());
		return "redirect:/profile";
	}

	@RequestMapping("/forgot-pass")
	public String forgotpass(Model model) {
		return "users/forgot-pass";
	}

	@PostMapping("/forgot-pass-email-check")
	public String forgotpass_emailcheck(Model model, @RequestParam("email") String email) {
		if (email.length() < 1) {
			model.addAttribute("emailValidation", "Không được để trống địa chỉ Email!");
			return "users/forgot-pass";
		}
		if (EmailCheck(email) != null) {
			model.addAttribute("emailValidation", EmailCheck(email));
			return "users/forgot-pass";
		}
		if (checkEmailAlreadyExists(email)) {
			model.addAttribute("emailValidation", "Email không tồn tại trong hệ thống!");
			return "users/forgot-pass";
		} else {
			this.emailResetPass = email;
			sendCodetoEmail_VforgotPass(email, userService.getUserByEmail(email).getFullName());
			return "redirect:/otpforgotpass";
		}
	}

	@RequestMapping("/otp")
	public String otp(Model model) {
		return "users/otp";
	}

	@RequestMapping("/otpforgotpass")
	public String forgotpassotp(Model model) {
		return "users/otp-forgotpass";
	}

	@RequestMapping("/reset-pass")
	public String resetpass(Model model) {
		return "users/reset-pass";
	}

	@PostMapping("/reset-pass-verification")
	public String handleLinkData3(Model model, @RequestParam("pass") String pass, @RequestParam("passc") String passc) {
		if (PassCheck(pass) != null) {
			model.addAttribute("passValidation", PassCheck(pass));
			return "users/reset-pass";
		}
		if (!pass.equals(passc)) {
			model.addAttribute("passValidation", "Mật khẩu chưa trùng khớp!");
			return "users/reset-pass";
		}
//        userService.updatePass(this.emailResetPass, bCryptPasswordEncoder.encode(pass));
		User u = userDAO.findByEmailU(this.emailResetPass);
		u.setPassword(bCryptPasswordEncoder.encode(pass));
		userDAO.save(u);
		return "redirect:/loginSTS";
	}

	@RequestMapping("/change-pass")
	public String changepass(Model model) {
		return "users/change-pass";
	}

	@PostMapping("/signup")
	public String validDangNhap(Model model, @ModelAttribute("Customer") User c) {
		System.out.println("Thông tin đk: " + c);

		if (c != null) {
//			if(!checkInput(c)) {
//				model.addAttribute("messageConfirmPassWrong", this.messageCheckInputData);
//				model.addAttribute("nguoidung", this.user);
//				return "/nguoidung/dangky";
//			}
			if (NameCheck(c.getFullName()) != null) {
				model.addAttribute("nameValidation", NameCheck(c.getFullName()));
				model.addAttribute("checked", "checked");
				return "users/LoginSTS";
			}
			if (PhoneCheck(c.getPhone()) != null) {
				model.addAttribute("phoneValidation", PhoneCheck(c.getPhone()));
				model.addAttribute("checked", "checked");
				return "users/LoginSTS";
			}
			if (!checkPhoneAlreadyExists(c.getPhone())) {
				model.addAttribute("phoneValidation", "Số điẹn thoại đã tồn tại!");
				model.addAttribute("checked", "checked");
				return "users/LoginSTS";
			}
			if (EmailCheck(c.getEmail()) != null) {
				model.addAttribute("emailValidation", EmailCheck(c.getEmail()));
				model.addAttribute("checked", "checked");
				return "users/LoginSTS";
			}
			if (!checkEmailAlreadyExists(c.getEmail())) {
				model.addAttribute("emailValidation", "Email đã tồn tại!");
				model.addAttribute("checked", "checked");
				return "users/LoginSTS";
			}
//			if(PassCheck(c.getPassword()) != null) {
//				System.out.println("Pass không hợp lệ");
//				model.addAttribute("passValidation", PassCheck(c.getPassword()));
//				model.addAttribute("checked", "checked");
//				return "users/LoginSTS";
//			}

//			if(c.getCustomerPassword().equalsIgnoreCase(c.getCustomerImage())) {
//				c.setCustomerImage("");
//				// this.customer = new Customer(c);
//				this.customer.setCustomerEmail(c.getCustomerEmail());
//				return "redirect:/xacnhan";
//			}
			sendCodetoEmail(c.getEmail(), c.getFullName());
			this.user = c;
			this.user.setRole(Role.CUSTOMER.toString());
			this.user.setActivaties(true);
			this.user.setStatus(true);
			this.user.setDeleted(true);
			this.user.setOrigin(OgirinAccount.DF.toString());
			this.user.setPassword(bCryptPasswordEncoder.encode(c.getPassword()));
			this.user.setImage(getUserImageURL());
			this.user.setCreatedDate(LocalDate.now());
			return "redirect:/otp";
		}
		return "users/LoginSTS";
	}

	public String NameCheck(String name) {
		// Name check
		if (name.equals("")) {
			return "Họ tên phải từ 8-50 ký tự và không chứ ký tự đặc biệt!";
		}
		String regexName = "^[A-Za-z0-9\\p{L}\\s]{8,50}$";
		boolean isValidName = Pattern.matches(regexName, name);
		if (!isValidName) {
			return "Họ tên phải từ 8-50 ký tự và không chứ ký tự đặc biệt!";
		}
		return null;
	}

	public String EmailCheck(String email) {
		// Email check
		if (email.equals("")) {
			return "Không được bỏ trống Email!";
		}
		String regexEmail = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.(com|net|org|gov|edu|vn|us|uk|au|ca)$";
		Pattern EMAIL_PATTERN = Pattern.compile(regexEmail);
		if (!(EMAIL_PATTERN.matcher(email).matches()) || email.length() > 50) {
			return "Định dạng Email không hợp lệ!";
		}
		return null;
	}

	public String PhoneCheck(String phone) {
		// Phone check
		if (phone.equals("")) {
			return "Không được bỏ trống số điện thoại!";
		}
		String regexEmail = "^(\\\\+?84|0)(3[2-9]|5[2689]|7[06-9]|8[1-689]|9[0-9])[0-9]{7}$";
		Pattern EMAIL_PATTERN = Pattern.compile(regexEmail);
		if (!(EMAIL_PATTERN.matcher(phone).matches()) || phone.length() > 15) {
			return "Số điện thoại không hợp lệ";
		}
		return null;
	}

	public String PassCheck(String pass) {
		// Pass check
		if (pass.equals("")) {
			return "Mật khẩu phải từ 9-50 ký tự. Có it nhất 1 số , 1 chữ cái viết hoa, 1 ký tự đặc biệt!";
		}
		String regexPass = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=])(?=.*[a-zA-Z]).{9,50}$";
		boolean isValidPass = Pattern.matches(regexPass, pass);
		if (!isValidPass) {
			return "Mật khẩu phải từ 9-50 ký tự. Có it nhất 1 số , 1 chữ cái viết hoa, 1 ký tự đặc biệt!";
		}
		return null;
	}

	public boolean checkEmailAlreadyExists(String email) {
		DResponseUser user = userService.getUserByEmail(email);
		if (user == null) {
			return true;
		}
		return false;
	}

	public boolean checkPhoneAlreadyExists(String phone) {
		DResponseUser user = userService.getUserByPhone(phone);
		if (user == null) {
			return true;
		}
		return false;
	}

	public void sendCodetoEmail(String email, String name) {
		this.vc = new VerificationCode(generateCode(4));
		System.out.println("Mã code: " + this.vc.getCode());
		System.out.println("Thời gian tạo: " + this.vc.getCreatedTime());
		System.out.println("Email sẽ gửi: " + email);
		mailerService.queue(email, "ĐĂNG KÝ TÀI KHOẢN StepUpStyle",
				FormSendMailHTML.sendHTMLWhenResignation(vc.getCode(), name));
	}

	public void sendCodetoEmail_VforgotPass(String email, String name) {
		this.vc = new VerificationCode(generateCode(4));
		System.out.println("Mã code: " + this.vc.getCode());
		System.out.println("Thời gian tạo: " + this.vc.getCreatedTime());
		System.out.println("Email sẽ gửi: " + email);
		mailerService.queue(email, "QUÊN MẬT KHẨU StepUpStyle",
				FormSendMailHTML.sendHTMLWhenResignation(vc.getCode(), name));
	}

	public static String generateCode(int length) {
		StringBuilder sb = new StringBuilder();
		Random random = new Random();

		for (int i = 0; i < length; i++) {
			int digit = random.nextInt(10);
			sb.append(digit);
		}

		return sb.toString();
	}

	@PostMapping("/otpAccess")
	public String handleLinkData(Model model, @RequestBody DataOTP data, HttpServletResponse response) {
		String codeFromView = data.toString();

		try {
			// Thực hiện xử lý dữ liệu và trả về status 200 OK nếu thành công
			// Hoặc trả về status 500 Internal Server Error nếu có lỗi xảy ra
			if (codeFromView.equals(this.vc.getCode())) {
				User user = userService.create(this.user);
				Cart cart = new Cart();
				cart.setUser(user);
				cartDAO.save(cart);
				response.setStatus(HttpServletResponse.SC_OK); // Status 200 OK
			} else {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Status 500 Internal Server Error
			}
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Status 500 Internal Server Error nếu có
																				// lỗi xảy ra
		}
		return "users/otp";
	}

	@PostMapping("/otpAccessForgotPass")
	public String handleLinkData2(Model model, @RequestBody DataOTP data, HttpServletResponse response) {
		String codeFromView = data.toString();

		try {
			// Thực hiện xử lý dữ liệu và trả về status 200 OK nếu thành công
			// Hoặc trả về status 500 Internal Server Error nếu có lỗi xảy ra
			if (codeFromView.equals(this.vc.getCode())) {
				response.setStatus(HttpServletResponse.SC_OK); // Status 200 OK
			} else {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Status 500 Internal Server Error
			}
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Status 500 Internal Server Error nếu có
																				// lỗi xảy ra
		}
		return "users/otp-forgotpass";
	}

	public String getUserImageURL() {
		Random random = new Random();
		int i = random.nextInt(10);
		if (i == 1) {
			return "https://images.hdqwalls.com/download/synthwave-chic-cool-girl-drives-the-train-back-xp-315x315.jpg";
		}
		if (i == 2) {
			return "https://images.hdqwalls.com/download/mercy-overwatch-the-swiss-angel-7r-315x315.jpg";
		}
		if (i == 3) {
			return "https://images.hdqwalls.com/download/garena-free-fire-firestorm-frenzy-oh-315x315.jpg";
		}
		if (i == 4) {
			return "https://images.hdqwalls.com/download/katarina-lol-minimal-4k-pi-315x315.jpg";
		}
		if (i == 5) {
			return "https://images.hdqwalls.com/download/punked-anime-girl-t3-315x315.jpg";
		}
		if (i == 6) {
			return "https://images.hdqwalls.com/download/goku-hotline-miami-3l-315x315.jpg";
		}
		if (i == 7) {
			return "https://images.hdqwalls.com/download/super-saiyan-rose-5a-315x315.jpg";
		}
		if (i == 8) {
			return "https://images.hdqwalls.com/download/halloween-white-dress-anime-girl-ju-315x315.jpg";
		}
		if (i == 9) {
			return "https://images.hdqwalls.com/download/naruto-kyuubi-mode-a2-315x315.jpg";
		}
		return "https://images.hdqwalls.com/download/red-hood-evolution-5k-ne-315x315.jpg";
	}

	@RequestMapping("/oauth2/login/success")
	public String oauthLoginSuccess(OAuth2AuthenticationToken oauth2, Authentication auth) {
		System.out.println("Name: "+oauth2.getPrincipal().getAttribute("name"));
		System.out.println("Email: "+oauth2.getPrincipal().getAttribute("email"));
		System.out.println("IMG: "+oauth2.getPrincipal().getAttribute("picture"));

		userService.loginFromOAuth2(oauth2); // save to security context


  //    Call API Save in DB
		String email = oauth2.getPrincipal().getAttribute("email");
		User user = userService.findByEmail(email);
		if(user == null) {
			String name = oauth2.getPrincipal().getAttribute("name");
			String img = oauth2.getPrincipal().getAttribute("picture");

			if(img == null){
				img = getUserImageURL();
			}

			user = User.builder().email(email)
								.fullName(name)
								.image(img)
								.password(Long.toHexString(System.currentTimeMillis()))
								.createdDate(LocalDate.now())
								.origin(OgirinAccount.GG.toString())
								.role(Role.CUSTOMER.toString())
								.status(true)
								.deleted(true)
								.activaties(true)
								.build();
//			userService.create(user);
			User us = userService.create(user);

			
				Cart cart = new Cart();
				cart.setUser(us);
				cartDAO.save(cart);
			System.out.println("123 "+ us.getUsersId());
		}
		return "redirect:/index";
	}

	public void loadstatuslogin(Model model){
		Integer userIdCurrent = userService.getUserIdCurrent();
		if(userIdCurrent == null){
			model.addAttribute("loginStatus","no");

		}else{
			model.addAttribute("loginStatus","ok");
		}
	}

}
