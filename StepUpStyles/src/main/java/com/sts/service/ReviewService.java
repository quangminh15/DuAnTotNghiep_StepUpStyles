package com.sts.service;

import java.util.List;

import com.sts.model.Review;
import com.sts.model.User;
import com.sts.model.DTO.TotalProductRatingDTO;

public interface ReviewService {
    List<Review> findAll();
    Review createReview(Review review);
    Review findById(Integer reviewID);
    // boolean hidReview (Integer reviewID);
    List<Review> getProductByProductId(Integer productId);
    List<Review> getUsersByUsersId(Integer usersId);
    List<Review> getReviewByStar(Integer rating);
    List<TotalProductRatingDTO> getTotalProductRating(int year);
    List<Review> searchs(Integer productId, Integer usersId, Integer rating);
    Review getByOrderDetailId(Integer orderDetailId);
    List<User> getUserRoleUser();
}
