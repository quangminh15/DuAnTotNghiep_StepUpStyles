package com.sts.model.DTO;

import com.sts.model.Product;

import lombok.Data;

/*@AllArgsConstructor
@NoArgsConstructor*/
@Data
public class ProductWithCount {
	private Product product;
    private Long productCount;

    public ProductWithCount(Product product, Long productCount) {
        this.product = product;
        this.productCount = productCount;
    }

}
