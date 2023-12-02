package com.sts.model.DTO;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class OrderDTO {

    double initialPrice;
    Date orderDate;
    boolean paymentStatus;
    double shippingFee;
    double totalAmount;
    Integer addressID;
    double discountPrice;
    Long voucherUseId;
    List<OrderDetailDTO> orderDetails;
}
