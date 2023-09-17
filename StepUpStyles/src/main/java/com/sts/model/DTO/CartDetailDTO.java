package com.sts.model.DTO;

import com.sts.model.CartDetail;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartDetailDTO {
    CartDetail cartdetai;
    boolean isSelected =false ;
}
