package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.util.Date;
import java.util.List;


/**
 * The persistent class for the order database table.
 * 
 */
@Entity
@Builder
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
	@Enumerated(EnumType.STRING)
	private OrderStatus orderStatus;

	@Column(name="payment_status")
	private boolean paymentStatus;

	@Column(name="shipping_fee")
	private double shippingFee;

	@Column(name="total_amount")
	private double totalAmount;

	@Column(name="discount_price")
	private double discountPrice;

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

	

}