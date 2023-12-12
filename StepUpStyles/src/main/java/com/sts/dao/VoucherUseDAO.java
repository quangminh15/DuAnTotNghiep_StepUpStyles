package com.sts.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.User;
import com.sts.model.Voucher;
import com.sts.model.VoucherUse;

public interface VoucherUseDAO extends JpaRepository<VoucherUse, Long>{
    List<VoucherUse> findByUser_UsersIdAndSaved(Integer userId, Boolean saved);

   VoucherUse findByUserAndVoucher(User user, Voucher voucher);

   List<VoucherUse> findByVoucher_dateEndAndSavedIsTrue(Date date);
}
