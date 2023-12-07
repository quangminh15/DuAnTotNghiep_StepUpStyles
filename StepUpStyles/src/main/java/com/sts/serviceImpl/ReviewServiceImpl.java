package com.sts.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import com.sts.dao.ReviewDAO;
import com.sts.model.Review;
import com.sts.model.User;
import com.sts.model.DTO.TotalProductRatingDTO;
import com.sts.service.ReviewService;

@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    ReviewDAO reviewDAO;

    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    public ReviewServiceImpl(NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
    }

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

    // @Override
    // public boolean hidReview(Integer reviewID) {
    //     Optional<Review> reviewOptional = reviewDAO.findById(reviewID);
    //     if (reviewOptional.isPresent()) {
    //         Review review = reviewOptional.get();
    //         review.setDisplay(!review.isDisplay());
    //         reviewDAO.save(review);
    //         return true;
    //     }
    //     return false;
    // }

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
    public List<TotalProductRatingDTO> getTotalProductRating(int year) {
        String sql = "SELECT MONTH(r.review_date) AS month, " +
        "SUM(CASE WHEN r.rating = 1 THEN 1 ELSE 0 END) AS oneStar, " +
        "SUM(CASE WHEN r.rating = 2 THEN 1 ELSE 0 END) AS twoStar, " +
        "SUM(CASE WHEN r.rating = 3 THEN 1 ELSE 0 END) AS threeStar, " +
        "SUM(CASE WHEN r.rating = 4 THEN 1 ELSE 0 END) AS fourStar, " +
        "SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) AS fiveStar " +
        "FROM Review r " +
        "WHERE YEAR(r.review_date) = :year " +
        "GROUP BY MONTH(r.review_date)";

        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("year", year);

        List<TotalProductRatingDTO> reviewDTOList = new ArrayList<>();

        List<Map<String, Object>> rows = namedParameterJdbcTemplate.queryForList(sql, parameters);

        for (Map<String, Object> row : rows) {
            int month = (int) row.get("Month");

            Map<String, Integer> ratings = new HashMap<>();
            ratings.put("1 sao", (int) row.get("oneStar"));
            ratings.put("2 sao", (int) row.get("twoStar"));
            ratings.put("3 sao", (int) row.get("threeStar"));
            ratings.put("4 sao", (int) row.get("fourStar"));
            ratings.put("5 sao", (int) row.get("fiveStar"));

            TotalProductRatingDTO reviewDTO = new TotalProductRatingDTO(month, ratings);
            reviewDTOList.add(reviewDTO);
        }

        return reviewDTOList;
    }

//     @Override
// public List<TotalProductRatingDTO> getTotalProductRating(int year) {
//     String sql = "SELECT MONTH(r.review_date) AS month, p.product_name AS productName, " +
//         "SUM(CASE WHEN r.rating = 1 THEN 1 ELSE 0 END) AS oneStar, " +
//         "SUM(CASE WHEN r.rating = 2 THEN 1 ELSE 0 END) AS twoStar, " +
//         "SUM(CASE WHEN r.rating = 3 THEN 1 ELSE 0 END) AS threeStar, " +
//         "SUM(CASE WHEN r.rating = 4 THEN 1 ELSE 0 END) AS fourStar, " +
//         "SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) AS fiveStar " +
//         "FROM Review r " +
//         "JOIN Product p ON r.product_id = p.product_id " +
//         "WHERE YEAR(r.review_date) = :year " +
//         "GROUP BY p.product_name, MONTH(r.review_date)";

//     MapSqlParameterSource parameters = new MapSqlParameterSource();
//     parameters.addValue("year", year);

//     List<TotalProductRatingDTO> reviewDTOList = new ArrayList<>();

//     List<Map<String, Object>> rows = namedParameterJdbcTemplate.queryForList(sql, parameters);

//     for (Map<String, Object> row : rows) {
//         int month = (int) row.get("month"); // Sửa thành "month" (thay "Month")

//         Map<String, Integer> ratings = new HashMap<>();
//         ratings.put("1 sao", (int) row.get("oneStar"));
//         ratings.put("2 sao", (int) row.get("twoStar"));
//         ratings.put("3 sao", (int) row.get("threeStar"));
//         ratings.put("4 sao", (int) row.get("fourStar"));
//         ratings.put("5 sao", (int) row.get("fiveStar"));

//         String productName = (String) row.get("productName"); // Lấy tên sản phẩm từ kết quả truy vấn

//         TotalProductRatingDTO reviewDTO = new TotalProductRatingDTO(month, productName, ratings);
//         reviewDTOList.add(reviewDTO);
//     }

//     return reviewDTOList;
// }


    @Override
    public List<Review> searchs(Integer productId, Integer usersId, Integer rating) {
        return reviewDAO.search(productId, usersId, rating);
    }

    @Override
    public Review createReview(Review review) {
        return reviewDAO.save(review);
    }

    @Override
    public Review getByOrderDetailId(Integer orderDetailId) {
        return reviewDAO.findByOrderDetailID(orderDetailId);
    }

    @Override
    public List<User> getUserRoleUser() {
        return reviewDAO.getUserByRoleUser();
    }
    }    
    
