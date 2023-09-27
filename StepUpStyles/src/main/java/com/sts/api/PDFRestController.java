package com.sts.api;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;
import com.sts.model.ImportReceiptDetail;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
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

        // Tạo đối tượng PdfWriter để ghi dữ liệu vào response OutputStream
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();

        String relativePath = "DuAnTotNghiep_StepUpStyles\\StepUpStyles\\src\\main\\resources\\font-times-new-roman\\font-times-new-roman.ttf";
        BaseFont baseFont = BaseFont.createFont(relativePath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        boolean isHeaderDisplayed = false;
        String previousFullName = null;
        Double totalAmount = 0.0;

        // Thêm nội dung vào tài liệu PDF từ danh sách chi tiết phiếu nhập
        for (ImportReceiptDetail item : importDetail) {
            Font font = new Font(baseFont);
            if (!isHeaderDisplayed) {
                Paragraph nameImport = new Paragraph();

                // Tạo một đoạn văn bản với nội dung "Phiếu nhập" bằng phông chữ in đậm và cỡ
                Font vietnameseFont = new Font(baseFont, 22, Font.BOLD);
                Chunk chunk = new Chunk("Phiếu nhập: " + item.getImportReceipt().getImportReceiptId(), vietnameseFont);

                nameImport.add(chunk);
                nameImport.setAlignment(Element.ALIGN_CENTER);
                document.add(nameImport);
                isHeaderDisplayed = true; // Đánh dấu là đã hiển thị thông tin phiếu nhập
            }

            String currentFullName = item.getImportReceipt().getUser().getFullName();
            if (!currentFullName.equals(previousFullName)) {
                Paragraph nameUser = new Paragraph();
                font = new Font(baseFont);
                Chunk chunk = new Chunk("Họ tên người nhập: " + currentFullName, font);

                nameUser.add(chunk);
                document.add(nameUser);
                previousFullName = currentFullName; // Cập nhật tên người nhập trước đó
            }

            Paragraph nameParagraph = new Paragraph();
            font = new Font(baseFont);
            Chunk nameProductChunk = new Chunk("Tên sản phẩm: " + item.getProductDetail().getProduct().getProductName(),
                    font);
            nameParagraph.add(nameProductChunk);
            document.add(nameProductChunk);

            Paragraph quantityParagraph = new Paragraph();
            Chunk quantityChunk = new Chunk("Số lượng: " + item.getQuantity(), font);
            quantityParagraph.add(quantityChunk);
            document.add(quantityParagraph);

            Paragraph sizeParagraph = new Paragraph();
            Chunk sizeChunk = new Chunk("Size: " + item.getProductDetail().getSize().getSizeNumber(), font);
            sizeParagraph.add(sizeChunk);
            document.add(sizeParagraph);

            Paragraph colorParagraph = new Paragraph();
            Chunk colorChunk = new Chunk("Màu sắc: " + item.getProductDetail().getColor().getColorName(), font);
            colorParagraph.add(colorChunk);
            document.add(colorParagraph);

            Paragraph priceParagraph = new Paragraph();
            Chunk priceChunk = new Chunk("Đơn giá: " + item.getPrice(), font);
            priceParagraph.add(priceChunk);
            document.add(priceParagraph);
            document.add(new Paragraph("-----------------------------------------------------------"));

            // Tính tổng thành tiền
            totalAmount = item.getImportReceipt().getTotalAmount();
        }
        Paragraph totalImport = new Paragraph();
        Font font = new Font(baseFont);
        Chunk totalChunk = new Chunk("Tổng thành tiền: " + totalAmount, font);
        totalImport.add(totalChunk);
        document.add(totalImport);

        // Đóng tài liệu và hoàn thành xuất PDF
        document.close();
    }

    // Định nghĩa hàm formatToVND() ở đây để định dạng giá thành tiền theo định dạng
    // VND
    // private String formatToVND(double price) {

    // // Thực hiện định dạng và trả về giá trị định dạng VND
    // // ...
    // }
}
