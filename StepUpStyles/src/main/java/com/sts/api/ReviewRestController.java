package com.sts.api;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.OrderDetail;
import com.sts.model.Product;
import com.sts.model.Review;
import com.sts.model.User;
import com.sts.model.DTO.ReviewSumary;
import com.sts.model.DTO.TotalProductRatingDTO;
import com.sts.service.OrderDetailService;
import com.sts.service.ProductService;
import com.sts.service.ReviewService;
import com.sts.service.UserService;

@CrossOrigin("*")
@RestController
public class ReviewRestController {
    @Autowired
    ReviewService reviewService;

    @Autowired
    ProductService pService;

    @Autowired
    UserService uService;

    @Autowired
    OrderDetailService odService;

    @GetMapping("/rest/reviews/loadall")
    public List<Review> getAll(){
        return reviewService.findAll();
    }

    @PostMapping("/rest/reviews/create/{productID}/{orderDetailId}")
    public ResponseEntity<?> createReview(@RequestBody Review review, @PathVariable("productID") Integer productID,
    @PathVariable("orderDetailId") Integer orderDetailId) {
    try {
        Product product = pService.findById(productID);
        if (product == null) {
            return new ResponseEntity<>("Không tìm thấy sản phẩm.", HttpStatus.NOT_FOUND);
        }
        Integer userId = uService.getUserIdCurrent();
        User currentUser = uService.findById(userId);
        if (currentUser == null) {
            return new ResponseEntity<>("Không tìm thấy người dùng.", HttpStatus.NOT_FOUND);
        }
        OrderDetail orderDT = odService.findById(orderDetailId);
        if (orderDT == null) {
            return new ResponseEntity<>("Không tìm thấy sản phẩm.", HttpStatus.NOT_FOUND);
        }
        review.setUser(currentUser);
        review.setProduct(product);
        review.setOrderDetail(orderDT);
        reviewService.createReview(review);

        return new ResponseEntity<>(review, HttpStatus.OK);
    } catch (Exception e) {
        return new ResponseEntity<>("Lỗi khi tạo đánh giá.", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}


    @GetMapping("/rest/reviews/{reviewID}")
    public Review getReviewID(@PathVariable("reviewID") Integer reviewID){
            return reviewService.findById(reviewID);
        }

    // @PutMapping("/rest/reviews/{reviewId}/hide")
    // public ResponseEntity<?> hideReviews(@PathVariable("reviewId") Integer reviewId) {
    //         boolean success = reviewService.hidReview(reviewId);
    //         if (success) {
    //             return ResponseEntity.ok().build();
    //         } else {
    //             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    //         }
    //     }
    @GetMapping("/rest/reviews/loadbyproducts/{productId}")
	public List<Review> getProductByProduct(@PathVariable Integer productId) {
		return reviewService.getProductByProductId(productId);
	}
    @GetMapping("/rest/reviews/loadbyusers/{usersId}")
	public List<Review> getUserByUser(@PathVariable Integer usersId) {
		return reviewService.getUsersByUsersId(usersId);
	}
    @GetMapping("/rest/reviews/loadbystar/{rating}")
	public List<Review> getStar(@PathVariable Integer rating) {
		return reviewService.getReviewByStar(rating);
	}

    // thong ke
    @GetMapping("/api/total-product-rating")
	// public ResponseEntity<List<TotalProductRatingDTO>> getTotalProductRating(@RequestParam("year") Integer year) {
	// 	if (year == null) {
    //         // Nếu không có năm được chọn, mặc định lấy dữ liệu cho năm hiện tại
    //         year = java.time.LocalDate.now().getYear();
    //     }
        
    //     return reviewService.getTotalProductRating(year);
	// }
    public List<TotalProductRatingDTO> getReviewChartData(@RequestParam(name = "year", required = false) Integer year) {
        if (year == null) {
            // Nếu không có năm được chọn, mặc định lấy dữ liệu cho năm hiện tại
            year = java.time.LocalDate.now().getYear();
        }
        
        return reviewService.getTotalProductRating(year);
    }

    @GetMapping("/rest/reviews/search")
    public ResponseEntity<List<Review>> searchReviews(
            @RequestParam(name = "productId", required = false) Integer productId,
            @RequestParam(name = "usersId", required = false) Integer usersId,
            @RequestParam(name = "rating", required = false) Integer rating) {
        List<Review> reviews = reviewService.searchs(productId, usersId, rating);
        return ResponseEntity.ok().body(reviews);
    }

    @GetMapping("/rest/userbyroleUser")
    public List<User> getUserRoleUsers() {
        return reviewService.getUserRoleUser();
    }
    @GetMapping("/rest/reviews/searchProductName")
    public List<Review> getProductNameSearch(@RequestParam("keyword") String keyword) {
        return reviewService.searchProductName(keyword);
    }
    @GetMapping("/rest/reviews/month-year")
    public List<ReviewSumary> getProductByMonthYear(@RequestParam("month") Integer month, @RequestParam("year") Integer year) {
        return reviewService.getReviewByMonth(month, year);
    }
    
}
