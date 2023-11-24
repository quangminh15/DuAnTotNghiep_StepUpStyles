package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Order;
import com.sts.model.OrderDetail;

public interface OrderDetailDAO extends JpaRepository<OrderDetail,Integer>{
    List<OrderDetail> findByOrder(Order order);

    List<OrderDetail> findAllByOrder_OrderIdAndOrder_User_UsersId(Integer orderId, Integer usersId);

    @Query("SELECT od FROM OrderDetail od JOIN Review r ON od.productDetail.productDetailID = r.product.productID WHERE od.orderDetailId = :orderDetailId AND r.user.usersId = :userId")
    OrderDetail findOrderDetailWithReviewByOrderIdAndUserId(@Param("orderDetailId") Integer orderDetailId, @Param("userId") Integer userId);

}
