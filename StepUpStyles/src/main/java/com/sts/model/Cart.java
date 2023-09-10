package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * The persistent class for the cart database table.
 * 
 */
@Entity
@Table(name="cart")
@Data
@AllArgsConstructor
@NoArgsConstructor
@NamedQuery(name="Cart.findAll", query="SELECT c FROM Cart c")
public class Cart implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="cart_id")
	private Integer cartId;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="users_id")
	private User user;

	//bi-directional many-to-one association to CartDetail
	@JsonIgnore
	@OneToMany(mappedBy="cart")
	private List<CartDetail> cartDetails;

	// public Cart() {
	// }

	// public long getCartId() {
	// 	return this.cartId;
	// }

	// public void setCartId(long cartId) {
	// 	this.cartId = cartId;
	// }

	// public User getUser() {
	// 	return this.user;
	// }

	// public void setUser(User user) {
	// 	this.user = user;
	// }

	// public List<CartDetail> getCartDetails() {
	// 	return this.cartDetails;
	// }

	// public void setCartDetails(List<CartDetail> cartDetails) {
	// 	this.cartDetails = cartDetails;
	// }

	// public CartDetail addCartDetail(CartDetail cartDetail) {
	// 	getCartDetails().add(cartDetail);
	// 	cartDetail.setCart(this);

	// 	return cartDetail;
	// }

	// public CartDetail removeCartDetail(CartDetail cartDetail) {
	// 	getCartDetails().remove(cartDetail);
	// 	cartDetail.setCart(null);

	// 	return cartDetail;
	// }

}