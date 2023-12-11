package com.sts.serviceImpl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.sts.dao.UserDAO;
import com.sts.dao.VoucherDAO;
import com.sts.dao.VoucherUseDAO;
import com.sts.model.DirectDiscount;
import com.sts.model.User;
import com.sts.model.Voucher;
import com.sts.model.VoucherUse;
import com.sts.service.VoucherUseService;

@Service
public class VoucherUseServiceImpl implements VoucherUseService {
    @Autowired
    VoucherUseDAO voucherUseDao;

    @Autowired
    UserDAO userDao;

    @Autowired
    VoucherDAO voucherDao;

    @Override
    public List<VoucherUse> findAll() {
        return voucherUseDao.findAll();
    }

    @Override
    public void saveVoucherForUser(Long voucherId, Integer userId) {
        // Giả sử bạn có một thực thể VoucherUse và một repository
        VoucherUse voucherUse = new VoucherUse();

        // Lấy thực thể người dùng và voucher từ cơ sở dữ liệu
        User user = userDao.findById(userId).orElseThrow(() -> new RuntimeException("Người dùng không được tìm thấy"));
        Voucher voucher = voucherDao.findById(voucherId)
                .orElseThrow(() -> new RuntimeException("Mã giảm giá không được tìm thấy"));

        // Định dạng ngày giờ hiện tại thành chuỗi
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDateAsString = sdf.format(new Date());

        // Lưu giá trị useDate, có thể là null
        voucherUse.setUseDate(currentDateAsString); // hoặc có thể là null tùy thuộng

        voucherUse.setSaved(true);
        voucherUse.setUser(user);
        voucherUse.setVoucher(voucher);

        voucherUseDao.save(voucherUse);
    }

    @Override
    public List<VoucherUse> getSavedVoucherUsesByUserId(Integer userId) {
        return voucherUseDao.findByUser_UsersIdAndSaved(userId, true);
    }

    @Override
    public Boolean isVoucherSaved(Integer userId, Long voucherId) {
        // Tìm User và Voucher dựa trên userId và voucherId
        User user = new User();
        user.setUsersId(userId); // Điều này giả sử bạn có một phương thức để tìm User theo userId

        Voucher voucher = new Voucher();
        voucher.setVoucherId(voucherId);
        ; // Điều này giả sử bạn có một phương thức để tìm Voucher theo voucherId

        // Tìm VoucherUse dựa trên User và Voucher
        VoucherUse voucherUse = voucherUseDao.findByUserAndVoucher(user, voucher);

        // Nếu VoucherUse tồn tại và saved là true, trả về true, ngược lại trả về false
        return voucherUse != null && voucherUse.getSaved();
    }

    @Scheduled(cron = "* * * * * *")
    @Override
    public void updateVoucherSave() {
        List<VoucherUse> voucheruse = voucherUseDao.findAll();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
        // Calendar currentDate = Calendar.getInstance();

        for (VoucherUse voucherus : voucheruse) {
            try {
                Date enDate = dateFormat.parse(voucherus.getVoucher().getDateEnd());

                // Tạo một đối tượng Calendar mới cho mỗi lượt lặp
                Calendar currentDate = Calendar.getInstance();

                // Trừ đi 7 ngày
                currentDate.add(Calendar.DAY_OF_MONTH, -7);

                // Lấy ngày sau khi trừ 7 ngày
                Date sevenDaysAgo = currentDate.getTime();

                if (enDate.before(sevenDaysAgo)) {
                    voucherus.setSaved(false);
                }

                // Cập nhật trạng thái vào cơ sở dữ liệu
                voucherUseDao.save(voucherus);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
    }
}
