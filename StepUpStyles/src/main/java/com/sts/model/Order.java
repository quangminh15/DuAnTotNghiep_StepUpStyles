package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the order database table.
 * 
 */
@Entity
@Table(name = "\"order\"")
@Data
@AllArgsConstructor
@NoArgsConstructor
@NamedQuery(name="Order.findAll", query="SELECT o FROM Order o")
public class Order implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="order_id")
	private Integer orderId;

	@Column(name="delivery_date")
	private String deliveryDate;

	@Column(name="delivery_status")
	private boolean deliveryStatus;

	@Column(name="initial_price")
	private double initialPrice;

	@Temporal(TemporalType.DATE)
	@Column(name="order_date")
	private Date orderDate;

	@Column(name="order_status")
	private String orderStatus;

	@Column(name="payment_status")
	private boolean paymentStatus;

	@Column(name="shipping_fee")
	private double shippingFee;

	@Column(name="total_amount")
	private double totalAmount;

	//bi-directional many-to-one association to PaymentMenthod
	@ManyToOne
	@JoinColumn(name="payment_method_id")
	private PaymentMenthod paymentMenthod;

	//bi-directional many-to-one association to ShippingAddress
	@ManyToOne
	@JoinColumn(name="shipping_address_id")
	private ShippingAddress shippingAddress;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="users_id")
	private User user;

	//bi-directional many-to-one association to OrderDetail
	@JsonIgnore
	@OneToMany(mappedBy="order")
	private List<OrderDetail> orderDetails;

	// public Order() {
	// }

	// public long getOrderId() {
	// 	return this.orderId;
	// }

	// public void setOrderId(long orderId) {
	// 	this.orderId = orderId;
	// }

	// public Object getDeliveryDate() {
	// 	return this.deliveryDate;
	// }

	// public void setDeliveryDate(Object deliveryDate) {
	// 	this.deliveryDate = deliveryDate;
	// }

	// public boolean getDeliveryStatus() {
	// 	return this.deliveryStatus;
	// }

	// public void setDeliveryStatus(boolean deliveryStatus) {
	// 	this.deliveryStatus = deliveryStatus;
	// }

	// public double getInitialPrice() {
	// 	return this.initialPrice;
	// }

	// public void setInitialPrice(double initialPrice) {
	// 	this.initialPrice = initialPrice;
	// }

	// public Timestamp getOrderDate() {
	// 	return this.orderDate;
	// }

	// public void setOrderDate(Timestamp orderDate) {
	// 	this.orderDate = orderDate;
	// }

	// public Object getOrderStatus() {
	// 	return this.orderStatus;
	// }

	// public void setOrderStatus(Object orderStatus) {
	// 	this.orderStatus = orderStatus;
	// }

	// public boolean getPaymentStatus() {
	// 	return this.paymentStatus;
	// }

	// public void setPaymentStatus(boolean paymentStatus) {
	// 	this.paymentStatus = paymentStatus;
	// }

	// public double getShippingFee() {
	// 	return this.shippingFee;
	// }

	// public void setShippingFee(double shippingFee) {
	// 	this.shippingFee = shippingFee;
	// }

	// public double getTotalAmount() {
	// 	return this.totalAmount;
	// }

	// public void setTotalAmount(double totalAmount) {
	// 	this.totalAmount = totalAmount;
	// }

	// public PaymentMenthod getPaymentMenthod() {
	// 	return this.paymentMenthod;
	// }

	// public void setPaymentMenthod(PaymentMenthod paymentMenthod) {
	// 	this.paymentMenthod = paymentMenthod;
	// }

	// public ShippingAddress getShippingAddress() {
	// 	return this.shippingAddress;
	// }

	// public void setShippingAddress(ShippingAddress shippingAddress) {
	// 	this.shippingAddress = shippingAddress;
	// }

	// public User getUser() {
	// 	return this.user;
	// }

	// public void setUser(User user) {
	// 	this.user = user;
	// }

	// public List<OrderDetail> getOrderDetails() {
	// 	return this.orderDetails;
	// }

	// public void setOrderDetails(List<OrderDetail> orderDetails) {
	// 	this.orderDetails = orderDetails;
	// }

	// public OrderDetail addOrderDetail(OrderDetail orderDetail) {
	// 	getOrderDetails().add(orderDetail);
	// 	orderDetail.setOrder(this);

	// 	return orderDetail;
	// }

	// public OrderDetail removeOrderDetail(OrderDetail orderDetail) {
	// 	getOrderDetails().remove(orderDetail);
	// 	orderDetail.setOrder(null);

	// 	return orderDetail;
	// }

}