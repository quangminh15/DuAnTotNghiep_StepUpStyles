package com.sts.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.CartDetail;
import com.sts.model.ProductDetail;

public interface CartDetailDAO extends JpaRepository<CartDetail,Integer>{
    
    @Transactional
	@Modifying
	@Query(nativeQuery = true, value = "EXEC SP_InsertCartItem  :cartId, :productId, :sizeId, :colorId, :quantity")
    void insertCartItem(
        @Param("cartId") int cartId,
        @Param("productId") int productId,
        @Param("sizeId") int sizeId,
        @Param("colorId") int colorId,
        @Param("quantity") int quantity
    );

    @Transactional
	@Modifying
    @Query("UPDATE CartDetail cd SET cd.productDetail = :productDetail WHERE cd.cartDetailId = :cartDetailId")
    void updateCartItem(@Param("cartDetailId") Integer cartDetailId, @Param("productDetail") ProductDetail productDetail);

    @Query("SELECT ci FROM CartDetail ci WHERE ci.cart.user.usersId=?1")
    List<CartDetail> findCartItemsByCustomerId(Integer usersId);
}
