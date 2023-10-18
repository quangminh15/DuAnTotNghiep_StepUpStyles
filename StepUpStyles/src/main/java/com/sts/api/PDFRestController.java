package com.sts.api;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.sts.model.ImportReceiptDetail;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

@Controller
public class PDFRestController {
    @PostMapping("/export-pdf")
    @ResponseBody
    public void exportPdf(HttpServletResponse response, @RequestBody List<ImportReceiptDetail> importDetail)
            throws IOException, DocumentException {
        // Thiết lập response để trình duyệt hiểu rằng sẽ nhận tệp PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=import_receipt.pdf");

        // Tạo một đối tượng Document của iText
        Document document = new Document();

        String relativePath = "StepUpStyles\\src\\main\\resources\\font-times-new-roman\\font-times-new-roman.ttf";
        BaseFont baseFont = BaseFont.createFont(relativePath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font font = new Font(baseFont);
        // Tạo đối tượng PdfWriter để ghi dữ liệu vào response OutputStream
        PdfWriter.getInstance(document, response.getOutputStream());
        PdfPTable table = new PdfPTable(5);

        // Đặt tiêu đề cho từng cột
        table.addCell(new PdfPCell(new Paragraph("Tên sản phẩm", font)));
        table.addCell(new PdfPCell(new Paragraph("Số lượng", font)));
        table.addCell(new PdfPCell(new Paragraph("Size", font)));
        table.addCell(new PdfPCell(new Paragraph("Màu sắc", font)));
        table.addCell(new PdfPCell(new Paragraph("Đơn giá", font)));

        document.open();

        String FullName = null;
        Double totalAmount = 0.0;
        Long idImport = null;
        String supplier = null;
        String dateImport = null;

        // Thêm nội dung vào tài liệu PDF từ danh sách chi tiết phiếu nhập
        for (ImportReceiptDetail item : importDetail) {
            font = new Font(baseFont);
            idImport = item.getImportReceipt().getImportReceiptId();

            FullName = item.getImportReceipt().getUser().getFullName();

            supplier = item.getImportReceipt().getSupplier().getSupplierName();

            dateImport = item.getImportReceipt().getImportDate();

            float[] columnWidths = { 50f, 40f, 40f, 40f, 80f }; // Thiết lập chiều rộng cho từng cột
            table.setWidths(columnWidths);

            table.addCell(new PdfPCell(new Paragraph(item.getProductDetail().getProduct().getProductName(), font)));
            table.addCell(new PdfPCell(new Paragraph(String.valueOf(item.getQuantity()))));
            table.addCell(new PdfPCell(new Paragraph(String.valueOf(item.getProductDetail().getSize().getSizeNumber()))));
            table.addCell(new PdfPCell(new Paragraph(item.getProductDetail().getColor().getColorName(), font)));

            // Tạo một ô cho cột "price" và thiết lập chiều cao tối thiểu cho nó
            PdfPCell priceCell = new PdfPCell(new Paragraph(formatToVND(item.getPrice())));
            table.addCell(priceCell);   

            // Tính tổng thành tiền
            totalAmount = item.getImportReceipt().getTotalAmount();
        }

        Font nghiengFont = new Font(baseFont, 10 ,Font.ITALIC);
        // tên cửa hàng
        Paragraph titleImport = new Paragraph();
        // Font vietnameseFont = new Font(baseFont, 22, Font.BOLD);
        Chunk titChunk = new Chunk("STEP UP STYLE");
        titleImport.setAlignment(Element.ALIGN_LEFT);
        titleImport.add(titChunk);

        Paragraph nguoiNhap = new Paragraph();
        Chunk nguoiNhapChunk = new Chunk("Người lập phiếu        Người giao hàng", font);
        nguoiNhap.setAlignment(Element.ALIGN_RIGHT);
        nguoiNhap.add(nguoiNhapChunk);

        // Tạo đối tượng Paragraph cho dòng chữ kí và đặt căn chỉnh bên phải và khoảng
        // cách xa bên phải
        Paragraph kiTen = new Paragraph();
        Chunk kiTenChunk = new Chunk("(Kí, họ tên)                         (Kí, họ tên)", nghiengFont);
        kiTen.setAlignment(Element.ALIGN_RIGHT);
        kiTen.setIndentationRight(20); // Điều chỉnh khoảng cách từ bên phải của trang
        kiTen.add(kiTenChunk);

        // tên phiếu nhập
        Paragraph nameImport = new Paragraph();
        Font vietnameseFont = new Font(baseFont, 22, Font.BOLD);
        Chunk idChunk = new Chunk("Phiếu nhập: " + idImport, vietnameseFont);
        nameImport.setAlignment(Element.ALIGN_CENTER);
        nameImport.add(idChunk);

        // tên người nhập
        Paragraph nameUser = new Paragraph();
        Chunk nameChunk = new Chunk("Họ tên người nhập: " + FullName, font);
        nameUser.add(nameChunk);

        // tên nhà cung cấp
        Paragraph suppName = new Paragraph();
        Chunk suppChunk = new Chunk("Nhà cung cấp: " + supplier, font);
        suppName.add(suppChunk);

        // ngày nhập
        Paragraph date = new Paragraph();
        Chunk dateChunk = new Chunk("Ngày nhập " + dateImport, font);
        date.setAlignment(Element.ALIGN_CENTER);
        date.add(dateChunk);

        // thành tiền
        String formattedAmount = formatToVND(totalAmount);
        Paragraph totalImport = new Paragraph();
        font = new Font(baseFont);
        Chunk totalChunk = new Chunk("Tổng thành tiền: " + formattedAmount, font);
        totalImport.add(totalChunk);
        // file
        document.add(titleImport);
        document.add(nameImport);
        document.add(date);
        document.add(suppName);

        document.add(nameUser);
        document.add(new Paragraph("\n"));
        document.add(table);
        document.add(new Paragraph("\n"));
        document.add(totalImport);
        document.add(nguoiNhap);
        document.add(kiTen);

        // Đóng tài liệu và hoàn thành xuất PDF
        document.close();
    }

    // Định nghĩa hàm formatToVND() ở đây để định dạng giá thành tiền theo định dạng VND
    public static String formatToVND(double amount) {
        DecimalFormat decimalFormat = new DecimalFormat("###,###,###,###");
        return decimalFormat.format(amount) + " VND";
    }
}