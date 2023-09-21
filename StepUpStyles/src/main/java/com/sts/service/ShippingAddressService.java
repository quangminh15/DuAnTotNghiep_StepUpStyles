package com.sts.service;

import java.util.List;

import com.sts.model.ShippingAddress;

public interface ShippingAddressService {
    
    List<ShippingAddress> findAddressByUser(Integer userId);

    ShippingAddress findAddressDefaultByUser(Integer userId);

    public void createAddress(int userId, boolean defaultCheck, String province, String district, String ward, String addressDetail,String nameReceiver, String phoneReceiver) ;

    void updateDefault(Integer shipid);
}
