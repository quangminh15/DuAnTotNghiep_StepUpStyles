package com.sts.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name="payment_menthod")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaymentMenthod implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="payment_method_id")
	private long paymentMethodId;

	private String description;

	private boolean display;

	@Column(name="payment_menthod_name")
	private String paymentMenthodName;

	@JsonIgnore
	@OneToMany(mappedBy="paymentMenthod")
	private List<Order> orders;

}