package com.sts.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.sts.dao.UserDAO;
import com.sts.model.Order;
import com.sts.model.OrderDetail;
import com.sts.model.OrderStatus;
import com.sts.model.Review;
import com.sts.model.ShippingAddress;
import com.sts.model.User;
import com.sts.model.DTO.OrderDetailDTO;
import com.sts.service.OrderService;

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

    @PostMapping("/receiveCartData")
    public ResponseEntity<Map<String, String>> receiveCartData(@RequestBody List<OrderDetailDTO> cartDataList,
            @RequestParam("initialPrice") double initialPrice,
            @RequestParam("fee") double fee,
            @RequestParam("addressId") int addressId) {
        try {
            // Handle the list of CartData objects
            System.out.println(fee);
            System.out.println(initialPrice);
            System.out.println(addressId);

            Order order = orderService.createOrder(cartDataList, initialPrice, fee, addressId, false);

            // Create a success response
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
        User user = userdao.findById(1).get();

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

    @GetMapping("/find")
    public ResponseEntity<List<OrderDetail>> findOrderDetailWithReview(
            @RequestParam("orderId") Integer orderId) {
       List<OrderDetail> orderDetail = orderService.findOrderDetailWithReviewByOrderIdAndUserId(orderId, 1);
        if (orderDetail != null) {
            return ResponseEntity.ok(orderDetail);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/reviewDetail")
    public ResponseEntity<List<Review>> findReview(
            @RequestParam("orderId") Integer orderId) {
       List<Review> rvDetail = orderService.findByReviewWithOrderAndUser(orderId, 1);
        if (rvDetail != null) {
            return ResponseEntity.ok(rvDetail);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
