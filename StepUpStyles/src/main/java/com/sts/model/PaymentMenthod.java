package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * The persistent class for the payment_menthod database table.
 * 
 */
@Entity
@Table(name="payment_menthod")
@Data
@AllArgsConstructor
@NoArgsConstructor
@NamedQuery(name="PaymentMenthod.findAll", query="SELECT p FROM PaymentMenthod p")
public class PaymentMenthod implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="payment_method_id")
	private long paymentMethodId;

	private String description;

	private boolean display;

	@Column(name="payment_menthod_name")
	private Object paymentMenthodName;

	//bi-directional many-to-one association to Order
	@OneToMany(mappedBy="paymentMenthod")
	private List<Order> orders;

	// public PaymentMenthod() {
	// }

	// public long getPaymentMethodId() {
	// 	return this.paymentMethodId;
	// }

	// public void setPaymentMethodId(long paymentMethodId) {
	// 	this.paymentMethodId = paymentMethodId;
	// }

	// public Object getDescription() {
	// 	return this.description;
	// }

	// public void setDescription(Object description) {
	// 	this.description = description;
	// }

	// public boolean getDisplay() {
	// 	return this.display;
	// }

	// public void setDisplay(boolean display) {
	// 	this.display = display;
	// }

	// public Object getPaymentMenthodName() {
	// 	return this.paymentMenthodName;
	// }

	// public void setPaymentMenthodName(Object paymentMenthodName) {
	// 	this.paymentMenthodName = paymentMenthodName;
	// }

	// public List<Order> getOrders() {
	// 	return this.orders;
	// }

	// public void setOrders(List<Order> orders) {
	// 	this.orders = orders;
	// }

	// public Order addOrder(Order order) {
	// 	getOrders().add(order);
	// 	order.setPaymentMenthod(this);

	// 	return order;
	// }

	// public Order removeOrder(Order order) {
	// 	getOrders().remove(order);
	// 	order.setPaymentMenthod(null);

	// 	return order;
	// }

}