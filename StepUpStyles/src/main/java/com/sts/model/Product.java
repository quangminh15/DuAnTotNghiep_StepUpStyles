package com.sts.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
	@Column(name = "modify_date")
	private Date modifyDate = new Date();

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
	private List<ProductImage> productImages;

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