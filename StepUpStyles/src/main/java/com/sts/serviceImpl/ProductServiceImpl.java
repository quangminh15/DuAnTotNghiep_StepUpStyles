package com.sts.serviceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.sts.dao.BrandDAO;
import com.sts.dao.CategoryDAO;
import com.sts.dao.DirectDiscountDAO;
import com.sts.dao.ProductDAO;
import com.sts.model.Brand;
import com.sts.model.Category;
import com.sts.model.DirectDiscount;
import com.sts.model.Product;
import com.sts.model.DTO.BrandProductCountDTO;
import com.sts.model.DTO.CategoryProductCountDTO;
import com.sts.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	ProductDAO productDAO;

	@Autowired
	CategoryDAO categoryDAO;

	@Autowired
	BrandDAO brandDAO;

	@Autowired
	DirectDiscountDAO discountDAO;

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

	@Override
	public List<BrandProductCountDTO> getBrandProductCount() {
		List<BrandProductCountDTO> brandProductCounts = new ArrayList<>();

		// Lấy danh sách danh mục
		List<Brand> brands = brandDAO.findAll();

		for (Brand brand : brands) {
			// Sử dụng JPQL để lấy tổng số lượng sản phẩm theo danh mục
			TypedQuery<Long> query = entityManager.createQuery(
					"SELECT SUM(pd.quantity) FROM ProductDetail pd WHERE pd.product.brand = :brand", Long.class);
			query.setParameter("brand", brand);

			// Thực hiện truy vấn và lấy kết quả
			Long productCount = query.getSingleResult();

			if (productCount == null) {
				productCount = 0L;
			}

			// Tạo một đối tượng CategoryProductCountDTO và thêm vào danh sách
			BrandProductCountDTO countDTO = new BrandProductCountDTO(brand.getBrandName(), productCount);
			brandProductCounts.add(countDTO);
		}
		return brandProductCounts;
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
	public List<Product> getProductsByBrandID(Integer brandID) {
		return productDAO.getProductsByBrandID(brandID);
	}

	@Override
	public Product getProductById(Integer productId) {
		// Sử dụng ProductDao để truy vấn sản phẩm từ cơ sở dữ liệu
		Optional<Product> product = productDAO.findById(productId);
		return product.orElse(null); // Hoặc xử lý trường hợp sản phẩm không tồn tại
	}

	public List<Product> getProductsByCategoryID(Integer categoryID) {
		return productDAO.getProductsByCategoryID(categoryID);
	}

	@Override
	public List<Product> loadDiscountedProducts() {
		List<Product> discountedProducts = new ArrayList<>();
		List<DirectDiscount> directDiscounts = discountDAO.findByStatus("Chưa diễn ra");

		for (DirectDiscount discount : directDiscounts) {
			if (discount.getProduct() != null) {
				discountedProducts.add(discount.getProduct());
			}
		}

		return discountedProducts;
	}

}
