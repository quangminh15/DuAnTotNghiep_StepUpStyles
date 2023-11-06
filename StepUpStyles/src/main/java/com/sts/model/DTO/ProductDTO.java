package com.sts.model.DTO;

import com.sts.model.CartDetail;
import com.sts.model.Product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductDTO{
    Product product;
    Float avgrev;
}
