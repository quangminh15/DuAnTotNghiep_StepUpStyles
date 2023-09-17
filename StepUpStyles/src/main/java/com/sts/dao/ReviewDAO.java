package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Review;

public interface ReviewDAO extends JpaRepository<Review, Integer>{
    // @Query("SELECT u FROM Review u WHERE u.user.userId = :userId")
    // List<Review> findByUserID(@Param("userId") Integer userId);

    @Query("SELECT r FROM Review r WHERE r.product.productID = :productId")
    List<Review> findByProductID(@Param("productId") Integer productId);
}
