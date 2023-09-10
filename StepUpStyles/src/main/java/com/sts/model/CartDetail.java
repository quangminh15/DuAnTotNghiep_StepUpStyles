package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * The persistent class for the cart_detail database table.
 * 
 */
@Entity
@Table(name="cart_detail")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="cart_detail_id")
	private Integer cartDetailId;

	private int quantity;

	//bi-directional many-to-one association to Cart
	@ManyToOne
	@JoinColumn(name="cart_id")
	private Cart cart;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="product_id")
	private Product product;

	//bi-directional many-to-one association to ProductDetail
	@ManyToOne
	@JoinColumn(name="product_detail_id")
	private ProductDetail productDetail;

	// public CartDetail() {
	// }

	// public long getCartDetailId() {
	// 	return this.cartDetailId;
	// }

	// public void setCartDetailId(long cartDetailId) {
	// 	this.cartDetailId = cartDetailId;
	// }

	// public int getQuantity() {
	// 	return this.quantity;
	// }

	// public void setQuantity(int quantity) {
	// 	this.quantity = quantity;
	// }

	// public Cart getCart() {
	// 	return this.cart;
	// }

	// public void setCart(Cart cart) {
	// 	this.cart = cart;
	// }

	// public Product getProduct() {
	// 	return this.product;
	// }

	// public void setProduct(Product product) {
	// 	this.product = product;
	// }

	// public ProductDetail getProductDetail() {
	// 	return this.productDetail;
	// }

	// public void setProductDetail(ProductDetail productDetail) {
	// 	this.productDetail = productDetail;
	// }

}