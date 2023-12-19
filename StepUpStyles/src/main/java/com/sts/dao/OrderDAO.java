package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sts.model.Order;
import com.sts.model.OrderStatus;
import com.sts.model.User;

import java.util.List;


public interface OrderDAO extends JpaRepository<Order,Integer>{
    List<Order> findByUser(User user);

    List<Order> findByOrderStatus(OrderStatus orderStatus);
    
    @Query("SELECT YEAR(o.orderDate), SUM(o.initialPrice - (ird.price * od.quantity)-o.discountPrice) " +
    "FROM Order o " +
    "JOIN o.orderDetails od " +
    "JOIN od.productDetail pd " +
    "JOIN pd.importReceiptDetails ird " +
    "WHERE o.orderStatus = 'Delivered'" +
    "GROUP BY YEAR(o.orderDate)")
List<Object[]> calculateYearlyProfits();

@Query("SELECT YEAR(o.orderDate), SUM(o.initialPrice - (ird.price * od.quantity)-o.discountPrice) " +
    "FROM Order o " +
    "JOIN o.orderDetails od " +
    "JOIN od.productDetail pd " +
    "JOIN pd.importReceiptDetails ird " +
    "WHERE o.orderStatus = 'Delivered' and YEAR(o.orderDate) = ?1 " + 
    "GROUP BY YEAR(o.orderDate)")
List<Object[]> calculateOneYearlyProfits(Integer year);

@Query("SELECT YEAR(o.orderDate),MONTH(o.orderDate), SUM(o.initialPrice - (ird.price * od.quantity)-o.discountPrice) " +
    "FROM Order o " +
    "JOIN o.orderDetails od " +
    "JOIN od.productDetail pd " +
    "JOIN pd.importReceiptDetails ird " +
    "WHERE o.orderStatus = 'Delivered' and YEAR(o.orderDate) = ?1  and MONTH(o.orderDate)=?2 " + 
    "GROUP BY YEAR(o.orderDate), MONTH(o.orderDate)")
List<Object[]> calculateOneMonthYearlyProfits(Integer year, Integer month);

}
