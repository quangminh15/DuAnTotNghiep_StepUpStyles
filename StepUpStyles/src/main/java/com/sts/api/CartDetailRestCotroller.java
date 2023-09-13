package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.CartDetail;
import com.sts.service.CartDetailService;

@CrossOrigin("*")
@RestController
public class CartDetailRestCotroller {
    
    @Autowired 
    CartDetailService cardetailService;

    @PostMapping("/rest/cart")
    public void addToCart(
    		@RequestParam("id") Integer productId,
    		@RequestParam("size") Integer sizeId,
    		@RequestParam("color") Integer colorId,
    		@RequestParam("qty") Integer quantity) {
			// Call the service method to insert or update cart item
	    	// long customerId = 2;
	    	// Need Modifying and @Transational to chú thích 
	    	// để đảm bảo tính nhất quán trong quá trình thao tác với dữ liệu trong SQL 
			cardetailService.addToCartItem(2, productId, sizeId, colorId, quantity);
		}
	@GetMapping("/rest/cart")
	 public ResponseEntity<List<CartDetail>> getCartItemsByCustomerId() {
       ; // Same static customer ID as set in the UserDetails service

        List<CartDetail> cartDetais = cardetailService.getCartItem(2);
        return new ResponseEntity<>(cartDetais, HttpStatus.OK);
    }
}