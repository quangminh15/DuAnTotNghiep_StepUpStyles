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
@Table(name="voucher")
@NamedQuery(name="Voucher.findAll", query="SELECT v FROM Voucher v")
public class Voucher implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="voucher_id")
	private Long voucherId;

    @Column(name="discount_amount")
	private Double discountAmount;

    @Column(name="date_end")
	private String dateEnd;

	@Column(name="date_start")
	private String dateStart;

    private String description;

    private Double total;

    private Boolean deleted;

    @Column(name="mini_order")
    private Double miniOrder;

    @JsonIgnore
    @OneToMany(mappedBy = "voucher")
    private List<VoucherUse> voucherUse;
}
