package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the size database table.
 * 
 */
@Entity
@Table(name="size")
@NamedQuery(name="Size.findAll", query="SELECT s FROM Size s")
public class Size implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="size_id")
	private long sizeId;

	private boolean activities;

	private boolean deleted;

	@Column(name="size_number")
	private double sizeNumber;

	//bi-directional many-to-one association to ProductDetail
	@OneToMany(mappedBy="size")
	private List<ProductDetail> productDetails;

	public Size() {
	}

	public long getSizeId() {
		return this.sizeId;
	}

	public void setSizeId(long sizeId) {
		this.sizeId = sizeId;
	}

	public boolean getActivities() {
		return this.activities;
	}

	public void setActivities(boolean activities) {
		this.activities = activities;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public double getSizeNumber() {
		return this.sizeNumber;
	}

	public void setSizeNumber(double sizeNumber) {
		this.sizeNumber = sizeNumber;
	}

	public List<ProductDetail> getProductDetails() {
		return this.productDetails;
	}

	public void setProductDetails(List<ProductDetail> productDetails) {
		this.productDetails = productDetails;
	}

	public ProductDetail addProductDetail(ProductDetail productDetail) {
		getProductDetails().add(productDetail);
		productDetail.setSize(this);

		return productDetail;
	}

	public ProductDetail removeProductDetail(ProductDetail productDetail) {
		getProductDetails().remove(productDetail);
		productDetail.setSize(null);

		return productDetail;
	}

}