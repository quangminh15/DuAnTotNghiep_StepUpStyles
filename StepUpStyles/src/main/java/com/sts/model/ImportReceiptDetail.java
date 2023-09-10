package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the import_receipt_detail database table.
 * 
 */
@Entity
@Table(name="import_receipt_detail")
@NamedQuery(name="ImportReceiptDetail.findAll", query="SELECT i FROM ImportReceiptDetail i")
public class ImportReceiptDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="import_receipt_detail_id")
	private long importReceiptDetailId;

	private boolean deleted;

	private double price;

	private int quantity;

	//bi-directional many-to-one association to ImportReceipt
	@ManyToOne
	@JoinColumn(name="import_receipt_id")
	private ImportReceipt importReceipt;

	//bi-directional many-to-one association to ProductDetail
	@ManyToOne
	@JoinColumn(name="product_detail_id")
	private ProductDetail productDetail;

	public ImportReceiptDetail() {
	}

	public long getImportReceiptDetailId() {
		return this.importReceiptDetailId;
	}

	public void setImportReceiptDetailId(long importReceiptDetailId) {
		this.importReceiptDetailId = importReceiptDetailId;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public double getPrice() {
		return this.price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return this.quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public ImportReceipt getImportReceipt() {
		return this.importReceipt;
	}

	public void setImportReceipt(ImportReceipt importReceipt) {
		this.importReceipt = importReceipt;
	}

	public ProductDetail getProductDetail() {
		return this.productDetail;
	}

	public void setProductDetail(ProductDetail productDetail) {
		this.productDetail = productDetail;
	}

}