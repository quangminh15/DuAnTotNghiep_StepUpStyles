package com.sts.api;

import java.util.List;

import com.sts.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.Review;
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
		Integer userID = userService.getUserIdCurrent();
		return favoriteService.findByUserId(userID);
	}

	@GetMapping("/rest/favorites/check/{productID}")
	public Favorite getFavoriteProductAndUser(@PathVariable("productID") Integer productID) {
		Integer userID = userService.getUserIdCurrent();
		return favoriteService.getUserAndProductFavorite(userID,productID);
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
		Integer userID = userService.getUserIdCurrent();	
            favoriteService.create(productId, userID);
	}

	@DeleteMapping("/rest/favorites/delete/{productId}")
	public void deleteFavorite(@PathVariable("productId") Integer productId) {
		Integer userID = userService.getUserIdCurrent();
		Product product = productService.findById(productId);
        User user = userService.findById(userID);

        if (product != null && user != null) {
            favoriteService.delete(user, product);
        }
	}
	@GetMapping("/rest/favorites/loadbyproducts/{productId}")
	public List<Favorite> getProductByProduct(@PathVariable Integer productId) {
		return favoriteService.getProductByProductId(productId);
	}
    @GetMapping("/rest/favorites/loadbyusers/{usersId}")
	public List<Favorite> getUserByUser(@PathVariable Integer usersId) {
		return favoriteService.getUsersByUsersId(usersId);
	}
	@GetMapping("/rest/favorites/top1")
	public List<Object[]> getTop1() {
		return favoriteService.getTop1ProductFavorite();
	}
	@GetMapping("/rest/favorites/top5product")
	public List<Object[]> getTop5() {
		return favoriteService.getTop5ProductFavorite();
	}
	@GetMapping("/rest/favorites/searchProductName")
    public List<Favorite> getProductNameSearch(@RequestParam("keyword") String keyword) {
        return favoriteService.searchProductName(keyword);
    }
}
