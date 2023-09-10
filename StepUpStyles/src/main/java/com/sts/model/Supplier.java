package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the supplier database table.
 * 
 */
@Entity
@Table(name="supplier")
@NamedQuery(name="Supplier.findAll", query="SELECT s FROM Supplier s")
public class Supplier implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="supplier_id")
	private long supplierId;

	private Object addresss;

	private boolean deleted;

	private boolean display;

	private String email;

	private String phone;

	@Column(name="supplier_name")
	private Object supplierName;

	//bi-directional many-to-one association to ImportReceipt
	@OneToMany(mappedBy="supplier")
	private List<ImportReceipt> importReceipts;

	public Supplier() {
	}

	public long getSupplierId() {
		return this.supplierId;
	}

	public void setSupplierId(long supplierId) {
		this.supplierId = supplierId;
	}

	public Object getAddresss() {
		return this.addresss;
	}

	public void setAddresss(Object addresss) {
		this.addresss = addresss;
	}

	public boolean getDeleted() {
		return this.deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public boolean getDisplay() {
		return this.display;
	}

	public void setDisplay(boolean display) {
		this.display = display;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Object getSupplierName() {
		return this.supplierName;
	}

	public void setSupplierName(Object supplierName) {
		this.supplierName = supplierName;
	}

	public List<ImportReceipt> getImportReceipts() {
		return this.importReceipts;
	}

	public void setImportReceipts(List<ImportReceipt> importReceipts) {
		this.importReceipts = importReceipts;
	}

	public ImportReceipt addImportReceipt(ImportReceipt importReceipt) {
		getImportReceipts().add(importReceipt);
		importReceipt.setSupplier(this);

		return importReceipt;
	}

	public ImportReceipt removeImportReceipt(ImportReceipt importReceipt) {
		getImportReceipts().remove(importReceipt);
		importReceipt.setSupplier(null);

		return importReceipt;
	}

}