package com.sts.model.DTO;

import java.util.Map;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.SqlResultSetMapping;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TotalProductRatingDTO {
	private int month;
    private String productName;
    private Map<String, Integer> ratings;

    public TotalProductRatingDTO(int month, Map<String, Integer> ratings) {
        this.month = month;
        this.ratings = ratings;
    }
}