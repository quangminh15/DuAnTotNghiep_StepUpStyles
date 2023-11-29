package com.sts.model.DTO;

import lombok.Data;

@Data
public class ProductImportStatisticDTO {
    private String year;
    private String month;
    private Long totalQuantity;
}
