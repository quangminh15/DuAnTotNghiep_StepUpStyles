package com.sts.service;

import java.util.List;

import com.sts.model.CartDetail;
import com.sts.model.Color;
import com.sts.model.Size;

public interface CartDetailService {

    List<CartDetail> getCartItem(Integer customerID);

    public void addToCartItem(int cartId, int productId, int sizeId, int colorId, int quantity) ;

    public void upDateCartItem(int carDetailId, int productId, int sizeId, int colorId) ;

    public List<Color> getColorNamesByProductId(Integer productId,Integer sizeId );

    public List<Size> getSizeNumbersByProductId(Integer productId,Integer colorId); 
}
