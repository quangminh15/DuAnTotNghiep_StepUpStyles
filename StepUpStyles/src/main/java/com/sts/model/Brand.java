package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;

import java.util.List;

@Entity
@Table(name="brand")
@NamedQuery(name="Brand.findAll", query="SELECT b FROM Brand b")
public class Brand implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="brand_id")
	private long brandId;

	private boolean activities;

	@Column(name="brand_image")
	private Object brandImage;

	@Column(name="brand_name")
	private Object brandName;

	private boolean deleted;

	//bi-directional many-to-one association to Product
	@OneToMany(mappedBy="brand")
	private List<Product> products;

	public Brand() {
	}

	public long getBrandId() {
		return this.brandId;
	}

	public void setBrandId(long brandId) {
		this.brandId = brandId;
	}

	public boolean getActivities() {
		return this.activities;
	}

	public void setActivities(boolean activities) {
		this.activities = activities;
	}

	public Object getBrandImage() {
		return this.brandImage;
	}

	public void setBrandImage(Object brandImage) {
		this.brandImage = brandImage;
	}

	public Object getBrandName() {
		return this.brandName;
	}

	public void setBrandName(Object brandName) {
		this.brandName = brandName;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public List<Product> getProducts() {
		return this.products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Product addProduct(Product product) {
		getProducts().add(product);
		product.setBrand(this);

		return product;
	}

	public Product removeProduct(Product product) {
		getProducts().remove(product);
		product.setBrand(null);

		return product;
	}

}