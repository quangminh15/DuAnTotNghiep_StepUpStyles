package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the users database table.
 * 
 */
@Entity
@Table(name="users")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="users_id")
	private long usersId;

	private boolean activaties;

	private Object address;

	private Object birthday;

	@Column(name="created_date")
	private Object createdDate;

	private boolean deleted;

	private Object email;

	@Column(name="full_name")
	private Object fullName;

	private Object image;

	private Object password;

	private Object phone;

	private Object role;

	private boolean status;

	//bi-directional many-to-one association to Cart
	@OneToMany(mappedBy="user")
	private List<Cart> carts;

	//bi-directional many-to-one association to Favorite
	@OneToMany(mappedBy="user")
	private List<Favorite> favorites;

	//bi-directional many-to-one association to ImportReceipt
	@OneToMany(mappedBy="user")
	private List<ImportReceipt> importReceipts;

	//bi-directional many-to-one association to Order
	@OneToMany(mappedBy="user")
	private List<Order> orders;

	//bi-directional many-to-one association to Product
	@OneToMany(mappedBy="user")
	private List<Product> products;

	//bi-directional many-to-one association to Review
	@OneToMany(mappedBy="user")
	private List<Review> reviews;

	//bi-directional many-to-one association to ShippingAddress
	@OneToMany(mappedBy="user")
	private List<ShippingAddress> shippingAddresses;

	public User() {
	}

	public long getUsersId() {
		return this.usersId;
	}

	public void setUsersId(long usersId) {
		this.usersId = usersId;
	}

	public boolean getActivaties() {
		return this.activaties;
	}

	public void setActivaties(boolean activaties) {
		this.activaties = activaties;
	}

	public Object getAddress() {
		return this.address;
	}

	public void setAddress(Object address) {
		this.address = address;
	}

	public Object getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Object birthday) {
		this.birthday = birthday;
	}

	public Object getCreatedDate() {
		return this.createdDate;
	}

	public void setCreatedDate(Object createdDate) {
		this.createdDate = createdDate;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public Object getEmail() {
		return this.email;
	}

	public void setEmail(Object email) {
		this.email = email;
	}

	public Object getFullName() {
		return this.fullName;
	}

	public void setFullName(Object fullName) {
		this.fullName = fullName;
	}

	public Object getImage() {
		return this.image;
	}

	public void setImage(Object image) {
		this.image = image;
	}

	public Object getPassword() {
		return this.password;
	}

	public void setPassword(Object password) {
		this.password = password;
	}

	public Object getPhone() {
		return this.phone;
	}

	public void setPhone(Object phone) {
		this.phone = phone;
	}

	public Object getRole() {
		return this.role;
	}

	public void setRole(Object role) {
		this.role = role;
	}

	public boolean getStatus() {
		return this.status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public List<Cart> getCarts() {
		return this.carts;
	}

	public void setCarts(List<Cart> carts) {
		this.carts = carts;
	}

	public Cart addCart(Cart cart) {
		getCarts().add(cart);
		cart.setUser(this);

		return cart;
	}

	public Cart removeCart(Cart cart) {
		getCarts().remove(cart);
		cart.setUser(null);

		return cart;
	}

	public List<Favorite> getFavorites() {
		return this.favorites;
	}

	public void setFavorites(List<Favorite> favorites) {
		this.favorites = favorites;
	}

	public Favorite addFavorite(Favorite favorite) {
		getFavorites().add(favorite);
		favorite.setUser(this);

		return favorite;
	}

	public Favorite removeFavorite(Favorite favorite) {
		getFavorites().remove(favorite);
		favorite.setUser(null);

		return favorite;
	}

	public List<ImportReceipt> getImportReceipts() {
		return this.importReceipts;
	}

	public void setImportReceipts(List<ImportReceipt> importReceipts) {
		this.importReceipts = importReceipts;
	}

	public ImportReceipt addImportReceipt(ImportReceipt importReceipt) {
		getImportReceipts().add(importReceipt);
		importReceipt.setUser(this);

		return importReceipt;
	}

	public ImportReceipt removeImportReceipt(ImportReceipt importReceipt) {
		getImportReceipts().remove(importReceipt);
		importReceipt.setUser(null);

		return importReceipt;
	}

	public List<Order> getOrders() {
		return this.orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

	public Order addOrder(Order order) {
		getOrders().add(order);
		order.setUser(this);

		return order;
	}

	public Order removeOrder(Order order) {
		getOrders().remove(order);
		order.setUser(null);

		return order;
	}

	public List<Product> getProducts() {
		return this.products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Product addProduct(Product product) {
		getProducts().add(product);
		product.setUser(this);

		return product;
	}

	public Product removeProduct(Product product) {
		getProducts().remove(product);
		product.setUser(null);

		return product;
	}

	public List<Review> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public Review addReview(Review review) {
		getReviews().add(review);
		review.setUser(this);

		return review;
	}

	public Review removeReview(Review review) {
		getReviews().remove(review);
		review.setUser(null);

		return review;
	}

	public List<ShippingAddress> getShippingAddresses() {
		return this.shippingAddresses;
	}

	public void setShippingAddresses(List<ShippingAddress> shippingAddresses) {
		this.shippingAddresses = shippingAddresses;
	}

	public ShippingAddress addShippingAddress(ShippingAddress shippingAddress) {
		getShippingAddresses().add(shippingAddress);
		shippingAddress.setUser(this);

		return shippingAddress;
	}

	public ShippingAddress removeShippingAddress(ShippingAddress shippingAddress) {
		getShippingAddresses().remove(shippingAddress);
		shippingAddress.setUser(null);

		return shippingAddress;
	}

}