package com.sts.serviceImpl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.sts.dao.DirectDiscountDAO;
import com.sts.model.DirectDiscount;
import com.sts.service.DiscountService;

@Service
public class DiscountServiceImpl implements DiscountService {
	@Autowired
	DirectDiscountDAO discountDAO;

	@Override
	public List<DirectDiscount> findAll() {
		return discountDAO.findAll();
	}

	@Override
	public List<DirectDiscount> getNodeletedDiscount() {
		return discountDAO.findByDeletedFalse();
	}

	@Override
	public List<DirectDiscount> getDeletedDiscount() {
		return discountDAO.findByDeletedTrue();
	}

	@Override
	public DirectDiscount create(DirectDiscount directDis) {
		return discountDAO.save(directDis);
	}

	@Override
	public DirectDiscount update(DirectDiscount directDis) {
		return discountDAO.save(directDis);
	}

	@Override
	public void delete(Long ddid) {
		discountDAO.deleteById(ddid);
	}

	@Override
	public void saveStatus(DirectDiscount directDis) {
		Date currentDate = new Date();

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		try {
			Date startDate = dateFormat.parse(directDis.getStartDate());
			Date endDate = dateFormat.parse(directDis.getEndDate());

			if (startDate.after(currentDate)) {
				directDis.setStatus("Chưa diễn ra");
			} else if (endDate.before(currentDate)) {
				directDis.setStatus("Đã kết thúc");
			} else {
				directDis.setStatus("Đang diễn ra");
			}
		} catch (ParseException e) {
			// Xử lý ngoại lệ nếu không thể chuyển đổi startDate thành Date
			e.printStackTrace();
		}
	}

	@Scheduled(cron = "* * * * * *")
	public void updateDiscountStatus() {
		List<DirectDiscount> discounts = discountDAO.findAll();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		Date currentDate = new Date();

		for (DirectDiscount discount : discounts) {
			try {
				Date startDate = dateFormat.parse(discount.getStartDate());
				Date endDate = dateFormat.parse(discount.getEndDate());

				if (startDate.after(currentDate)) {
					discount.setStatus("Chưa diễn ra");
				} else if (endDate.before(currentDate)) {
					discount.setStatus("Đã kết thúc");
				} else {
					discount.setStatus("Đang diễn ra");
				}

				// Cập nhật trạng thái vào cơ sở dữ liệu
				discountDAO.save(discount);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public List<DirectDiscount> findByDiscountProduct(String keyword) {
		return discountDAO.findByDiscountProduct(keyword);
	}

	// Lọc danh sách giảm giá theo sản phẩm
	@Override
	public List<DirectDiscount> getdiscountsByProduct(Integer productId) {
		return discountDAO.findByProduct_ProductID(productId);
	}

	@Override
	public List<DirectDiscount> getDiscountsByStatusAndDeleted(String status, boolean deleted) {
		return discountDAO.findByStatusAndDeleted(status, deleted);
	}

}
