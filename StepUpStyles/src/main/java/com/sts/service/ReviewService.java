package com.sts.service;

import java.util.List;

import com.sts.model.Review;

public interface ReviewService {
    List<Review> findAll();
    Review findById(Integer reviewID);
    boolean hidReview (Integer reviewID);
}
