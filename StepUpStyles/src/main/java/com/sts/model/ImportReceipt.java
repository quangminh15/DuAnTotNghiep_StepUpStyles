package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * The persistent class for the import_receipt database table.
 * 
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="import_receipt")
@NamedQuery(name="ImportReceipt.findAll", query="SELECT i FROM ImportReceipt i")
public class ImportReceipt implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="import_receipt_id")
	private Long importReceiptId;

	private Boolean deleted;

	@Column(name="import_date")
	private String importDate;

	@Column(name="total_amount")
	private Double totalAmount;

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