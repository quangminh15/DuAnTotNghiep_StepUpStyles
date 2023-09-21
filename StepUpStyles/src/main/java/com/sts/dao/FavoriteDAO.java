package com.sts.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.User;

public interface FavoriteDAO extends JpaRepository<Favorite, Integer>{
    @Transactional
    void deleteByUserAndProduct(User user, Product product);

    @Query("SELECT f FROM Favorite f WHERE f.user.usersId=?1")
    List<Favorite> findByUserId(Integer usersId);

    @Query("SELECT f FROM Favorite f WHERE f.user.usersId=?1 and f.product.productID=?2")
    Favorite findByUserAndProduct(Integer usersId, Integer productID);
}
