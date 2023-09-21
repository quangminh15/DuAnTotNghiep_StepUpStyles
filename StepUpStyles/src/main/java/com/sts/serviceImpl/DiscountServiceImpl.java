package com.sts.serviceImpl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.DirectDiscountDAO;
import com.sts.model.DirectDiscount;
import com.sts.service.DiscountService;

@Service
public class DiscountServiceImpl implements DiscountService{
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
    
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Điều chỉnh định dạng ngày tháng tương ứng với định dạng của thuộc tính startDate
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
}
