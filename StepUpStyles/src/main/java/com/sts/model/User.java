package com.sts.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * The persistent class for the users database table.
 * 
 */
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name="users")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="users_id")
	private Integer usersId;

	private Boolean activaties;

	private String address;

	private Date birthday;

	@Column(name="created_date")
	private Date createdDate;

	private Boolean deleted;

	private String email;

	@Column(name="full_name")
	private String fullName;

	private String image;

	private String password;

	private String phone;

	private String role;

	private Boolean status;

	//bi-directional many-to-one association to Cart
	@OneToMany(mappedBy="user")
	@JsonIgnore
	private List<Cart> carts;

	//bi-directional many-to-one association to Favorite
	@OneToMany(mappedBy="user")
	@JsonIgnore
	private List<Favorite> favorites;

	//bi-directional many-to-one association to ImportReceipt
	@OneToMany(mappedBy="user")
	@JsonIgnore
	private List<ImportReceipt> importReceipts;

	//bi-directional many-to-one association to Order
	@OneToMany(mappedBy="user")
	private List<Order> orders;

	//bi-directional many-to-one association to Product
	@OneToMany(mappedBy="user")
	@JsonIgnore
	private List<Product> products;

	//bi-directional many-to-one association to Review
	@OneToMany(mappedBy="user")
	@JsonIgnore
	private List<Review> reviews;

	//bi-directional many-to-one association to ShippingAddress
	@OneToMany(mappedBy="user")
	@JsonIgnore
	private List<ShippingAddress> shippingAddresses;

	

	

}