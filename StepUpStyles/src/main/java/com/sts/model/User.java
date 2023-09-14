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

	@Column(name="origin")
	private String origin;

	//bi-directional many-to-one association to Cart
	@JsonIgnore
	@OneToMany(mappedBy="user")
	
	private List<Cart> carts;

	//bi-directional many-to-one association to Favorite
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Favorite> favorites;

	//bi-directional many-to-one association to ImportReceipt
	@JsonIgnore
	@OneToMany(mappedBy="user")
	
	private List<ImportReceipt> importReceipts;

	//bi-directional many-to-one association to Order
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Order> orders;

	//bi-directional many-to-one association to Product
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Product> products;

	//bi-directional many-to-one association to Review
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Review> reviews;

	//bi-directional many-to-one association to ShippingAddress
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<ShippingAddress> shippingAddresses;

	

	

}