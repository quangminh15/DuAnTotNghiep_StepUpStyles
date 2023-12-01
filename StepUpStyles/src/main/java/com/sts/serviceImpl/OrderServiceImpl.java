package com.sts.serviceImpl;

import java.text.SimpleDateFormat;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.CartDetailDAO;
import com.sts.dao.OrderDAO;
import com.sts.dao.OrderDetailDAO;
import com.sts.dao.PaymentMethodDAO;
import com.sts.dao.ProductDetailDAO;
import com.sts.dao.ShippingAddressDAO;
import com.sts.dao.UserDAO;
import com.sts.dao.VoucherUseDAO;
import com.sts.model.Order;
import com.sts.model.OrderDetail;
import com.sts.model.OrderStatus;
import com.sts.model.PaymentMenthod;
import com.sts.model.Review;
import com.sts.model.ShippingAddress;
import com.sts.model.User;
import com.sts.model.VoucherUse;
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
    @Autowired
    ShippingAddressDAO addressDao;
    @Autowired
    ProductDetailDAO prodDetailDao;
    @Autowired
    VoucherUseDAO voucherUseDao;

    @Override
    public Order createOrder(List<OrderDetailDTO> cartDataList, double initialPrice, double fee, Integer addressId, boolean paymentStatus, double discountPrice,Long voucherId) {
        User user = userDao.findById(1).get();
       
        
        ShippingAddress address = addressDao.findById(addressId).get();
        VoucherUse voucher = new VoucherUse();
        if (voucherId==0) {
            voucher=null;
        }else{

            voucher = voucherUseDao.findById(voucherId).get();
        }
        PaymentMenthod pay = payDao.findById(1).get();


        Order order = Order.builder()
                .deliveryDate(formatDeliveryDate(calculateDeliveryDate()))
                .deliveryStatus(false)
                .initialPrice(initialPrice)
                .orderDate(getCurrentDateTime()) // Set the order date to the current date
                .orderStatus(OrderStatus.Pending) // Set the initial order status
                .paymentStatus(false)
                .shippingFee(fee)
                .totalAmount(initialPrice + fee)
                .discountPrice(discountPrice)
                .voucherUse(voucher)
                // Set the PaymentMethod, ShippingAddress, and User associations
                .paymentMenthod(pay)
                .shippingAddress(address)
                .user(user).build();

        order = orderDao.save(order);
        // Create and associate OrderDetail entities with the Order
        for (OrderDetailDTO detailRequest : cartDataList) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductDetail(detailRequest.getProductDetail());
            orderDetail.setQuantity(detailRequest.getQuantity());
            orderDetail.setPrice(detailRequest.getProduct().getPrice());
            orderDetail.setOrder(order); // Associate the order with the order detail
            orderDetailDao.save(orderDetail);

            prodDetailDao.updatePDQuantiy(detailRequest.getProductDetail().getQuantity() - detailRequest.getQuantity(),
                    detailRequest.getProductDetail().getProductDetailID());
            cartDetailDao.deleteById(detailRequest.getCartDetailId());

        }

        return order;
    }

    // Helper method to calculate delivery date (current date + 7 days)
    private Date calculateDeliveryDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, 7);
        return calendar.getTime();
    }

    // Helper method to get current date and time as a formatted string
    private String getCurrentDateTime() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return dateFormat.format(new Date());
    }

    // Helper method to format the delivery date as a string
    private String formatDeliveryDate(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(date);
    }

    @Override
    public List<Order> loadByUser(User user) {
       return orderDao.findByUser(user);
    }

    @Override
    public List<Order> loadByStatus(OrderStatus status) {
       return orderDao.findByOrderStatus(status);
    }

    @Override
    public List<OrderDetail> loadByOrder(Order order) {
       return orderDetailDao.findByOrder(order);
    }

    @Override
    public List<Order> loadAll() {
       return orderDao.findAll();
    }

    //Xài cái này linh
    @Override
    public Review findOrderDetailWithReviewByOrderIdAndUserId(Integer orderDetailId, Integer userId) {
        return orderDetailDao.findReviewByOrderDetailIdAndUserId(orderDetailId, userId);
    }

    @Override
    public Review findByReviewWithOrderDetail(Integer orderDetailId) {
        return orderDetailDao.shoReviewDetail(orderDetailId);
    }
    //linh

    @Override
    public void updateStatus(Integer id, OrderStatus status) {
        Order order = orderDao.findById(id).get();
        order.setOrderStatus(status);
       orderDao.save(order);
    }

    @Override
    public Order getSingleProd(Integer id) {
        return orderDao.findById(id).get();
    }

}
