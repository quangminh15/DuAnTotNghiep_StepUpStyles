package com.sts.service;

import java.util.List;

import com.sts.model.ShippingAddress;

public interface ShippingAddressService {
    
    List<ShippingAddress> findAddressByUser(Integer userId);

    ShippingAddress findAddressDefaultByUser(Integer userId);
}
