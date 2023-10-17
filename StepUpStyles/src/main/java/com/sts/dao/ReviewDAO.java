package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Review;
import com.sts.model.DTO.TotalProductRatingDTO;

public interface ReviewDAO extends JpaRepository<Review, Integer>{
    // @Query("SELECT u FROM Review u WHERE u.user.userId = :userId")
    // List<Review> findByUserID(@Param("userId") Integer userId);

    @Query("SELECT r FROM Review r WHERE r.product.productID = :productId")
    List<Review> findByProductID(@Param("productId") Integer productId);

    @Query("SELECT r FROM Review r WHERE r.user.usersId = :usersId")
    List<Review> findByUserID(@Param("usersId") Integer usersId);

    @Query("SELECT r FROM Review r WHERE r.rating = ?1")
    List<Review> findByStar(@Param("rating") Integer rating);

    @Query(value = "SELECT MONTH(r.reviewDate) AS month, " +
    "SUM(CASE WHEN r.rating = 1 THEN 1 ELSE 0 END) AS oneStar, " +
    "SUM(CASE WHEN r.rating = 2 THEN 1 ELSE 0 END) AS twoStar, " +
    "SUM(CASE WHEN r.rating = 3 THEN 1 ELSE 0 END) AS threeStar, " +
    "SUM(CASE WHEN r.rating = 4 THEN 1 ELSE 0 END) AS fourStar, " +
    "SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) AS fiveStar " +
    "FROM Review r " +
    "WHERE YEAR(r.reviewDate) = :year " +
    "GROUP BY MONTH(r.reviewDate)")
    List<TotalProductRatingDTO> getReviewStatsByYear(@Param("year") Integer year);

    @Query("SELECT r FROM Review r WHERE r.product.productID = :productId and r.user.usersId = :usersId and r.rating = :rating")
    List<Review> search(@Param("productId") Integer productId, @Param("usersId") Integer usersId,@Param("rating") Integer rating);
}
