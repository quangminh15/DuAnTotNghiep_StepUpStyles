package com.sts.service;

import java.util.List;

import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.User;

public interface FavoriteService {
    Favorite findById(Integer favoriteID);

    List<Favorite> findByUserId(Integer userID);

	List<Favorite> findAll();

	// Favorite create(Integer userId, Integer productId);
    Favorite create(Integer productId, Integer usersId);

	Favorite update(Favorite favorite);

    void delete(User user, Product product);

    Favorite getUserAndProductFavorite(Integer usersId, Integer productId);

    void deleteById(Integer favorateId);

}
