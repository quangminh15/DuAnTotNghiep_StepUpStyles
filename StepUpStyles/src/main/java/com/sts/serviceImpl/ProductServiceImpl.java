package com.sts.serviceImpl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.sts.dao.CategoryDAO;
import com.sts.dao.ProductDAO;
import com.sts.model.Category;
import com.sts.model.Product;
import com.sts.model.DTO.CategoryProductCountDTO;
import com.sts.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	ProductDAO productDAO;

	@Autowired
	CategoryDAO categoryDAO;

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public Product findById(Integer productID) {
		return productDAO.findById(productID).get();
	}

	@Override
	public List<Product> findAll() {
		return productDAO.findAll();
	}

	@Override
	public List<Product> loadAllDeleted() {
		return productDAO.loadAllDeleted();
	}

	@Override
	public List<Product> loadAllNoDeleted() {
		return productDAO.loadAllNoDeleted();
	}

	@Override
	public List<Product> loadAllNoDeletedAndActivitiesTrue() {
		return productDAO.loadAllNoDeletedAndActivitiesTrue();
	}

	@Override
	public Page<Product> loadAllNoDeletedAndActivitiesTrue(Pageable pageable) {
		return productDAO.loadAllNoDeletedAndActivitiesTrue(pageable);
	}

	@Override
	public Product create(Product product) {
		return productDAO.save(product);
	}

	@Override
	public Product update(Product product) {
		return productDAO.save(product);
	}

	@Override
	public void delete(Integer productID) {
		productDAO.deleteById(productID);
	}

	@Override
	public List<Product> searchByName(String keyword) {
		return productDAO.findByProductNameContaining(keyword);
	}

	@Override
	public List<CategoryProductCountDTO> getCategoryProductCount() {
		List<CategoryProductCountDTO> categoryProductCounts = new ArrayList<>();

		// Lấy danh sách danh mục
		List<Category> categories = categoryDAO.findAll();

		for (Category category : categories) {
			// Sử dụng JPQL để lấy tổng số lượng sản phẩm theo danh mục
			TypedQuery<Long> query = entityManager.createQuery(
					"SELECT SUM(pd.quantity) FROM ProductDetail pd WHERE pd.product.category = :category", Long.class);
			query.setParameter("category", category);

			// Thực hiện truy vấn và lấy kết quả
			Long productCount = query.getSingleResult();

			if (productCount == null) {
				productCount = 0L;
			}

			// Tạo một đối tượng CategoryProductCountDTO và thêm vào danh sách
			CategoryProductCountDTO countDTO = new CategoryProductCountDTO(category.getCategoryName(), productCount);
			categoryProductCounts.add(countDTO);
		}

		return categoryProductCounts;
	}

	// Đếm số lượng sản phẩm trong mỗi danh mục dựa trên ProductDetail
	@Override
	public Long countProductsByCategory(Category category) {
		return productDAO.countProductsByCategory(category);
	}

	// Đếm số lượng sản phẩm để hiển thị lên danh mục người dùng
	@Override
	public Long countProductsByCategoryWithConditions(Category category, Boolean activities, Boolean deleted) {
		return productDAO.countProductsByCategoryWithConditions(category, activities, deleted);
	}

	@Override
	public List<Product> findByCategory(Category category) {
		// Triển khai logic để tìm kiếm sản phẩm theo danh mục tại đây
		// Sử dụng productDAO hoặc các phương thức khác để thực hiện truy vấn
		return productDAO.findByCategory(category);
	}

	@Override
	public Page<Product> findByCategoryIDPaged(Integer cid, Pageable pageable) {
		return productDAO.findByCategoryIDPaged(cid, pageable);
	}

	@Override
	public Page<Product> findByBrandIDPaged(Integer bid, Pageable pageable) {
		return productDAO.findByBrandID(bid, pageable);
	}

	@Override
	public Page<Product> searchByNamePaged(String keyword, Pageable pageable) {
		return productDAO.findByProductNameContaining(keyword, pageable);
	}

	@Override
	public List<Product> findFeaturedProducts() {
		List<Product> allProducts = loadAllNoDeletedAndActivitiesTrue();
		List<Product> featuredProducts = new ArrayList<>();
		for (Product product : allProducts) {
			if (Boolean.TRUE.equals(product.getFeatured())) {
				featuredProducts.add(product);
			}
		}
		return featuredProducts;
	}
	
	@Override
	public List<Product> findSimilarProductsByCategory(Integer categoryID) {
	    // Triển khai logic để tìm sản phẩm tương tự dựa trên categoryID ở đây
	    return productDAO.findSimilarProductsByCategory(categoryID);
	}
	
	@Override
	public Page<Product> findByProductNameContaining(String keyword, Pageable pageable) {
	    return productDAO.findByProductNameContaining(keyword, pageable);
	}

}
