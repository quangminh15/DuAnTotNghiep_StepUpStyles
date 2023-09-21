package com.sts.api;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.DTO.CategoryProductCountDTO;

@CrossOrigin("*")
@RestController
public class CategoryProductCountController {
	@PersistenceContext
	private EntityManager entityManager;

	@GetMapping("/sql-category-product-count")
	public List<CategoryProductCountDTO> getCategoryProductCount() {
		String sql = "SELECT c.category_name, SUM(pd.quantity) AS product_count " + "FROM category c "
				+ "INNER JOIN product p ON c.category_id = p.category_id "
				+ "INNER JOIN product_detail pd ON p.product_id = pd.product_id " + "GROUP BY c.category_name";

		// Thực hiện truy vấn SQL native và ánh xạ kết quả vào DTO
		List<CategoryProductCountDTO> categoryProductCounts = entityManager
				.createNativeQuery(sql, "CategoryProductCountDTOMapping") // Chú ý tên ResultSetMapping ở đây
				.getResultList();

		return categoryProductCounts;
	}
}
