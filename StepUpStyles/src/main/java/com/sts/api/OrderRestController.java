package com.sts.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.dao.OrderDAO;
import com.sts.dao.UserDAO;
import com.sts.model.Order;
import com.sts.model.OrderDetail;
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

    @PostMapping("/receiveCartData")
    public ResponseEntity<Map<String, String>> receiveCartData(@RequestBody List<OrderDetailDTO> cartDataList,
            @RequestParam("initialPrice") double initialPrice,
            @RequestParam("fee") double fee,
            @RequestParam("addressId") int addressId
             ) {
        try {
            // Handle the list of CartData objects
            System.out.println(fee);
            System.out.println(initialPrice);
            System.out.println(addressId);

            Order order =  orderService.createOrder(cartDataList, initialPrice, fee, addressId,false);
           
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

    @GetMapping("/listOrder")
    public List<Order> getListOrder(){
        User user = userdao.findById(2).get();
        
        return orderService.loadByUser(user);
    }
    @GetMapping("/listOrder/detail")
    public List<OrderDetail> getListOrderdetail(@RequestParam ("orderid") Integer orderid){
        
        Order order = orderdao.findById(orderid).get();
        return orderService.loadByOrder(order);
    }
    @GetMapping("/listOrder/all")
    public List<Order> findall(){
        return orderService.loadAll();
    }
}
