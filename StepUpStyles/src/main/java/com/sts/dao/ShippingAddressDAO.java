package com.sts.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.ShippingAddress;
import com.sts.model.User;

public interface ShippingAddressDAO extends JpaRepository<ShippingAddress,Integer>{
    
    List<ShippingAddress> findByUser(User user);

    @Query("Select s from ShippingAddress s where s.user.usersId=?1 and s.defaultAddress = true")
    ShippingAddress findByUserAndDefault(Integer userId);


    @Transactional
	@Modifying
	@Query(nativeQuery = true, value = "EXEC SP_UpdateDefault  :userId, :shippingAddressId")
    void updateDefault(
        @Param("userId") Integer userId,
        @Param("shippingAddressId") Integer shippingAddressId
    );

    @Transactional
	@Modifying
	@Query(nativeQuery = true, value = "EXEC SP_InsertShippingAddress  :userId, :default,:province,:district,:ward,:name_receiv,:phone_receiver, :address_detail")
    void createAddress(
        @Param("userId") Integer userId,
        @Param("default") boolean defaultCheck,
        @Param("province") String province,
        @Param("district") String district,
        @Param("ward") String ward,
        @Param("address_detail") String addressDetail,
        @Param("name_receiv") String name_receiv,
        @Param("phone_receiver") String phone_receiver
    );
}
