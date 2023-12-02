package com.sts.service;

import java.util.List;
import java.util.Optional;

import com.sts.model.Order;
import com.sts.model.OrderDetail;
import com.sts.model.OrderStatus;
import com.sts.model.Review;
import com.sts.model.User;
import com.sts.model.VoucherUse;
import com.sts.model.DTO.OrderDetailDTO;

public interface OrderService {
    
    Order createOrder(List<OrderDetailDTO> cartDataList, double initialPrice, double fee, Integer address, boolean paymentStatus, double discountPrice, Long voucherId);

    List<Order> loadByUser(User user);
    
    List<Order> loadByStatus(OrderStatus status);

    List<OrderDetail> loadByOrder(Order order);

    List<Order> loadAll();
    //xài cái này linh
    Review findOrderDetailWithReviewByOrderIdAndUserId(Integer orderDetailId, Integer userId);

    Review findByReviewWithOrderDetail(Integer orderDetailId);
    ///linh
    void updateStatus(Integer id, OrderStatus status);

    Order getSingleProd(Integer id);

}