package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * The persistent class for the shipping_address database table.
 * 
 */
@Entity
@Table(name="shipping_address")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ShippingAddress implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="shipping_address_id")
	private Integer shippingAddressId;

	@Column(name="address_details")
	private String addressDetails;

	@Column(name="default_address")
	private boolean defaultAddress;

	@Column(name="name_receiver")
	private String nameReceiver;

	@Column(name="phone_receiver")
	private String phoneReceiver;

	private String district;

	private String province;

	private String ward;

	//bi-directional many-to-one association to Order
	@JsonIgnore
	@OneToMany(mappedBy="shippingAddress")
	private List<Order> orders;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="users_id")
	private User user;

	

}