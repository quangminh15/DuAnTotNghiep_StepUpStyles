package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the product database table.
 * 
 */
@Entity
@Table(name="product")
@NamedQuery(name="Product.findAll", query="SELECT p FROM Product p")
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="product_id")
	private long productId;

	private boolean activities;

	@Column(name="created_date")
	private Timestamp createdDate;

	private boolean deleted;

	private boolean featured;

	private double price;

	@Column(name="product_description")
	private Object productDescription;

	@Column(name="product_name")
	private Object productName;

	//bi-directional many-to-one association to CartDetail
	@OneToMany(mappedBy="product")
	private List<CartDetail> cartDetails;

	//bi-directional many-to-one association to Color
	@OneToMany(mappedBy="product")
	private List<Color> colors;

	//bi-directional many-to-one association to DirectDiscount
	@OneToMany(mappedBy="product")
	private List<DirectDiscount> directDiscounts;

	//bi-directional many-to-one association to Favorite
	@OneToMany(mappedBy="product")
	private List<Favorite> favorites;

	//bi-directional many-to-one association to Brand
	@ManyToOne
	@JoinColumn(name="brand_id")
	private Brand brand;

	//bi-directional many-to-one association to Category
	@ManyToOne
	@JoinColumn(name="category_id")
	private Category category;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="users_id")
	private User user;

	//bi-directional many-to-one association to ProductDetail
	@OneToMany(mappedBy="product")
	private List<ProductDetail> productDetails;

	//bi-directional many-to-one association to Review
	@OneToMany(mappedBy="product")
	private List<Review> reviews;

	public Product() {
	}

	public long getProductId() {
		return this.productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}

	public boolean getActivities() {
		return this.activities;
	}

	public void setActivities(boolean activities) {
		this.activities = activities;
	}

	public Timestamp getCreatedDate() {
		return this.createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public boolean getFeatured() {
		return this.featured;
	}

	public void setFeatured(boolean featured) {
		this.featured = featured;
	}

	public double getPrice() {
		return this.price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Object getProductDescription() {
		return this.productDescription;
	}

	public void setProductDescription(Object productDescription) {
		this.productDescription = productDescription;
	}

	public Object getProductName() {
		return this.productName;
	}

	public void setProductName(Object productName) {
		this.productName = productName;
	}

	public List<CartDetail> getCartDetails() {
		return this.cartDetails;
	}

	public void setCartDetails(List<CartDetail> cartDetails) {
		this.cartDetails = cartDetails;
	}

	public CartDetail addCartDetail(CartDetail cartDetail) {
		getCartDetails().add(cartDetail);
		cartDetail.setProduct(this);

		return cartDetail;
	}

	public CartDetail removeCartDetail(CartDetail cartDetail) {
		getCartDetails().remove(cartDetail);
		cartDetail.setProduct(null);

		return cartDetail;
	}

	public List<Color> getColors() {
		return this.colors;
	}

	public void setColors(List<Color> colors) {
		this.colors = colors;
	}

	public Color addColor(Color color) {
		getColors().add(color);
		color.setProduct(this);

		return color;
	}

	public Color removeColor(Color color) {
		getColors().remove(color);
		color.setProduct(null);

		return color;
	}

	public List<DirectDiscount> getDirectDiscounts() {
		return this.directDiscounts;
	}

	public void setDirectDiscounts(List<DirectDiscount> directDiscounts) {
		this.directDiscounts = directDiscounts;
	}

	public DirectDiscount addDirectDiscount(DirectDiscount directDiscount) {
		getDirectDiscounts().add(directDiscount);
		directDiscount.setProduct(this);

		return directDiscount;
	}

	public DirectDiscount removeDirectDiscount(DirectDiscount directDiscount) {
		getDirectDiscounts().remove(directDiscount);
		directDiscount.setProduct(null);

		return directDiscount;
	}

	public List<Favorite> getFavorites() {
		return this.favorites;
	}

	public void setFavorites(List<Favorite> favorites) {
		this.favorites = favorites;
	}

	public Favorite addFavorite(Favorite favorite) {
		getFavorites().add(favorite);
		favorite.setProduct(this);

		return favorite;
	}

	public Favorite removeFavorite(Favorite favorite) {
		getFavorites().remove(favorite);
		favorite.setProduct(null);

		return favorite;
	}

	public Brand getBrand() {
		return this.brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Category getCategory() {
		return this.category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<ProductDetail> getProductDetails() {
		return this.productDetails;
	}

	public void setProductDetails(List<ProductDetail> productDetails) {
		this.productDetails = productDetails;
	}

	public ProductDetail addProductDetail(ProductDetail productDetail) {
		getProductDetails().add(productDetail);
		productDetail.setProduct(this);

		return productDetail;
	}

	public ProductDetail removeProductDetail(ProductDetail productDetail) {
		getProductDetails().remove(productDetail);
		productDetail.setProduct(null);

		return productDetail;
	}

	public List<Review> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public Review addReview(Review review) {
		getReviews().add(review);
		review.setProduct(this);

		return review;
	}

	public Review removeReview(Review review) {
		getReviews().remove(review);
		review.setProduct(null);

		return review;
	}

}