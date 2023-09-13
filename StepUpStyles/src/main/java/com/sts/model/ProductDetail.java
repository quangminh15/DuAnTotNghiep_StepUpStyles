package com.sts.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="product_detail")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="product_detail_id")
	private Integer productDetailID;

	private Boolean deleted;

	private Integer quantity;

	@JsonIgnore
	@OneToMany(mappedBy="productDetail")
	private List<CartDetail> cartDetails;

	@JsonIgnore
	@OneToMany(mappedBy="productDetail")
	private List<ImportReceiptDetail> importReceiptDetails;

	@JsonIgnore
	@OneToMany(mappedBy="productDetail")
	private List<OrderDetail> orderDetails;

	@ManyToOne
	@JoinColumn(name="color_id")
	private Color color;

	@ManyToOne
	@JoinColumn(name="product_id")
	private Product product;

	@ManyToOne
	@JoinColumn(name="size_id")
	private Size size;
}