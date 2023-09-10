package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;


/**
 * The persistent class for the review database table.
 * 
 */
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name="review")
@NamedQuery(name="Review.findAll", query="SELECT r FROM Review r")
public class Review implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="review_id")
	private Integer reviewId;

	private boolean display;

	private Integer rating;

	@Column(name="review_date")
	private Timestamp reviewDate;

	private String title;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="product_id")
	private Product product;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="users_id")
	private User user;

}