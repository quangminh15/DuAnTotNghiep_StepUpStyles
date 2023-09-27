package com.sts.model.DTO;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.SqlResultSetMapping;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@SqlResultSetMapping(name = "TotalProductRatingDTOMapping", classes = @ConstructorResult(targetClass = TotalProductRatingDTO.class, columns = {
		@ColumnResult(name = "rating", type = Integer.class),
		@ColumnResult(name = "productCount", type = Long.class) }))
public class TotalProductRatingDTO {
	private Integer rating;
	private Long productCount;
}