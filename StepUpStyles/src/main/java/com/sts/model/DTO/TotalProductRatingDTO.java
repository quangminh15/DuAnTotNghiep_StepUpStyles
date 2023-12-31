package com.sts.model.DTO;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TotalProductRatingDTO {
	private int month;
    private Map<String, Integer> ratings;
}