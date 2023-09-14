package com.sts.service;

import java.util.List;

import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.User;

public interface FavoriteService {
    Favorite findById(Integer favoriteID);

	List<Favorite> findAll();

	// Favorite create(Integer userId, Integer productId);
    Favorite create(Favorite favorite);

	Favorite update(Favorite favorite);

    void delete(User user, Product product);

}
