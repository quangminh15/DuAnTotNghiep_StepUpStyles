package com.sts.service;

import java.util.List;

import com.sts.model.Voucher;

public interface VoucherService  {

    List<Voucher> findAll();

    Voucher findById(Long voucherId);

    List<Voucher> getNodeletedVoucher();

    List<Voucher> getDeletedVoucher();

    Voucher create(Voucher voucher);

    Voucher update(Voucher voucher);

    void deleteById(Long voucherId);

    List<Voucher> getValidVouchers();

    List<Voucher> getVoucherSaved();
    
}
