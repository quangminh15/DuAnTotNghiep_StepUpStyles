package com.sts.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.Review;
import com.sts.model.User;

public interface FavoriteDAO extends JpaRepository<Favorite, Integer>{
    @Transactional
    void deleteByUserAndProduct(User user, Product product);

    @Query("SELECT f FROM Favorite f WHERE f.user.usersId = ?1")
    List<Favorite> findByUserId(Integer usersId);

    @Query("SELECT f FROM Favorite f WHERE f.user.usersId=?1 and f.product.productID=?2")
    Favorite findByUserAndProduct(Integer usersId, Integer productID);

    @Query("SELECT r FROM Favorite r WHERE r.product.productID = :productId")
    List<Favorite> findByProductID(@Param("productId") Integer productId);

    @Query("SELECT r FROM Favorite r WHERE r.user.usersId = :usersId")
    List<Favorite> findByUserID(@Param("usersId") Integer usersId);

    @Query("SELECT f.product.productName, COUNT(f.product.productName) " +
           "FROM Favorite f " +
           "GROUP BY f.product.productName " +
           "ORDER BY COUNT(f.product.productName) DESC")
    List<Object[]> findMostLikedProduct();

    @Query("SELECT f, (SELECT COUNT(*) FROM Favorite f2 WHERE f2.product.productID = f.product.productID) AS totalLikes " +
           "FROM Favorite f " +
           "ORDER BY totalLikes DESC")
    List<Object[]> getFavoritesWithTotalLikes();
}
