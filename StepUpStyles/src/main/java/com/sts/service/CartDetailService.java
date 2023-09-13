package com.sts.service;

import java.util.List;

import com.sts.model.CartDetail;

public interface CartDetailService {

    List<CartDetail> getCartItem(Integer customerID);
    public void addToCartItem(int cartId, int productId, int sizeId, int colorId, int quantity) ;
}
