package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.ShippingAddressDAO;
import com.sts.dao.UserDAO;
import com.sts.model.ShippingAddress;
import com.sts.model.User;
import com.sts.service.ShippingAddressService;
@Service
public class ShippingAddressServiceImpl implements ShippingAddressService{
    
    @Autowired
    ShippingAddressDAO shipAddressDao;
    @Autowired
    UserDAO userDao;
    @Override
    public List<ShippingAddress> findAddressByUser(Integer userId) {
      User user = userDao.findById(userId).get();
      return shipAddressDao.findByUser(user);
    }

    @Override
    public ShippingAddress findAddressDefaultByUser(Integer userId) {
        
        return shipAddressDao.findByUserAndDefault(userId);
    }
    
}
