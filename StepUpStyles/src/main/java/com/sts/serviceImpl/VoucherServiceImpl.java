package com.sts.serviceImpl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.VoucherDAO;
import com.sts.model.Voucher;
import com.sts.service.VoucherService;

@Service
public class VoucherServiceImpl implements VoucherService {
    @Autowired
    VoucherDAO voucherDao;

    @Override
    public List<Voucher> findAll() {
        return voucherDao.findAll();
    }

    @Override
    public Voucher findById(Long voucherId) {
        return voucherDao.findById(voucherId).get();
    }

    @Override
    public List<Voucher> getNodeletedVoucher() {
        return voucherDao.findByDeletedFalse();
    }

    @Override
    public List<Voucher> getDeletedVoucher() {
        return voucherDao.findByDeletedTrue();
    }

    @Override
    public Voucher create(Voucher voucher) {
        return voucherDao.save(voucher);
    }

    @Override
    public Voucher update(Voucher voucher) {
        return voucherDao.save(voucher);
    }

    @Override
    public void deleteById(Long voucherId) {
        voucherDao.deleteById(voucherId);
    }

    @Override
    public List<Voucher> getValidVouchers() {
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); // Điều chỉnh định dạng phù hợp với trường dateEnd
        String currentDate = currentDateTime.format(formatter);
        return voucherDao.findByDeletedFalseAndDateEndGreaterThan(currentDate);
    }

    @Override
    public List<Voucher> findByVoucherContaining(String keyword) {
        return voucherDao.findByVoucherContaining(keyword);
    }

     
}
