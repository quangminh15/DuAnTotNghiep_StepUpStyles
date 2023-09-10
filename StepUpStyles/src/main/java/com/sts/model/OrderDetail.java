package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * The persistent class for the order_detail database table.
 * 
 */
@Entity
@Table(name="order_detail")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="order_detail_id")
	private Integer orderDetailId;

	private double price;

	private int quantity;

	//bi-directional many-to-one association to Order
	@ManyToOne
	@JoinColumn(name="order_id")
	private Order order;

	//bi-directional many-to-one association to ProductDetail
	@ManyToOne
	@JoinColumn(name="product_detail_id")
	private ProductDetail productDetail;

	// public OrderDetail() {
	// }

	// public long getOrderDetailId() {
	// 	return this.orderDetailId;
	// }

	// public void setOrderDetailId(long orderDetailId) {
	// 	this.orderDetailId = orderDetailId;
	// }

	// public double getPrice() {
	// 	return this.price;
	// }

	// public void setPrice(double price) {
	// 	this.price = price;
	// }

	// public int getQuantity() {
	// 	return this.quantity;
	// }

	// public void setQuantity(int quantity) {
	// 	this.quantity = quantity;
	// }

	// public Order getOrder() {
	// 	return this.order;
	// }

	// public void setOrder(Order order) {
	// 	this.order = order;
	// }

	// public ProductDetail getProductDetail() {
	// 	return this.productDetail;
	// }

	// public void setProductDetail(ProductDetail productDetail) {
	// 	this.productDetail = productDetail;
	// }

}