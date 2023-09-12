package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "product")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "product_id")
	private Integer productID;

	private Boolean activities;

	@Temporal(TemporalType.DATE)
	@Column(name = "created_date")
	private Date createdDate = new Date();

	private Boolean deleted;

	private Boolean featured;

	private Double price;

	@Column(name = "product_description")
	private String description;

	@Column(name = "product_name")
	private String productName;

	@JsonIgnore
	@OneToMany(mappedBy = "product")
	private List<CartDetail> cartDetails;

	@JsonIgnore
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private List<Color> colors;

	@JsonIgnore
	@OneToMany(mappedBy = "product")
	private List<DirectDiscount> directDiscounts;

	@JsonIgnore
	@OneToMany(mappedBy = "product")
	private List<Favorite> favorites;

	@ManyToOne
	@JoinColumn(name = "brand_id")
	private Brand brand;

	@ManyToOne
	@JoinColumn(name = "category_id")
	private Category category;

	@ManyToOne
	@JoinColumn(name = "users_id")
	private User user;

	@JsonIgnore
	@OneToMany(mappedBy = "product" )
	private List<ProductDetail> productDetails;

	@JsonIgnore
	@OneToMany(mappedBy = "product")
	private List<Review> reviews;

}