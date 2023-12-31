package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.dao.CartDAO;
import com.sts.dao.UserDAO;
import com.sts.model.Cart;
import com.sts.model.CartDetail;
import com.sts.model.Color;
import com.sts.model.Size;
import com.sts.model.User;
import com.sts.service.CartDetailService;
import com.sts.service.UserService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/cart")
public class CartDetailRestCotroller {

	@Autowired
	CartDetailService cardetailService;
	@Autowired
	CartDAO cartDao;
	@Autowired
	UserDAO userDao;
	@Autowired
	UserService userService;
	@PostMapping
	public void addToCart(
			@RequestParam("id") Integer productId,
			@RequestParam("size") Integer sizeId,
			@RequestParam("color") Integer colorId,
			@RequestParam("qty") Integer quantity) {
		// Call the service method to insert or update cart item
		// long customerId = 2;
		// Need Modifying and @Transational to chú thích
		// để đảm bảo tính nhất quán trong quá trình thao tác với dữ liệu trong SQL
		Integer userID = userService.getUserIdCurrent();
		User user = userDao.findById(userID).get();

		Cart cart= cartDao.findByUser(user);
		cardetailService.addToCartItem(cart.getCartId(), productId, sizeId, colorId, quantity);
	}

	@PutMapping("/updateCartItem")
	public void upDateToCart(

			@RequestParam("cartDetailID") Integer cartDID,
			@RequestParam("prodID") Integer productId,
			@RequestParam("size") Integer sizeId,
			@RequestParam("color") Integer colorId) {

		cardetailService.upDateCartItem(cartDID, productId, sizeId, colorId);
	}

	@PutMapping("/updateQuantity")
	public void updateQuantity(@RequestBody CartDetail cartDetail) {
		cardetailService.upDateQtyCartItem(cartDetail.getCartDetailId(), cartDetail.getQuantity());
	}

	@GetMapping
	public ResponseEntity<List<CartDetail>> getCartItemsByCustomerId() {
		; // Same static customer ID as set in the UserDetails service
		Integer userID = userService.getUserIdCurrent();
		List<CartDetail> cartDetais = cardetailService.getCartItem(userID);
		return new ResponseEntity<>(cartDetais, HttpStatus.OK);
	}

	@GetMapping("/colors")
	public List<Color> getProductColors(@RequestParam("prodID") Integer productId,
			@RequestParam("sizeID") Integer sizeID) {
		return cardetailService.getColorNamesByProductId(productId, sizeID);
	}

	@GetMapping("/sizes")
	public List<Size> getProductSizes(@RequestParam("prodID") Integer productId,
			@RequestParam("colorID") Integer coloID) {
		return cardetailService.getSizeNumbersByProductId(productId, coloID);

	}

	@DeleteMapping("/delete")
	public void delete(@RequestParam("cartId") Integer cartId) {
		cardetailService.deletedCartItem(cartId);
	}

}