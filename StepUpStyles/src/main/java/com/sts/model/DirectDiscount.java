package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;


/**
 * The persistent class for the direct_discount database table.
 * 
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="direct_discount")
@NamedQuery(name="DirectDiscount.findAll", query="SELECT d FROM DirectDiscount d")
public class DirectDiscount implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="direct_discount_id")
	private Long directDiscountId;

	@Column(name="direct_discount")
	private BigDecimal directDiscount;

	@Column(name="end_date")
	private String endDate;

	@Column(name="start_date")
	private String startDate;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="product_id")
	private Product product;
}