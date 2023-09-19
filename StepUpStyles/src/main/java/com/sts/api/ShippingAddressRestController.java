package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.CartDetail;
import com.sts.model.Color;
import com.sts.model.ShippingAddress;
import com.sts.model.Size;
import com.sts.service.CartDetailService;
import com.sts.service.ShippingAddressService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/address")
public class ShippingAddressRestController {

	@Autowired
	ShippingAddressService shippingAddressService;

	// @PostMapping
	// public void addToCart(
	// 		@RequestParam("id") Integer productId,
	// 		@RequestParam("size") Integer sizeId,
	// 		@RequestParam("color") Integer colorId,
	// 		@RequestParam("qty") Integer quantity) {
	// 	// Call the service method to insert or update cart item
	// 	// long customerId = 2;
	// 	// Need Modifying and @Transational to chú thích
	// 	// để đảm bảo tính nhất quán trong quá trình thao tác với dữ liệu trong SQL
	// 	cardetailService.addToCartItem(1, productId, sizeId, colorId, quantity);
	// }

	// @PutMapping("/updateCartItem")
	// public void upDateToCart(

	// 		@RequestParam("cartDetailID") Integer cartDID,
	// 		@RequestParam("prodID") Integer productId,
	// 		@RequestParam("size") Integer sizeId,
	// 		@RequestParam("color") Integer colorId) {

	// 	cardetailService.upDateCartItem(cartDID, productId, sizeId, colorId);
	// }

	// @PutMapping("/updateQuantity")
	// public void updateQuantity( @RequestBody CartDetail cartDetail) {
	// 	cardetailService.upDateQtyCartItem(cartDetail.getCartDetailId(), cartDetail.getQuantity());
	// }

	@GetMapping
	public ResponseEntity<List<ShippingAddress>> getAddressShip() {
		; // Same static customer ID as set in the UserDetails service

		List<ShippingAddress> address = shippingAddressService.findAddressByUser(1);
		return new ResponseEntity<>(address, HttpStatus.OK);
	}

	@GetMapping("/default")
	public ShippingAddress getProductColors() {
		return shippingAddressService.findAddressDefaultByUser(1);
	}

	

}