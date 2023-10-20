package com.sts.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sts.model.Order;
import com.sts.model.DTO.OrderDTO;
import com.sts.model.DTO.OrderDetailDTO;
import com.sts.service.OrderService;
import com.sts.service.VNPayService;

@Controller
public class PaymentController {
   
    Double total = 0.0;
    
    List<OrderDetailDTO> listOrderDetails = new ArrayList<>();
    OrderDTO ordertemp = new OrderDTO();

    @ResponseBody
    @PostMapping("/payment/getdata")
    public void getData(@RequestBody List<OrderDetailDTO> cartDataList,
            @RequestParam("initialPrice") double initial,
            @RequestParam("fee") double fee,
            @RequestParam("addressId") int addressId) {

        ordertemp = OrderDTO.builder()
        .initialPrice(initial)
        .shippingFee(fee)
        .addressID(addressId)
        .orderDetails(cartDataList)
        .build();

        for (OrderDetailDTO orderDetailDTO : ordertemp.getOrderDetails()) {
            System.out.println(orderDetailDTO.getCartDetailId());
        }

    }

    

    @Autowired
    OrderService orderService;

    @GetMapping("/purchase")
    public String createOrderVNPay(){
        Order order = orderService.createOrder(ordertemp.getOrderDetails(), ordertemp.getInitialPrice(), ordertemp.getShippingFee(), ordertemp.getAddressID(), true);
        return "redirect:/index";
    }
    @ResponseBody
    @GetMapping("/payment/removedata")
    public String reovedata(){
       
        return "/index";
    }

    @Autowired
    private VNPayService vnPayService;

    @RequestMapping("/submitOrder")
    public String submidOrder(HttpServletRequest request) {
        System.out.println(1);
        total = ordertemp.getInitialPrice()+ordertemp.getShippingFee();
        int orderTotal = 10000;
        String orderInfo = "Thanh Toán Đơn Hàng";
        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        String vnpayUrl = vnPayService.createOrder(orderTotal, orderInfo, baseUrl);
        return "redirect:" + vnpayUrl;
        
    }

    @GetMapping("/vnpay-payment")
    public String GetMapping(HttpServletRequest request, Model model) {
        int paymentStatus = vnPayService.orderReturn(request);

        String orderInfo = request.getParameter("vnp_OrderInfo");
        String paymentTime = request.getParameter("vnp_PayDate");
        String transactionId = request.getParameter("vnp_TransactionNo");
        String totalPrice = request.getParameter("vnp_Amount");

        model.addAttribute("orderId", orderInfo);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("paymentTime", paymentTime);
        model.addAttribute("transactionId", transactionId);

        return paymentStatus == 1 ? "redirect:/purchase" : "redirect:/index";
    }

}