package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Order;
import com.sts.model.OrderDetail;
import com.sts.model.Review;

public interface OrderDetailDAO extends JpaRepository<OrderDetail,Integer>{
    List<OrderDetail> findByOrder(Order order);

    @Query("SELECT od FROM OrderDetail od JOIN Review r ON od.productDetail.product.productID = r.product.productID WHERE od.order.orderId = :orderId AND r.user.usersId = :userId")
    List<OrderDetail> findOrderDetailWithReviewByOrderIdAndUserId(@Param("orderId") Integer orderId, @Param("userId") Integer userId);

    @Query("SELECT r FROM Review r " +
       "JOIN r.product p " +
       "JOIN p.productDetails pd " +
       "JOIN pd.orderDetails od " +
       "JOIN od.order o " +
       "WHERE o.orderId = :orderId AND r.user.usersId = :userId")
    List<Review> findReviewsByOrderIdAndUserId(@Param("orderId") Integer orderId, @Param("userId") Integer userId);
}
