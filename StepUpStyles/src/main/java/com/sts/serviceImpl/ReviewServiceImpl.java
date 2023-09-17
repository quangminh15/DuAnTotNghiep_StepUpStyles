package com.sts.serviceImpl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ReviewDAO;
import com.sts.model.Review;
import com.sts.service.ReviewService;

@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    ReviewDAO reviewDAO;

    @Override
    public List<Review> findAll() {
        return reviewDAO.findAll();
    }

    @Override
	public Review findById(Integer reviewID) {
		return reviewDAO.findById(reviewID).get();
	}

    @Override
    public boolean hidReview(Integer reviewID) {
        Optional<Review> reviewOptional = reviewDAO.findById(reviewID);
        if (reviewOptional.isPresent()) {
            Review review = reviewOptional.get();
            review.setDisplay(!review.isDisplay());
            reviewDAO.save(review);
            return true;
        }
        return false;
    }

    @Override
    public List<Review> getProductByProductId(Integer productId) {
        return reviewDAO.findByProductID(productId);
    }

    @Override
    public List<Review> getUsersByUsersId(Integer usersId) {
        return reviewDAO.findByUserID(usersId);
    }

    @Override
    public List<Review> getReviewByStar(Integer rating) {
        return reviewDAO.findByStar(rating);
    }    
}
