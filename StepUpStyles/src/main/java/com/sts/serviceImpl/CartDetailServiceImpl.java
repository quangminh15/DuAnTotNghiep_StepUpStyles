package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.CartDAO;
import com.sts.dao.CartDetailDAO;

import com.sts.model.CartDetail;

import com.sts.service.CartDetailService;

@Service
public class CartDetailServiceImpl implements CartDetailService{

   @Autowired 
   CartDetailDAO cartDetailDao;
   @Autowired 
   CartDAO cartDao;
   

    @Override
    public void addToCartItem(int cartId, int productId, int sizeId, int colorId, int quantity) {
       cartDetailDao.insertCartItem(cartId, productId, sizeId, colorId, quantity);
    }

    @Override
    public List<CartDetail> getCartItem(Integer userId) {
       return cartDetailDao.findCartItemsByCustomerId(userId);
    }
    
}
