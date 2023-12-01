package com.sts.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;


/**
 * The persistent class for the users database table.
 * 
 */
@Entity
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name="users")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="users_id")
	@JsonProperty
	private Integer usersId;

	private Boolean activaties;

	private String address;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthday;

	@Column(name="created_date")
	private LocalDate createdDate;

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



	//bi-directional many-to-one association to Review
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Review> reviews;

	//bi-directional many-to-one association to ShippingAddress
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<ShippingAddress> shippingAddresses;

	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Product> product;
	
	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<VoucherUse> voucherUse;

}