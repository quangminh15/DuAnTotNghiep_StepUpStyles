package com.sts.apiFile;

import java.io.IOException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.springframework.security.config.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

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
import com.sts.model.Product;
import com.sts.model.ProductImage;
import com.sts.model.Size;
import com.sts.model.Supplier;

@Controller
public class PDFProductImageRestController {

    @PostMapping("/productimage-pdf")
    @ResponseBody
    public void exportPdf(HttpServletResponse response, @RequestBody List<ProductImage> productImages)
            throws IOException, DocumentException {
        // Thiết lập response để trình duyệt hiểu rằng sẽ nhận tệp PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=DSProductImage.pdf");

        // Tạo một đối tượng Document của iText
        Document document = new Document();
        document.setMargins(30, 30, 30, 30);
        String relativePath = "/font-times-new-roman/font-times-new-roman.ttf"; // Đường dẫn tới font chữ, bạn cần sửa
        // lại đúng đường dẫn của font chữ trên
        // máy bạn
        BaseFont baseFont = BaseFont.createFont(relativePath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        Font font = new Font(baseFont);
        // Tạo đối tượng PdfWriter để ghi dữ liệu vào response OutputStream
        PdfWriter.getInstance(document, response.getOutputStream());

        PdfPTable table = new PdfPTable(4); // Số cột tùy thuộc vào số trường thông tin bạn muốn xuất
        table.setWidthPercentage(100); // Đảm bảo bảng chiếm toàn bộ chiều rộng của trang
        table.setHorizontalAlignment(Element.ALIGN_CENTER);

        // Đặt tiêu đề cho từng cột và canh giữa
        PdfPCell idTitleCell = new PdfPCell(new Paragraph("ID", font));
        idTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(idTitleCell);

        PdfPCell imagePathTitleCell = new PdfPCell(new Paragraph("Đường dẫn ảnh", font));
        imagePathTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(imagePathTitleCell);

        PdfPCell productNameTitleCell = new PdfPCell(new Paragraph("Tên sản phẩm", font));
        productNameTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(productNameTitleCell);

        PdfPCell modifyDateTitleCell = new PdfPCell(new Paragraph("Ngày điều chỉnh", font));
        modifyDateTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(modifyDateTitleCell);

        document.open();

        float rowHeight = 100f;
        // Thêm nội dung vào tài liệu PDF từ danh sách hình ảnh sản phẩm
        for (ProductImage item : productImages) {
            font = new Font(baseFont);

            float[] columnWidths = { 50f, 140f, 140f, 140f };
            table.setWidths(columnWidths);

            PdfPCell cell1 = new PdfPCell(new Paragraph(String.valueOf(item.getProductImageID()), font));
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell1.setFixedHeight(rowHeight);
            table.addCell(cell1);

            PdfPCell cell2 = new PdfPCell(new Paragraph(item.getImagePath(), font));
            cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell2.setFixedHeight(rowHeight);
            table.addCell(cell2);

            PdfPCell cell3 = new PdfPCell(new Paragraph(item.getProduct().getProductName(), font));
            cell3.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell3.setFixedHeight(rowHeight);
            table.addCell(cell3);

            PdfPCell cell4 = new PdfPCell(new Paragraph(formatDate(item.getModifyDate()), font));
            cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell4.setFixedHeight(rowHeight);
            table.addCell(cell4);
        }

        Font nghiengFont = new Font(baseFont, 10, Font.ITALIC);
        // tên cửa hàng
        Paragraph titleImport = new Paragraph();
        Chunk titChunk = new Chunk("STEP UP STYLE");
        titleImport.setAlignment(Element.ALIGN_LEFT);
        titleImport.add(titChunk);

        // tên phiếu nhập
        Paragraph nameImport = new Paragraph();
        Font vietnameseFont = new Font(baseFont, 22, Font.BOLD);
        Chunk idChunk = new Chunk("Danh sách hình ảnh", vietnameseFont);
        nameImport.setAlignment(Element.ALIGN_CENTER);
        nameImport.add(idChunk);

        // Tạo một đối tượng Date để lấy ngày hiện tại
        Date currentDate = new Date();

        // Định dạng ngày hiện tại thành chuỗi
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy"); // Định dạng ngày theo ý muốn
        String formattedDate = dateFormat.format(currentDate);

        // ngày nhập
        Paragraph date = new Paragraph();
        Chunk dateChunk = new Chunk("Ngày xuất file: " + formattedDate, font);
        date.setAlignment(Element.ALIGN_CENTER);
        date.add(dateChunk);

        // file
        document.add(titleImport);
        document.add(nameImport);
        document.add(date);

        document.add(new Paragraph("\n"));
        document.add(table);
        document.add(new Paragraph("\n"));

        // Đóng tài liệu và hoàn thành xuất PDF
        document.close();
    }

    // Hàm chuyển đổi ngày thành chuỗi theo định dạng
    private String formatDate(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        return (date != null) ? dateFormat.format(date) : "";
    }
}
