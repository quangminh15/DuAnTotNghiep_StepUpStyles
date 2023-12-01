package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.Voucher;
import com.sts.service.VoucherService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/voucher")
public class VoucherRestController {
    @Autowired
    VoucherService voucherService;

    @GetMapping
    public List<Voucher> getAllVoucher() {
        return voucherService.findAll();
    }

    @GetMapping("/getIdVoucher/{voucherId}")
    public Voucher getIdVoucher(@PathVariable("voucherId") Long voucherId) {
        return voucherService.findById(voucherId);
    }

    @GetMapping("/noDeletedVoucher")
    public List<Voucher> getNodeletedVoucher() {
        return voucherService.getNodeletedVoucher();
    }

    @GetMapping("/deletedVoucher")
    public List<Voucher> getdeletedVoucher() {
        return voucherService.getDeletedVoucher();
    }

    @PostMapping("/postVoucher")
    public Voucher postVoucher(@RequestBody Voucher voucher){
        return voucherService.create(voucher);
    }

    @PutMapping("/updateVoucher/{ddid}")
    public Voucher update(@PathVariable("ddid") Long ddid, @RequestBody Voucher voucher) {
        return voucherService.update(voucher);
    }

    @DeleteMapping("/removeVoucher/{voucherId}")
    public void deleteVoucher(@PathVariable("voucherId") Long voucherId){
        voucherService.deleteById(voucherId);
    }

    @GetMapping("/valid")
    public List<Voucher> getValidVouchers() {
        return voucherService.getValidVouchers();
    }

    @GetMapping("/searchVouchers")
    public List<Voucher> searchVoucher(@RequestParam("keyword") String keyword) {
        return voucherService.findByVoucherContaining(keyword);
    }
}