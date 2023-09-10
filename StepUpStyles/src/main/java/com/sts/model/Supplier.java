package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * The persistent class for the supplier database table.
 * 
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="supplier")
@NamedQuery(name="Supplier.findAll", query="SELECT s FROM Supplier s")
public class Supplier implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="supplier_id")
	private Long supplierId;

	private String addresss;

	private Boolean deleted;

	private Boolean display;

	private String email;

	private String phone;

	@Column(name="supplier_name")
	private String supplierName;

	//bi-directional many-to-one association to ImportReceipt
	@JsonIgnore
	@OneToMany(mappedBy="supplier")
	private List<ImportReceipt> importReceipts;
}