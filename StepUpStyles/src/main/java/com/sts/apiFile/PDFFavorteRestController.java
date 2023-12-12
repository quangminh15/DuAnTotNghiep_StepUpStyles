package com.sts.apiFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

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
import com.sts.model.Favorite;
import com.sts.model.Review;

@Controller
public class PDFFavorteRestController {
    @PostMapping("/favorite-pdf")
    @ResponseBody
    public void exportPdf(HttpServletResponse response, @RequestBody List<Favorite> fvs)
            throws IOException, DocumentException {
        // Thiết lập response để trình duyệt hiểu rằng sẽ nhận tệp PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Favorite.pdf");

        // Tạo một đối tượng Document của iText
        Document document = new Document();
        String relativePath = "/font-times-new-roman/font-times-new-roman.ttf";
        BaseFont baseFont = BaseFont.createFont(relativePath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        // String relativePath = "/font-times-new-roman/font-times-new-roman.ttf";
        // InputStream inputStream = getClass().getResourceAsStream(relativePath);
        // BaseFont baseFont = BaseFont.createFont(relativePath, BaseFont.IDENTITY_H,
        // BaseFont.EMBEDDED);

        Font font = new Font(baseFont);
        // Tạo đối tượng PdfWriter để ghi dữ liệu vào response OutputStream
        PdfWriter.getInstance(document, response.getOutputStream());
        PdfPTable table = new PdfPTable(4);

        // Đặt tiêu đề cho từng cột
        table.addCell(new PdfPCell(new Paragraph("Mã yêu thích", font)));
        table.addCell(new PdfPCell(new Paragraph("Tên sản phẩm", font)));
        table.addCell(new PdfPCell(new Paragraph("Tên khách hàng", font)));
        table.addCell(new PdfPCell(new Paragraph("Ngày thích sản phẩm", font)));

        document.open();

        float rowHeight = 30f;
        // Thêm nội dung vào tài liệu PDF từ danh sách chi tiết phiếu nhập
        for (Favorite item : fvs) {
            font = new Font(baseFont);

            float[] columnWidths = { 90f, 150f, 150f, 150f}; // Thiết lập chiều rộng cho từng cột
            table.setWidths(columnWidths);

            PdfPCell cell1 = new PdfPCell(new Paragraph(String.valueOf(item.getFavoriteId()), font));
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell1.setFixedHeight(rowHeight);
            table.addCell(cell1);

            PdfPCell cell2 = new PdfPCell(new Paragraph(item.getProduct().getProductName(), font));
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell2.setFixedHeight(rowHeight);
            table.addCell(cell2);

            PdfPCell cell3 = new PdfPCell(new Paragraph(item.getUser().getFullName(), font));
            cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell3.setFixedHeight(rowHeight);
            table.addCell(cell3);

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            PdfPCell cell4 = new PdfPCell(new Paragraph(dateFormat.format(item.getDateLike()), font));
            cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell4.setFixedHeight(rowHeight);
            table.addCell(cell4);

        }

        Font nghiengFont = new Font(baseFont, 10, Font.ITALIC);
        // tên cửa hàng
        Paragraph titleImport = new Paragraph();
        // Font vietnameseFont = new Font(baseFont, 22, Font.BOLD);
        Chunk titChunk = new Chunk("STEP UP STYLE");
        titleImport.setAlignment(Element.ALIGN_LEFT);
        titleImport.add(titChunk);

        // tên phiếu nhập
        Paragraph nameImport = new Paragraph();
        Font vietnameseFont = new Font(baseFont, 22, Font.BOLD);
        Chunk idChunk = new Chunk("Danh sách yêu thích sản phẩm", vietnameseFont);
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
}
