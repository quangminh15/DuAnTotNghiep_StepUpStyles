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

    //Xài cái này nè
    @Query("SELECT r FROM Review r WHERE r.orderDetail.orderDetailId = :orderDetailId AND r.user.usersId = :userId")
    Review findReviewByOrderDetailIdAndUserId(@Param("orderDetailId") Integer orderDetailId, @Param("userId") Integer userId);

    @Query("SELECT r FROM Review r WHERE r.orderDetail.orderDetailId = :orderDetailId")
    Review shoReviewDetail(@Param("orderDetailId") Integer orderDetailId);
    ////////

}
