package com.sts.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.VoucherUseDAO;
import com.sts.service.VoucherUseService;

@Service
public class VoucherUseServiceImpl implements VoucherUseService {
    @Autowired
    VoucherUseDAO voucherUseDao;
}
