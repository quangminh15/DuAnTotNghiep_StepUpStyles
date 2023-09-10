package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the color database table.
 * 
 */
@Entity
@Table(name="color")
@NamedQuery(name="Color.findAll", query="SELECT c FROM Color c")
public class Color implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="color_id")
	private long colorId;

	private boolean activities;

	@Column(name="color_image")
	private Object colorImage;

	@Column(name="color_name")
	private Object colorName;

	private boolean deleted;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="product_id")
	private Product product;

	//bi-directional many-to-one association to ProductDetail
	@OneToMany(mappedBy="color")
	private List<ProductDetail> productDetails;

	public Color() {
	}

	public long getColorId() {
		return this.colorId;
	}

	public void setColorId(long colorId) {
		this.colorId = colorId;
	}

	public boolean getActivities() {
		return this.activities;
	}

	public void setActivities(boolean activities) {
		this.activities = activities;
	}

	public Object getColorImage() {
		return this.colorImage;
	}

	public void setColorImage(Object colorImage) {
		this.colorImage = colorImage;
	}

	public Object getColorName() {
		return this.colorName;
	}

	public void setColorName(Object colorName) {
		this.colorName = colorName;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public List<ProductDetail> getProductDetails() {
		return this.productDetails;
	}

	public void setProductDetails(List<ProductDetail> productDetails) {
		this.productDetails = productDetails;
	}

	public ProductDetail addProductDetail(ProductDetail productDetail) {
		getProductDetails().add(productDetail);
		productDetail.setColor(this);

		return productDetail;
	}

	public ProductDetail removeProductDetail(ProductDetail productDetail) {
		getProductDetails().remove(productDetail);
		productDetail.setColor(null);

		return productDetail;
	}

}