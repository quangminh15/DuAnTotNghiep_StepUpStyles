package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import com.sts.model.DirectDiscount;
import com.sts.service.DiscountService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/discount")
public class DirectDiscountRestController {
    @Autowired
    DiscountService discountService;

    @GetMapping
    public List<DirectDiscount> getAllDiscounts() {
        return discountService.findAll();
    }

    @GetMapping("/noDeletedDiscount")
    public List<DirectDiscount> getNodeleted(){
        return discountService.getNodeletedDiscount();
    }

    @GetMapping("/deletdDiscount")
    public List<DirectDiscount> getDeleted(){
        return discountService.getDeletedDiscount();
    }

    @PostMapping("/createDiscount")
    public DirectDiscount createDiscount(@RequestBody DirectDiscount directDis){
        discountService.saveStatus(directDis);
        return discountService.create(directDis);
    }

    @PutMapping("/updateDiscount/{ddid}")
    public DirectDiscount update(@PathVariable("ddid") Long ddid, @RequestBody DirectDiscount directDis) {
		return discountService.update(directDis);
	}

    @DeleteMapping("/deleteDiscount/{ddid}")
	public void delete(@PathVariable("ddid") Long ddid) {
		discountService.delete(ddid);
	}

    @GetMapping("/update-status")
    public ResponseEntity<String> updateStatus() {
        try {
            discountService.updateDiscountStatus();
            return new ResponseEntity<>("Trạng thái đã được cập nhật thành công", HttpStatus.OK);
        } catch (Exception e) {
            // Xử lý lỗi nếu có
            return new ResponseEntity<>("Lỗi khi cập nhật trạng thái: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/searchDiscountProduct")
    public List<DirectDiscount> searchDiscount(@RequestParam("keyword") String keyword) {
        return discountService.findByDiscountProduct(keyword);
    }
}
