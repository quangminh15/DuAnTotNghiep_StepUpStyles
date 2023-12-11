package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ShippingAddressDAO;
import com.sts.dao.UserDAO;
import com.sts.model.ShippingAddress;
import com.sts.model.User;
import com.sts.service.ShippingAddressService;
import com.sts.service.UserService;
@Service
public class ShippingAddressServiceImpl implements ShippingAddressService{
    
    @Autowired
    ShippingAddressDAO shipAddressDao;
    @Autowired
    UserDAO userDao;
    @Autowired
    UserService userService;
    @Override
    public List<ShippingAddress> findAddressByUser(Integer userId) {
      User user = userDao.findById(userId).get();
      return shipAddressDao.findByUser(user);
    }

    @Override
    public ShippingAddress findAddressDefaultByUser(Integer userId) {
        
        return shipAddressDao.findByUserAndDefault(userId);
    }

    @Override
    public void updateDefault(Integer shipid) {
      Integer userId = userService.getUserIdCurrent();
       
      shipAddressDao.updateDefault(userId, shipid);
    }

    @Override
    public void createAddress(int userId, boolean defaultCheck, String province, String district, String ward, String addressDetail,
        String nameReceiver, String phoneReceiver) {
      // TODO Auto-generated method stub
      shipAddressDao.createAddress(userId, defaultCheck, province, district, ward,addressDetail, nameReceiver, phoneReceiver);
    }
    
}
