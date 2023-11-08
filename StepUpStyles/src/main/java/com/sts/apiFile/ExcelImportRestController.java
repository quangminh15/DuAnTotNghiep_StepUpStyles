package com.sts.apiFile;

import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
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
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sts.model.ImportReceiptDetail;

@Controller
public class ExcelImportRestController {
    @PostMapping("/export-excel")
    @ResponseBody
    public void exportExcel(HttpServletResponse response, @RequestBody List<ImportReceiptDetail> importDetail)
            throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=PhieuNhapStepUpStyle.xlsx");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Phiếu nhập");

        // Tạo một dòng mới ở đầu bảng
        Row titleRow = sheet.createRow(0);

        // Tạo một ô trong dòng mới và đặt giá trị là "STEP UP STYLE"
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("STEP UP STYLE");

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

        // Lặp qua danh sách importDetail để lấy ID phiếu nhập
        Long idImport = null;
        String supp = "";
        String fullname = "";
        Double totalAmount = null;
        for (ImportReceiptDetail item : importDetail) {
            idImport = item.getImportReceipt().getImportReceiptId();
            fullname = item.getImportReceipt().getUser().getFullName();
            supp = item.getImportReceipt().getSupplier().getSupplierName();
            totalAmount = item.getImportReceipt().getTotalAmount();
            break; // Chỉ cần lấy ID phiếu nhập của một bản ghi đầu tiên
        }

        // Tạo hàng trống sau hàng id phieu nhap
        Row IdPhieuNhapRow = sheet.createRow(1);

        // Merge cột B, C, D, E
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 3));

        // Tạo một ô để đặt giá trị ID phiếu nhập
        Cell idImportCell = IdPhieuNhapRow.createCell(1);
        idImportCell.setCellValue("Phiếu Nhập: " + idImport);

        // Đặt CellStyle cho ô ID
        CellStyle idCellStyle = workbook.createCellStyle();
        Font idFont = workbook.createFont();
        idFont.setFontHeightInPoints((short) 18);
        idFont.setBold(true);
        idCellStyle.setFont(idFont);
        idCellStyle.setAlignment(HorizontalAlignment.CENTER); // Căn giữa theo chiều ngang
        idCellStyle.setVerticalAlignment(VerticalAlignment.CENTER); // Căn giữa theo chiều dọc
        idImportCell.setCellStyle(idCellStyle);

        // Đặt lại kích thước của ô ID (đã được ghép)
        sheet.setColumnWidth(1, 4 * 256); // Đặt kích thước của cột 1 (B) để hiển thị đúng với nội dung đã ghép

        // Tạo hàng trống sau hàng fullname
        Row fullnameRow = sheet.createRow(2);

        // Merge cột a, b, c, d
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 3));

        // Tạo một ô để đặt giá trị fullname
        Cell fullnameCell = fullnameRow.createCell(0);
        fullnameCell.setCellValue("Họ tên người nhập: " + fullname);

        // Đặt CellStyle cho ô fullname
        CellStyle fullnameStyle = workbook.createCellStyle();
        Font fullnameFont = workbook.createFont();
        fullnameFont.setFontHeightInPoints((short) 12);
        fullnameFont.setBold(true);
        fullnameStyle.setFont(fullnameFont);
        // fullnameStyle.setAlignment(HorizontalAlignment.CENTER); // Căn giữa theo
        // chiều ngang
        // fullnameStyle.setVerticalAlignment(VerticalAlignment.CENTER); // Căn giữa
        // theo chiều dọc
        fullnameCell.setCellStyle(fullnameStyle);

        // Đặt lại kích thước của ô fullname (đã được ghép)
        for (int i = 0; i <= 3; i++) {
            sheet.setColumnWidth(i, 4 * 256); // Đặt kích thước của các cột A, B, C, D để hiển thị đúng với nội dung đã
                                              // ghép
        }

        // tạo 1 hàng trống nhà cung cấp
        Row suppRow = sheet.createRow(3);

        // Merge cột a, b, c, d
        sheet.addMergedRegion(new CellRangeAddress(3, 3, 0, 3));

        // Tạo một ô để đặt giá trị nhà cung cấp
        Cell suppCell = suppRow.createCell(0);
        suppCell.setCellValue("Nhà cung cấp: " + supp);

        // Đặt CellStyle cho ô nhà cung cấp
        CellStyle suppStyle = workbook.createCellStyle();
        Font suppFont = workbook.createFont();
        suppFont.setFontHeightInPoints((short) 12);
        suppFont.setBold(true);
        suppStyle.setFont(suppFont);
        suppCell.setCellStyle(suppStyle);

        // Thiết lập viền cho ô tiêu đề
        headerCellStyle.setBorderTop(BorderStyle.THIN);
        headerCellStyle.setBorderBottom(BorderStyle.THIN);
        headerCellStyle.setBorderLeft(BorderStyle.THIN);
        headerCellStyle.setBorderRight(BorderStyle.THIN);

        // Căn giữa theo chiều ngang và chiều dọc cho ô dữ liệu
        headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
        headerCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

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
        String[] headers = { "Tên sản phẩm", "Số lượng", "Size", "Màu sắc", "Đơn giá" };

        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerCellStyle);
        }

        // Thêm dữ liệu và đặt CellStyle cho từng ô trong hàng dữ liệu
        int rowNum = 6; // Bắt đầu từ hàng số 2 sau dòng tiêu đề
        for (ImportReceiptDetail item : importDetail) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(item.getProductDetail().getProduct().getProductName());
            row.createCell(1).setCellValue(item.getQuantity());
            row.createCell(2).setCellValue(item.getProductDetail().getSize().getSizeNumber());
            row.createCell(3).setCellValue(item.getProductDetail().getColor().getColorName());
            row.createCell(4).setCellValue(formatToVND(item.getPrice()));

            // Đặt CellStyle cho từng ô dữ liệu
            for (int i = 0; i < headers.length; i++) {
                row.getCell(i).setCellStyle(dataCellStyle);
            }
        }

        // Tạo hàng "Tổng thành tiền" dưới table
        int totalRowNum = rowNum + 1;
        Row totalRow = sheet.createRow(totalRowNum); // Sử dụng giá trị rowNum hiện tại
        // Merge cột a, b, c, d
        sheet.addMergedRegion(new CellRangeAddress(totalRowNum, totalRowNum, 0, 3));

        // Tạo một ô để đặt giá trị của total
        Cell totalCell = totalRow.createCell(0);
        totalCell.setCellValue("Tổng thành tiền: " + formatToVND(totalAmount));

        // Đặt CellStyle cho ô tổng thành tiền
        CellStyle totalStyle = workbook.createCellStyle();
        Font totalFont = workbook.createFont();
        totalFont.setFontHeightInPoints((short) 12);
        totalFont.setBold(true);
        totalStyle.setFont(totalFont);
        totalCell.setCellStyle(totalStyle);

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

    public static String formatToVND(double amount) {
        DecimalFormat decimalFormat = new DecimalFormat("###,###,###,###");
        return decimalFormat.format(amount) + " VND";
    }
}