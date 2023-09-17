package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.Review;
import com.sts.service.ReviewService;

@CrossOrigin("*")
@RestController
public class ReviewRestController {
    @Autowired
    ReviewService reviewService;

    @GetMapping("/rest/reviews/loadall")
    public List<Review> getAll(){
        return reviewService.findAll();
    }

@GetMapping("/rest/reviews/{reviewID}")
public Review getReviewID(@PathVariable("reviewID") Integer reviewID){
        return reviewService.findById(reviewID);
    }

@PutMapping("/rest/reviews/{reviewId}/hide")
public ResponseEntity<?> hideReviews(@PathVariable("reviewId") Integer reviewId) {
        boolean success = reviewService.hidReview(reviewId);
        if (success) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @GetMapping("/rest/reviews/loadbyproducts/{productId}")
	public List<Review> getProductByProduct(@PathVariable Integer productId) {
		return reviewService.getProductByProductId(productId);
	}
}
