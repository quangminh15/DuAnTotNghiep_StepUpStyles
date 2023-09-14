package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

	@GetMapping("/rest/favorites/{favoriteID}")
	public Favorite getFavorite(@PathVariable("favoriteID") Integer favoriteID) {
		return favoriteService.findById(favoriteID);
	}

    @GetMapping("/rest/favorites/{userId}")
	public List<Favorite> getFavoriteProduct(@PathVariable("userId") Integer userId) {
		return favoriteService.findByUserId(userId);
	}

	@GetMapping("/rest/favorites/loadall")
	public List<Favorite> getAllFavorite() {
		return favoriteService.findAll();
	}

	@PostMapping("/rest/favorites/{userId}/{productId}")
	public Favorite addToFavorite(@PathVariable("userId") Integer userId,@PathVariable("productId") Integer productId) {
		Product product = productService.findById(productId);
        User user = userService.findById(userId);

        if (product != null && user != null) {
            Favorite favorite = new Favorite();
            favorite.setUser(user);
            favorite.setProduct(product);

            favoriteService.create(favorite);
        }
	}

	@DeleteMapping("/rest/favorites/delete/{userId}/{productId}")
	public void deleteFavorite(@PathVariable("userId") Integer userId, @PathVariable("productId") Integer productId) {
		Product product = productService.findById(productId);
        User user = userService.findById(userId);

        if (product != null && user != null) {
            favoriteService.delete(user, product);
        }
	}
}
