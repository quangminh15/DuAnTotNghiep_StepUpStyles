package com.sts.api;

import java.util.List;

import com.sts.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.User;
import com.sts.service.FavoriteService;
import com.sts.service.ProductService;

@CrossOrigin("*")
@RestController
public class FavoriteRestController {
    @Autowired
	FavoriteService favoriteService;

    @Autowired
    ProductService productService;

    @Autowired
	UserService userService;

	// @GetMapping("/rest/favorites/{favoriteID}")
	// public Favorite getFavorite(@PathVariable("favoriteID") Integer favoriteID) {
	// 	return favoriteService.findById(favoriteID);
	// }

    @GetMapping("/rest/favorites/getUserFavorite")
	public List<Favorite> getFavoriteProduct() {
		// Integer userID = userService.getUserIdCurrent();
		return favoriteService.findByUserId(3);
	}

	@GetMapping("/rest/favorites/check/{productID}")
	public Favorite getFavoriteProductAndUser(@PathVariable("productID") Integer productID) {
		// Integer userID = userService.getUserIdCurrent();
		return favoriteService.getUserAndProductFavorite(3,productID);
	}

	@GetMapping("/rest/favorites/loadall")
	public List<Favorite> getAllFavorite() {
		return favoriteService.findAll();
	}

	@GetMapping("/rest/products")
	public List<Product> getAllPD() {
		return productService.findAll();
	}

	@PostMapping("/rest/favorites/{productId}")
	public void addToFavorite(@PathVariable("productId") Integer productId) {	
		// Integer userID = userService.getUserIdCurrent();	
            favoriteService.create(productId, 3);
	}

	@DeleteMapping("/rest/favorites/delete/{userId}/{productId}")
	public void deleteFavorite(@PathVariable("userId") Integer userId, @PathVariable("productId") Integer productId) {
		Product product = productService.findById(productId);
        User user = userService.findById(userId);

        if (product != null && user != null) {
            favoriteService.delete(user, product);
        }
	}

	@DeleteMapping("/rest/favorites/delete/{favoriteId}")
	public void delete(@PathVariable("favoriteId") Integer favoriteId) {
		favoriteService.deleteById(favoriteId);
	}
}
