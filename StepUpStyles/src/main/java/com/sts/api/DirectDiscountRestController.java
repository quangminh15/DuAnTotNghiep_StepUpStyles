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
import com.sts.model.Product;
import com.sts.service.DiscountService;
import com.sts.service.ProductService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/discount")
public class DirectDiscountRestController {
    @Autowired
    DiscountService discountService;

    @Autowired
    ProductService productService;

    @GetMapping
    public List<DirectDiscount> getAllDiscounts() {
        return discountService.findAll();
    }

    @GetMapping("/noDeletedDiscount")
    public List<DirectDiscount> getNodeleted() {
        return discountService.getNodeletedDiscount();
    }

    @GetMapping("/deletdDiscount")
    public List<DirectDiscount> getDeleted() {
        return discountService.getDeletedDiscount();
    }

    @PostMapping("/createDiscount")
    public DirectDiscount createDiscount(@RequestBody DirectDiscount directDis) {
        // Nhận thông tin khuyến mãi từ yêu cầu POST

        // Lấy giá sản phẩm từ cơ sở dữ liệu (hoặc từ đối tượng directDis nếu có)
        Product product = productService.getProductById(directDis.getProduct().getProductID());

        // Tính toán priceDiscount
        double priceDiscount = product.getPrice() - ((directDis.getDirectDiscount() / 100) * product.getPrice());
        directDis.setPriceDiscount(priceDiscount);

        // Lưu DirectDiscount vào cơ sở dữ liệu
        discountService.saveStatus(directDis);
        DirectDiscount savedDiscount = discountService.create(directDis);

        return savedDiscount;
    }

    @PutMapping("/updateDiscount/{ddid}")
    public DirectDiscount update(@PathVariable("ddid") Long ddid, @RequestBody DirectDiscount directDis) {
        discountService.saveStatus(directDis);
        DirectDiscount updateDiscount = discountService.update(directDis);
        return updateDiscount;
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
            return new ResponseEntity<>("Lỗi khi cập nhật trạng thái: " + e.getMessage(),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/searchDiscountProduct")
    public List<DirectDiscount> searchDiscount(@RequestParam("keyword") String keyword) {
        return discountService.findByDiscountProduct(keyword);
    }

    // Lọc danh sách giảm giá theo sản phẩm
    @GetMapping("/loadbyproduct/{productId}")
    public List<DirectDiscount> getdiscountsByProduct(@PathVariable Integer productId) {
        return discountService.getdiscountsByProduct(productId);
    }

    @GetMapping("/filter")
    public List<DirectDiscount> filterDiscounts(
            @RequestParam("status") String status,
            @RequestParam("deleted") boolean deleted) {
        return discountService.getDiscountsByStatusAndDeleted(status, deleted);
    }
}
