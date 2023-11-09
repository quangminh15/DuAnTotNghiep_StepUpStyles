package com.sts.model;
import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="voucher_use")
@NamedQuery(name="VoucherUse.findAll", query="SELECT v FROM VoucherUse v")
public class VoucherUse implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="voucher_use_id")
	private Long VoucherUseId;

    @Column(name="use_date")
	private String UseDate;

    @JsonIgnore
    @OneToMany(mappedBy = "voucherUse")
    private List<Order> order;

    @ManyToOne
    @JoinColumn(name="users_id")
	private User user;

    @ManyToOne
    @JoinColumn(name="voucher_id")
    private Voucher voucher;
}
