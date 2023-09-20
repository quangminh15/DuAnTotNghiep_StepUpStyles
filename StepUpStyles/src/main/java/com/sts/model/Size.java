package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "size")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Size implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "size_id")
	private Integer sizeID;

	private Boolean activities;

	private Boolean deleted;

	@Column(name = "size_number")
	private Float sizeNumber;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "modify_date")
	private Date modifyDate = new Date();

	@JsonIgnore
	@OneToMany(mappedBy = "size")
	private List<ProductDetail> productDetails;
}