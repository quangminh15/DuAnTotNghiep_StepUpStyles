package com.sts.api;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.dao.OrderDAO;
import com.sts.dao.OrderDetailDAO;
import com.sts.dao.ProductDetailDAO;
import com.sts.dao.UserDAO;
import com.sts.model.Order;
import com.sts.model.OrderDetail;
import com.sts.model.OrderStatus;
import com.sts.model.Review;
import com.sts.model.ShippingAddress;
import com.sts.model.User;
import com.sts.model.VerificationCode;
import com.sts.model.DTO.OrderDetailDTO;
import com.sts.service.FormSendMailHTML;
import com.sts.service.MailerService;
import com.sts.service.OrderService;
import com.sts.service.UserService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/order")
public class OrderRestController {

    @Autowired
    OrderService orderService;
    @Autowired
    OrderDAO orderdao;
    @Autowired
    UserDAO userdao;
    @Autowired
    OrderDetailDAO orderDtdao;
    @Autowired
    ProductDetailDAO prodDetailDao;

    @Autowired
    UserService uService;

	@Autowired
	MailerService mailerService;

    @PostMapping("/receiveCartData")
    public ResponseEntity<Map<String, String>> receiveCartData(@RequestBody List<OrderDetailDTO> cartDataList,
            @RequestParam("initialPrice") double initialPrice,
            @RequestParam("fee") double fee,
            @RequestParam("addressId") int addressId,
            @RequestParam("discountPrice") Double discountPrice,
            @RequestParam("voucherUseId") Long voucherUID) {
        try {
            // Handle the list of CartData objects
            // System.out.println(fee);
            // System.out.println(initialPrice);
            // System.out.println(addressId);
            String email = uService.getUserEmailCurrent();
            Order order = orderService.createOrder(cartDataList, initialPrice, fee, addressId, false,
                    discountPrice, voucherUID);
            // Create a success response
            User user = userdao.findByEmailU(email);
            mailerService.queue(email, "ĐƠN HÀNG #"+order.getOrderId()+" được đặt thành công",
            FormSendMailHTML.sendHTMLWhenCreateOrder( user.getFullName(),order.getOrderId()));
            Map<String, String> responseMap = new HashMap<>();
            responseMap.put("message", "Data received successfully");
          
            return ResponseEntity.ok(responseMap);
        } catch (Exception e) {
            e.printStackTrace();
            // Create an error response
            Map<String, String> errorMap = new HashMap<>();
            errorMap.put("error", "Error processing data");

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMap);
        }
    }

    @RequestMapping("/updateStatus")
    public void updateStatus(@RequestParam("id") Integer id,
            @RequestParam("status") OrderStatus status) {

        orderService.updateStatus(id, status);
    }

    @GetMapping("/listOrder")
    public List<Order> getListOrder() {
        Integer userID = uService.getUserIdCurrent();
        User user = userdao.findById(userID).get();

        return orderService.loadByUser(user);
    }

    @GetMapping("/listOrder/detail")
    public List<OrderDetail> getListOrderdetail(@RequestParam("orderid") Integer orderid) {

        Order order = orderdao.findById(orderid).get();
        return orderService.loadByOrder(order);
    }

    @GetMapping("/listOrder/all")
    public List<Order> findall() {
        return orderService.loadAll();
    }

    @GetMapping("/single")
    public Order findOrder(@RequestParam("orderid") Integer orderid) {
        return orderService.getSingleProd(orderid);
    }

    @GetMapping("/find")
    public ResponseEntity<Boolean> checkIfOrderDetailIsReviewed(@RequestParam("orderDetailId") Integer orderDetailId) {
        Integer userId = uService.getUserIdCurrent();
        Review review = orderService.findOrderDetailWithReviewByOrderIdAndUserId(orderDetailId, userId);
        boolean isReviewed = review != null;
        return ResponseEntity.ok(isReviewed);
    }

    @GetMapping("/reviewDetail/{orderDetailId}")
    public ResponseEntity<Review> findReview(@PathVariable("orderDetailId") Integer orderDetailId) {
        Review rvDetail = orderService.findByReviewWithOrderDetail(orderDetailId);
        if (rvDetail != null) {
            return ResponseEntity.ok(rvDetail);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @GetMapping("/updateOrderVoucher")
    public ResponseEntity<String> updateOrderVoucher() {
        try {
            orderService.updateOrderVoucher();
            return new ResponseEntity<>("Trạng thái đã được cập nhật thành công", HttpStatus.OK);
        } catch (Exception e) {
            // Xử lý lỗi nếu có
            return new ResponseEntity<>("Lỗi khi cập nhật trạng thái: " + e.getMessage(),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/profitsYear/{year}")
    public ResponseEntity<List<Object[]>> getYearlyProfits(@PathVariable("year") Integer year) {
        List<Object[]> yearlyProfits = orderdao.calculateOneYearlyProfits(year);
        return ResponseEntity.ok(yearlyProfits);
    }

    @GetMapping("/profitsMonthAndYear")
    public ResponseEntity<List<Object[]>> getMonhtYearlyProfits(@RequestParam("year") Integer year,@RequestParam("month") Integer month) {
        List<Object[]> yearlyProfits = orderdao.calculateOneMonthYearlyProfits(year,month);
        return ResponseEntity.ok(yearlyProfits);
    }

    @GetMapping("/totalprofit")
    public ResponseEntity<List<Object[]>> getTotalProfits() {
        List<Object[]> yearlyProfits = orderdao.calculateYearlyProfits();
        return ResponseEntity.ok(yearlyProfits);
    }

    
}
