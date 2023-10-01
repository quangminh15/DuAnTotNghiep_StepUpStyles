package com.sts.model.DTO;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.sts.model.CartDetail;
import com.sts.model.OrderDetail;
import com.sts.model.ShippingAddress;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OrderDTO {
    String deliveryDate;
    
    double initialPrice;
    Date orderDate;
    boolean paymentStatus;
    double shippingFee;
    double totalAmount;
    ShippingAddress shippingAddress;
    @JsonProperty("cardetails")
    List<CartDetail> cardetails ;
}
