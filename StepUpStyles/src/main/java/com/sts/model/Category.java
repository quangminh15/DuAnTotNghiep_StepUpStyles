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
@Table(name="category")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Category implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="category_id")
	private Integer categoryID;

	private Boolean activities;

	@Column(name="category_image")
	private String categoryImage;

	@Column(name="category_name")
	private String categoryName;

	private Boolean deleted;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "modify_date")
	private Date modifyDate = new Date();
	
	@JsonIgnore
	@OneToMany(mappedBy="category")
	private List<Product> products;
}