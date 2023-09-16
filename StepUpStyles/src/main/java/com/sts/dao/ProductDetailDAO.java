package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Color;
import com.sts.model.Product;
import com.sts.model.ProductDetail;
import com.sts.model.Size;

public interface ProductDetailDAO extends JpaRepository<ProductDetail, Integer>{
	@Query("SELECT c FROM ProductDetail c WHERE c.product.productName LIKE %:keyword%")
	List<ProductDetail> findByProductDetailNameContaining(@Param("keyword") String keyword);

	//Hai -----
	@Query("SELECT pd FROM ProductDetail pd WHERE pd.product= ?1 AND pd.size = ?2 AND pd.color = ?3")
    ProductDetail findProductDetail(
             Product product,
            Size size,
             Color color);
	//-------
}
