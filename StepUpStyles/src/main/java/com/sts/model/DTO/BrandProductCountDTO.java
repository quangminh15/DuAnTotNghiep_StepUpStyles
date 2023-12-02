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
@SqlResultSetMapping(name = "BrandProductCountDTOMapping", classes = @ConstructorResult(targetClass = BrandProductCountDTO.class, columns = {
		@ColumnResult(name = "brandName", type = String.class),
		@ColumnResult(name = "productCount", type = Long.class) }))
public class BrandProductCountDTO {
	private String brandName;
	private Long productCount;
}
