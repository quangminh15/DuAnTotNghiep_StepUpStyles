package com.sts.model.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductQuantityDetailDTO {
    private String productName;
    private Double sizeNumber;
    private String colorName;
    private String fullName;
    private Double price;
    private Integer totalQuantity;
}
