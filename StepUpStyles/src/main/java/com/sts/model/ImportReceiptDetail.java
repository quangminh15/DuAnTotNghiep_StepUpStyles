package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;

@Entity
@Data
@Table(name="import_receipt_detail")
@NamedQuery(name="ImportReceiptDetail.findAll", query="SELECT i FROM ImportReceiptDetail i")
public class ImportReceiptDetail implements Serializable {
    private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="import_receipt_detail_id")
	private Long importReceiptDetailId;

	private Boolean deleted;

	private Double price;

	private Integer quantity;

	@ManyToOne
	@JoinColumn(name="import_receipt_id")
	private ImportReceipt importReceipt;

	@ManyToOne
	@JoinColumn(name="product_detail_id")
	private ProductDetail productDetail;
}
