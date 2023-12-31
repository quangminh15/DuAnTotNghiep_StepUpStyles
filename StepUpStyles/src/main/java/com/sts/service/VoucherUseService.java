package com.sts.service;

import java.util.List;

import com.sts.model.VoucherUse;

public interface VoucherUseService {

    List<VoucherUse> findAll();

    void saveVoucherForUser(Long voucherId, Integer userId);

    List<VoucherUse> getSavedVoucherUsesByUserId(Integer userId);

    Boolean isVoucherSaved(Integer userId, Long voucherId);

    void updateVoucherSave();

}
