package com.sts.service;

import java.util.List;

import com.sts.model.Order;
import com.sts.model.ShippingAddress;
import com.sts.model.DTO.OrderDetailDTO;

public interface OrderService {
    
    Order createOrder(List<OrderDetailDTO> cartDataList, Float initialPrice, Float fee, ShippingAddress address);
}
