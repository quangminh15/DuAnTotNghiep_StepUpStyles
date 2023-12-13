package com.sts.apiFile;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sts.model.OrderDetail;
import com.sts.model.Product;
import com.sts.model.Review;
import com.sts.model.User;

@Controller
public class ExcelReviewRestController {
    @PostMapping("/export-excelReview")
    @ResponseBody
    public void exportExcel(HttpServletResponse response, @RequestBody List<Review> reviews)
            throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=ReviewStepUpStyle.xlsx");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Danh sách đánh giá");

        /// Tạo một dòng mới ở đầu bảng
        Row titleRow = sheet.createRow(0);

        // Tạo một ô trong dòng mới và đặt giá trị là "STEP UP STYLE"
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("STEP UP STYLE");

        sheet.setColumnWidth(0, 15 * 400);

        // Tạo CellStyle cho ô tiêu đề
        CellStyle headerCellStyle = workbook.createCellStyle();
        Font headerFont = workbook.createFont();

        CellStyle titleCellStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();

        headerFont.setBold(true);
        headerCellStyle.setFont(headerFont);

        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 18); // Đặt kích thước font
        titleCellStyle.setFont(titleFont);
        titleCellStyle.setAlignment(HorizontalAlignment.CENTER); // Căn giữa theo chiều ngang
        titleCellStyle.setVerticalAlignment(VerticalAlignment.CENTER); // Căn giữa theo chiều dọc
        titleCell.setCellStyle(titleCellStyle);

        // Tạo hàng trống sau hàng 
        Row suppRow = sheet.createRow(1);

        // Thiết lập viền cho ô tiêu đề
        headerCellStyle.setBorderTop(BorderStyle.THIN);
        headerCellStyle.setBorderBottom(BorderStyle.THIN);
        headerCellStyle.setBorderLeft(BorderStyle.THIN);
        headerCellStyle.setBorderRight(BorderStyle.THIN);

        // Căn giữa theo chiều ngang và chiều dọc cho ô dữ liệu
        headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
        headerCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        // Tạo một ô để đặt giá trị DSSupplier
        Cell supplierCell = suppRow.createCell(1);
        supplierCell.setCellValue("Danh sách đánh giá ");


        CellStyle supplierStyle = workbook.createCellStyle();
        Font supFont = workbook.createFont();
        supFont.setFontHeightInPoints((short) 16);
        supFont.setBold(true);
        supplierStyle.setFont(supFont);
        supplierStyle.setAlignment(HorizontalAlignment.CENTER); // Căn giữa theo chiều ngang
        supplierStyle.setVerticalAlignment(VerticalAlignment.CENTER); // Căn giữa theo chiều dọc
        supplierCell.setCellStyle(supplierStyle);

        // Tạo CellStyle cho ô dữ liệu
        CellStyle dataCellStyle = workbook.createCellStyle();

        // Thiết lập viền cho ô dữ liệu
        dataCellStyle.setBorderTop(BorderStyle.THIN);
        dataCellStyle.setBorderBottom(BorderStyle.THIN);
        dataCellStyle.setBorderLeft(BorderStyle.THIN);
        dataCellStyle.setBorderRight(BorderStyle.THIN);

        // Căn giữa theo chiều ngang và chiều dọc cho ô dữ liệu
        dataCellStyle.setAlignment(HorizontalAlignment.CENTER);
        dataCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        // Tạo hàng tiêu đề và đặt CellStyle cho từng ô trong hàng
        Row headerRow = sheet.createRow(5);
        String[] headers = { "Mã đơn hàng", "Tên sản phẩm", "Tên người dùng", "Nội dung", "Ngày đánh giá", "Sao đánh giá", "Ảnh 1", "Ảnh 2", "Ảnh 3"};

        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerCellStyle);
        }

        int rowNum = 6; // Bắt đầu từ hàng số 2 sau dòng tiêu đề
        for (Review item : reviews) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(item.getOrderDetail().getOrderDetailId());
            row.createCell(1).setCellValue(item.getProduct().getProductName());
            row.createCell(2).setCellValue(item.getUser().getFullName());
            row.createCell(3).setCellValue(item.getTitle());
            Cell dateCell = row.createCell(4);
            if (item.getReviewDate() != null) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                dateCell.setCellValue(dateFormat.format(item.getReviewDate()));
            }
            row.createCell(5).setCellValue(item.getRating());
            row.createCell(6).setCellValue(item.getImage1());
            row.createCell(7).setCellValue(item.getImage2());
            row.createCell(8).setCellValue(item.getImage3());
            // Đặt CellStyle cho từng ô dữ liệu
            for (int i = 0; i < headers.length; i++) {
    Cell cell = row.getCell(i);
    if (cell != null) {
        cell.setCellStyle(dataCellStyle);
    }
}

        }

        // Auto-size columns
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Write the workbook to the response OutputStream
        try (OutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        }

        workbook.close();
    }
}
