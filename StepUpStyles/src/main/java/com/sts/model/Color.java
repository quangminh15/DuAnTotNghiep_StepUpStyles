package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "color")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Color implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "color_id")
	private Integer colorID;

	private Boolean activities;

	@Column(name = "color_image")
	private String colorImage;

	@Column(name = "color_name")
	private String colorName;

	private Boolean deleted;

	@ManyToOne
	@JoinColumn(name = "product_id")
	private Product product;

	@JsonIgnore
	@OneToMany(mappedBy = "color", fetch = FetchType.EAGER)
	private List<ProductDetail> productDetails;
}