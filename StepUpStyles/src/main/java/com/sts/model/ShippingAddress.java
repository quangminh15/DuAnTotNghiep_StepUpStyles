package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * The persistent class for the shipping_address database table.
 * 
 */
@Entity
@Table(name="shipping_address")
@Data
@AllArgsConstructor
@NoArgsConstructor
@NamedQuery(name="ShippingAddress.findAll", query="SELECT s FROM ShippingAddress s")
public class ShippingAddress implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="shipping_address_id")
	private long shippingAddressId;

	@Column(name="address_details")
	private String addressDetails;

	@Column(name="default_address")
	private boolean defaultAddress;

	private String district;

	private String province;

	private String ward;

	//bi-directional many-to-one association to Order
	@OneToMany(mappedBy="shippingAddress")
	private List<Order> orders;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="users_id")
	private User user;

	// public ShippingAddress() {
	// }

	// public long getShippingAddressId() {
	// 	return this.shippingAddressId;
	// }

	// public void setShippingAddressId(long shippingAddressId) {
	// 	this.shippingAddressId = shippingAddressId;
	// }

	// public Object getAddressDetails() {
	// 	return this.addressDetails;
	// }

	// public void setAddressDetails(Object addressDetails) {
	// 	this.addressDetails = addressDetails;
	// }

	// public boolean getDefaultAddress() {
	// 	return this.defaultAddress;
	// }

	// public void setDefaultAddress(boolean defaultAddress) {
	// 	this.defaultAddress = defaultAddress;
	// }

	// public Object getDistrict() {
	// 	return this.district;
	// }

	// public void setDistrict(Object district) {
	// 	this.district = district;
	// }

	// public Object getProvince() {
	// 	return this.province;
	// }

	// public void setProvince(Object province) {
	// 	this.province = province;
	// }

	// public Object getWard() {
	// 	return this.ward;
	// }

	// public void setWard(Object ward) {
	// 	this.ward = ward;
	// }

	// public List<Order> getOrders() {
	// 	return this.orders;
	// }

	// public void setOrders(List<Order> orders) {
	// 	this.orders = orders;
	// }

	// public Order addOrder(Order order) {
	// 	getOrders().add(order);
	// 	order.setShippingAddress(this);

	// 	return order;
	// }

	// public Order removeOrder(Order order) {
	// 	getOrders().remove(order);
	// 	order.setShippingAddress(null);

	// 	return order;
	// }

	// public User getUser() {
	// 	return this.user;
	// }

	// public void setUser(User user) {
	// 	this.user = user;
	// }

}