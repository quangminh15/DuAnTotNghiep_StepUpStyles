package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="direct_discount")
@NamedQuery(name="DirectDiscount.findAll", query="SELECT d FROM DirectDiscount d")
public class DirectDiscount implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="direct_discount_id")
	private Long directDiscountId;

	@Column(name="direct_discount")
	private BigDecimal directDiscount;

	@Column(name="end_date")
	private String endDate;

	@Column(name="start_date")
	private String startDate;

	@Column(name = "status")
	private String status;

	@Column(name = "price_discount")
	private Double priceDiscount;

	private Boolean deleted;

	@ManyToOne
	@JoinColumn(name="product_id")
	private Product product;
}