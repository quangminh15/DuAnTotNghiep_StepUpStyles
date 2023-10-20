package com.sts.model.DTO;


import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonAppend;
import com.sts.model.Cart;
import com.sts.model.CartDetail;
import com.sts.model.Color;
import com.sts.model.Product;
import com.sts.model.ProductDetail;
import com.sts.model.ProductImage;
import com.sts.model.Size;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter

public class OrderDetailDTO {
   private Integer cartDetailId;
    private Integer quantity;
    private Cart cart;
    private Product product;
    private ProductDetail productDetail;
    private ProductImage prodI;
    private List<Color> colors;
    private List<Size> sizes;
    private boolean isSelected;

   // public OrderDetailDTO(CartDetailDTO cartDTO){
   //    this.cartDetailId = cartDTO.getCartdetai().getCartDetailId();
   //    // this.cart = cartDTO.getCartdetai().getCart();
   //    // this.colors = cartDTO.getCartdetai().getProductDetail().getColor();
   //    this.isSelected= cartDTO.isSelected;
   //    // this.product = cartDTO.getCartdetai().getProduct();
   //    this.quantity = cartDTO.getCartdetai().getQuantity();
   //    // this.sizes = cartDTO.getCartdetai().getProductDetail().getSize();
      
   // }
}
