package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.VoucherUse;
import com.sts.service.VoucherUseService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/voucherUse")
public class VoucherUseController {
    @Autowired
    VoucherUseService voucherUseService;

    @GetMapping
    public List<VoucherUse> getAllVoucherUse() {
        return voucherUseService.findAll();
    }

    @PostMapping("/saveVoucherUse")
    public ResponseEntity<String> saveVoucherUse(@RequestParam Long voucherId, @RequestParam Integer userId) {
        try {
            voucherUseService.saveVoucherForUser(voucherId, userId);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/getTrue/{userId}")
    public List<VoucherUse> getSavedVoucherUsesByUserId(@PathVariable Integer userId) {
        return voucherUseService.getSavedVoucherUsesByUserId(userId);
    }

    @GetMapping("/check-saved/{userId}/{voucherId}")
    public Boolean checkVoucherSaved(@PathVariable Integer userId, @PathVariable Long voucherId) {
        return voucherUseService.isVoucherSaved(userId, voucherId);
    }
}