package com.sts.apiFile;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
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

import com.sts.model.Product;
import com.sts.model.ProductDetail;

@Controller
public class ExcelProductRestController {

    @PostMapping("/export-excelProduct")
    @ResponseBody
    public void exportExcel(HttpServletResponse response, @RequestBody List<Product> products)
            throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=ProductStepUpStyle.xlsx");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Danh sách sản phẩm");

        // Tạo một dòng mới ở đầu bảng
        Row titleRow = sheet.createRow(0);

        // Tạo một ô trong dòng mới và đặt giá trị là "STEP UP STYLE"
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("STEP UP STYLE");

        sheet.setColumnWidth(0, 15 * 400);

        // Tạo CellStyle cho ô tiêu đề
        CellStyle titleCellStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();

        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 18); // Đặt kích thước font
        titleCellStyle.setFont(titleFont);
        titleCellStyle.setAlignment(HorizontalAlignment.CENTER); // Căn giữa theo chiều ngang
        titleCellStyle.setVerticalAlignment(VerticalAlignment.CENTER); // Căn giữa theo chiều dọc
        titleCell.setCellStyle(titleCellStyle);

        // Tạo hàng trống sau hàng
        Row suppRow = sheet.createRow(1);

        // Tạo một ô để đặt giá trị "Danh sách sản phẩm chi tiết"
        Cell detailCell = suppRow.createCell(1);
        detailCell.setCellValue("Danh sách sản phẩm");

        CellStyle detailStyle = workbook.createCellStyle();
        Font detailFont = workbook.createFont();
        detailFont.setFontHeightInPoints((short) 16);
        detailFont.setBold(true);
        detailStyle.setFont(detailFont);
        detailStyle.setAlignment(HorizontalAlignment.CENTER); // Căn giữa theo chiều ngang
        detailStyle.setVerticalAlignment(VerticalAlignment.CENTER); // Căn giữa theo chiều dọc
        detailCell.setCellStyle(detailStyle);

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
        String[] headers = {"ID", "Tên sản phẩm", "Ngày điều chỉnh", "Nổi bật", "Giá", "Mô tả", "Hoạt động", "Thương hiệu", "Danh mục", "Tên người điều chỉnh"};

        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(dataCellStyle);
        }

        int rowNum = 6; // Bắt đầu từ hàng số 2 sau dòng tiêu đề
        for (Product item : products) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(item.getProductID());
            row.createCell(1).setCellValue(item.getProductName());
            Cell dateCell = row.createCell(2);
            if (item.getModifyDate() != null) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                dateCell.setCellValue(dateFormat.format(item.getModifyDate()));
            }
            String featuredStatus = item.getFeatured() ? "Bật" : "Tắt";
            row.createCell(3).setCellValue(featuredStatus);
            row.createCell(4).setCellValue(item.getPrice());
            row.createCell(5).setCellValue(item.getDescription());
            String activityStatus = item.getActivities() ? "Đang hoạt động" : "Không hoạt động";
            row.createCell(6).setCellValue(activityStatus);
            row.createCell(7).setCellValue(item.getBrand().getBrandName());
            row.createCell(8).setCellValue(item.getCategory().getCategoryName());
            row.createCell(9).setCellValue(item.getUser().getFullName());

            // Đặt CellStyle cho từng ô dữ liệu
            for (int i = 0; i < headers.length; i++) {
                row.getCell(i).setCellStyle(dataCellStyle);
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
