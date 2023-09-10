package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * The persistent class for the import_receipt_detail database table.
 * 
 */
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name="import_receipt_detail")
@NamedQuery(name="ImportReceiptDetail.findAll", query="SELECT i FROM ImportReceiptDetail i")
public class ImportReceiptDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="import_receipt_detail_id")
	private Long importReceiptDetailId;

	private Boolean deleted;

	private Double price;

	private Integer quantity;

	//bi-directional many-to-one association to ImportReceipt
	@ManyToOne
	@JoinColumn(name="import_receipt_id")
	private ImportReceipt importReceipt;

	//bi-directional many-to-one association to ProductDetail
	@ManyToOne
	@JoinColumn(name="product_detail_id")
	private ProductDetail productDetail;

}