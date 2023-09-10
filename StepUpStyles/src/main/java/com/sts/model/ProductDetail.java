package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the product_detail database table.
 * 
 */
@Entity
@Table(name="product_detail")
@NamedQuery(name="ProductDetail.findAll", query="SELECT p FROM ProductDetail p")
public class ProductDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="product_detail_id")
	private long productDetailId;

	private boolean deleted;

	private long quantity;

	//bi-directional many-to-one association to CartDetail
	@OneToMany(mappedBy="productDetail")
	private List<CartDetail> cartDetails;

	//bi-directional many-to-one association to ImportReceiptDetail
	@OneToMany(mappedBy="productDetail")
	private List<ImportReceiptDetail> importReceiptDetails;

	//bi-directional many-to-one association to OrderDetail
	@OneToMany(mappedBy="productDetail")
	private List<OrderDetail> orderDetails;

	//bi-directional many-to-one association to Color
	@ManyToOne
	@JoinColumn(name="color_id")
	private Color color;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="product_id")
	private Product product;

	//bi-directional many-to-one association to Size
	@ManyToOne
	@JoinColumn(name="size_id")
	private Size size;

	public ProductDetail() {
	}

	public long getProductDetailId() {
		return this.productDetailId;
	}

	public void setProductDetailId(long productDetailId) {
		this.productDetailId = productDetailId;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public long getQuantity() {
		return this.quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public List<CartDetail> getCartDetails() {
		return this.cartDetails;
	}

	public void setCartDetails(List<CartDetail> cartDetails) {
		this.cartDetails = cartDetails;
	}

	public CartDetail addCartDetail(CartDetail cartDetail) {
		getCartDetails().add(cartDetail);
		cartDetail.setProductDetail(this);

		return cartDetail;
	}

	public CartDetail removeCartDetail(CartDetail cartDetail) {
		getCartDetails().remove(cartDetail);
		cartDetail.setProductDetail(null);

		return cartDetail;
	}

	public List<ImportReceiptDetail> getImportReceiptDetails() {
		return this.importReceiptDetails;
	}

	public void setImportReceiptDetails(List<ImportReceiptDetail> importReceiptDetails) {
		this.importReceiptDetails = importReceiptDetails;
	}

	public ImportReceiptDetail addImportReceiptDetail(ImportReceiptDetail importReceiptDetail) {
		getImportReceiptDetails().add(importReceiptDetail);
		importReceiptDetail.setProductDetail(this);

		return importReceiptDetail;
	}

	public ImportReceiptDetail removeImportReceiptDetail(ImportReceiptDetail importReceiptDetail) {
		getImportReceiptDetails().remove(importReceiptDetail);
		importReceiptDetail.setProductDetail(null);

		return importReceiptDetail;
	}

	public List<OrderDetail> getOrderDetails() {
		return this.orderDetails;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public OrderDetail addOrderDetail(OrderDetail orderDetail) {
		getOrderDetails().add(orderDetail);
		orderDetail.setProductDetail(this);

		return orderDetail;
	}

	public OrderDetail removeOrderDetail(OrderDetail orderDetail) {
		getOrderDetails().remove(orderDetail);
		orderDetail.setProductDetail(null);

		return orderDetail;
	}

	public Color getColor() {
		return this.color;
	}

	public void setColor(Color color) {
		this.color = color;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Size getSize() {
		return this.size;
	}

	public void setSize(Size size) {
		this.size = size;
	}

}