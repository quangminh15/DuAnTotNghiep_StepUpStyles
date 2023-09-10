package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;


/**
 * The persistent class for the direct_discount database table.
 * 
 */
@Entity
@Table(name="direct_discount")
@NamedQuery(name="DirectDiscount.findAll", query="SELECT d FROM DirectDiscount d")
public class DirectDiscount implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="direct_discount_id")
	private long directDiscountId;

	@Column(name="direct_discount")
	private BigDecimal directDiscount;

	@Column(name="end_date")
	private Timestamp endDate;

	@Column(name="start_date")
	private Timestamp startDate;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="product_id")
	private Product product;

	public DirectDiscount() {
	}

	public long getDirectDiscountId() {
		return this.directDiscountId;
	}

	public void setDirectDiscountId(long directDiscountId) {
		this.directDiscountId = directDiscountId;
	}

	public BigDecimal getDirectDiscount() {
		return this.directDiscount;
	}

	public void setDirectDiscount(BigDecimal directDiscount) {
		this.directDiscount = directDiscount;
	}

	public Timestamp getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}

	public Timestamp getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

}