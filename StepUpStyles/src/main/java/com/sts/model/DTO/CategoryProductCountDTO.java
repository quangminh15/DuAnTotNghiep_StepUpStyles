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
@SqlResultSetMapping(name = "CategoryProductCountDTOMapping", classes = @ConstructorResult(targetClass = CategoryProductCountDTO.class, columns = {
		@ColumnResult(name = "categoryName", type = String.class),
		@ColumnResult(name = "productCount", type = Long.class) }))
public class CategoryProductCountDTO {
	private String categoryName;
	private Long productCount;
}
