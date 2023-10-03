package com.sts.serviceImpl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.CartDetailDAO;
import com.sts.dao.OrderDAO;
import com.sts.dao.OrderDetailDAO;
import com.sts.dao.PaymentMethodDAO;
import com.sts.dao.UserDAO;
import com.sts.model.Order;
import com.sts.model.OrderDetail;
import com.sts.model.OrderStatus;
import com.sts.model.PaymentMenthod;
import com.sts.model.ShippingAddress;
import com.sts.model.User;
import com.sts.model.DTO.OrderDetailDTO;
import com.sts.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderDAO orderDao;
    @Autowired
    OrderDetailDAO orderDetailDao;
    @Autowired
    CartDetailDAO cartDetailDao;
    @Autowired
    UserDAO userDao;
    @Autowired
    PaymentMethodDAO payDao;

    @Override

    public Order createOrder(List<OrderDetailDTO> cartDataList, Float initialPrice, Float fee, ShippingAddress address) {
        User user = userDao.findById(1).get();

        PaymentMenthod pay = payDao.findById(1).get();
        
        Order order = Order.builder()
                .deliveryDate(null)
                .deliveryStatus(false)
                .initialPrice(initialPrice)
                .orderDate(new Date()) // Set the order date to the current date
                .orderStatus(OrderStatus.Pending) // Set the initial order status
                .paymentStatus(false)
                .shippingFee(fee)
                .totalAmount(initialPrice+fee)
                .discountPrice(0)

                // Set the PaymentMethod, ShippingAddress, and User associations
                .paymentMenthod(pay)
                .shippingAddress(address)
                .user(user).build();

        order = orderDao.save(order);
        //Create and associate OrderDetail entities with the Order
        for (OrderDetailDTO detailRequest : cartDataList) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductDetail(detailRequest.getProductDetail());
            orderDetail.setQuantity(detailRequest.getQuantity());
            orderDetail.setPrice(detailRequest.getProduct().getPrice());
            orderDetail.setOrder(order); // Associate the order with the order detail
            orderDetailDao.save(orderDetail);

            //cartDetailDao.deleteById(detailRequest.getCartDetailId());
        }

        return order;
    }

}
