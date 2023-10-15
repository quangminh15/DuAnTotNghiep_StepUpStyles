package com.sts.service;

import java.util.List;

import com.sts.model.Order;
import com.sts.model.DTO.OrderDetailDTO;

public interface OrderService {
    
    Order createOrder(List<OrderDetailDTO> cartDataList, double initialPrice, double fee, Integer address, boolean paymentStatus);
}
