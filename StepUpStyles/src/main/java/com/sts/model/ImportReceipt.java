package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the import_receipt database table.
 * 
 */
@Entity
@Table(name="import_receipt")
@NamedQuery(name="ImportReceipt.findAll", query="SELECT i FROM ImportReceipt i")
public class ImportReceipt implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="import_receipt_id")
	private long importReceiptId;

	private boolean deleted;

	@Column(name="import_date")
	private Timestamp importDate;

	@Column(name="total_amount")
	private double totalAmount;

	//bi-directional many-to-one association to Supplier
	@ManyToOne
	@JoinColumn(name="supplier_id")
	private Supplier supplier;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="users_id")
	private User user;

	//bi-directional many-to-one association to ImportReceiptDetail
	@OneToMany(mappedBy="importReceipt")
	private List<ImportReceiptDetail> importReceiptDetails;

	public ImportReceipt() {
	}

	public long getImportReceiptId() {
		return this.importReceiptId;
	}

	public void setImportReceiptId(long importReceiptId) {
		this.importReceiptId = importReceiptId;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public Timestamp getImportDate() {
		return this.importDate;
	}

	public void setImportDate(Timestamp importDate) {
		this.importDate = importDate;
	}

	public double getTotalAmount() {
		return this.totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Supplier getSupplier() {
		return this.supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<ImportReceiptDetail> getImportReceiptDetails() {
		return this.importReceiptDetails;
	}

	public void setImportReceiptDetails(List<ImportReceiptDetail> importReceiptDetails) {
		this.importReceiptDetails = importReceiptDetails;
	}

	public ImportReceiptDetail addImportReceiptDetail(ImportReceiptDetail importReceiptDetail) {
		getImportReceiptDetails().add(importReceiptDetail);
		importReceiptDetail.setImportReceipt(this);

		return importReceiptDetail;
	}

	public ImportReceiptDetail removeImportReceiptDetail(ImportReceiptDetail importReceiptDetail) {
		getImportReceiptDetails().remove(importReceiptDetail);
		importReceiptDetail.setImportReceipt(null);

		return importReceiptDetail;
	}

}