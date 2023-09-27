package com.sts.serviceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ReviewDAO;
import com.sts.model.Review;
import com.sts.model.DTO.TotalProductRatingDTO;
import com.sts.service.ReviewService;

@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    ReviewDAO reviewDAO;

    @Override
    public List<Review> findAll() {
        return reviewDAO.findAll();
    }

    @PersistenceContext
	private EntityManager entityManager;

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

    @Override
    public List<TotalProductRatingDTO> getTotalProductRating(int month, int year) {
        List<TotalProductRatingDTO> totalProductRatings = new ArrayList<>();

		// Lấy danh sách danh mục
		List<Review> reviews = reviewDAO.findAll();

		// for (Review review : reviews) {
			// Sử dụng JPQL để lấy tổng số lượng sản phẩm theo danh mục
			TypedQuery<Object[]> query = entityManager.createQuery(
              "SELECT rv.rating, COUNT(rv) FROM Review rv WHERE FUNCTION('MONTH', rv.reviewDate) = :month and FUNCTION('YEAR', rv.reviewDate) = :year GROUP BY rv.rating", Object[].class);
              query.setParameter("month", month);
              query.setParameter("year", year);

			// Thực hiện truy vấn và lấy kết quả
            List<Object[]> results = query.getResultList();
			for (Object[] result : results) {
                Integer rating = (Integer) result[0];
                Long productCount = (Long) result[1];
                TotalProductRatingDTO ratingDTO = new TotalProductRatingDTO(rating, productCount);
                totalProductRatings.add(ratingDTO);
            }
		// }

		return totalProductRatings;
    }    
}
