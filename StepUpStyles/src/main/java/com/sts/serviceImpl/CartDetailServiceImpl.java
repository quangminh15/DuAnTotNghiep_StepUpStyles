package com.sts.serviceImpl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.CartDAO;
import com.sts.dao.CartDetailDAO;
import com.sts.dao.ColorDAO;
import com.sts.dao.ProductDAO;
import com.sts.dao.ProductDetailDAO;
import com.sts.dao.SizeDAO;
import com.sts.model.CartDetail;
import com.sts.model.Color;
import com.sts.model.Product;
import com.sts.model.ProductDetail;
import com.sts.model.Size;
import com.sts.service.CartDetailService;

@Service
public class CartDetailServiceImpl implements CartDetailService{

   @Autowired 
   CartDetailDAO cartDetailDao;
   @Autowired 
   CartDAO cartDao;
   @Autowired
   ColorDAO colorDao ;
   @Autowired
   SizeDAO sizeDao ;
   @Autowired
   ProductDAO prodDao ;
   @Autowired
   ProductDetailDAO prodDetailDao ;
   
   

    @Override
    public void addToCartItem(int cartId, int productId, int sizeId, int colorId, int quantity) {
       cartDetailDao.insertCartItem(cartId, productId, sizeId, colorId, quantity);
    }
    
    @Override
    public void upDateCartItem(int carDetailId, int productId, int sizeId, int colorId) {
      // Find the product_detail_id based on the provided criteria
      Product prod = prodDao.findById(productId).get();
      Size size = sizeDao.findById(sizeId).get();
      Color color = colorDao.findById(colorId).get();
      ProductDetail productDetail = prodDetailDao.findProductDetail(prod, size, color);

      // Check if the product_detail_id is found
      if (productDetail != null) {
          // Update the cart item with the new product_detail_id
          cartDetailDao.updateCartItem(carDetailId, productDetail);
      }
    }

    @Override
    public List<CartDetail> getCartItem(Integer userId) {
       return cartDetailDao.findCartItemsByCustomerId(userId);
    }

   @Override
   public List<Color> getColorNamesByProductId(Integer productId,Integer sizeID) {
       Product prod = prodDao.findById(productId).get();
       Size size = sizeDao.findById(sizeID).get();
       return colorDao.findByProductDetails_ProductAndProductDetails_Size(prod, size);
         //colors.stream().map(Color::getColorName).collect(Collectors.toList());
    }

   @Override
   public List<Size> getSizeNumbersByProductId(Integer productId,Integer colorId) {
       Product prod =prodDao.findById(productId).get();
       Color color = colorDao.findById(colorId).get();
         return sizeDao.findByProductDetails_ProductAndProductDetails_Color(prod,color);

       // sizes.stream().map(Size::getSizeNumber).collect(Collectors.toList());
    }

    
}
