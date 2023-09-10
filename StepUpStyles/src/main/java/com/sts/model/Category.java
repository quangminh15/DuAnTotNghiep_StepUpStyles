package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the category database table.
 * 
 */
@Entity
@Table(name="category")
@NamedQuery(name="Category.findAll", query="SELECT c FROM Category c")
public class Category implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="category_id")
	private long categoryId;

	private boolean activities;

	@Column(name="category_image")
	private Object categoryImage;

	@Column(name="category_name")
	private Object categoryName;

	private boolean deleted;

	//bi-directional many-to-one association to Product
	@OneToMany(mappedBy="category")
	private List<Product> products;

	public Category() {
	}

	public long getCategoryId() {
		return this.categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}

	public boolean getActivities() {
		return this.activities;
	}

	public void setActivities(boolean activities) {
		this.activities = activities;
	}

	public Object getCategoryImage() {
		return this.categoryImage;
	}

	public void setCategoryImage(Object categoryImage) {
		this.categoryImage = categoryImage;
	}

	public Object getCategoryName() {
		return this.categoryName;
	}

	public void setCategoryName(Object categoryName) {
		this.categoryName = categoryName;
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
		product.setCategory(this);

		return product;
	}

	public Product removeProduct(Product product) {
		getProducts().remove(product);
		product.setCategory(null);

		return product;
	}

}