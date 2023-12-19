package com.sts.apiFile;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.sts.model.Brand;
import com.sts.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class PDFUserRestController {

    @PostMapping("/customer-pdf")
    @ResponseBody
    public void exportPdf(HttpServletResponse response, @RequestBody List<User> brands)
            throws IOException, DocumentException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=DSCustomer.pdf");

        Document document = new Document(PageSize.A4.rotate());
        document.setMargins(30, 30, 30, 30);
        String relativePath = "/font-times-new-roman/font-times-new-roman.ttf";
        BaseFont baseFont = BaseFont.createFont(relativePath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        Font font = new Font(baseFont);
        PdfWriter.getInstance(document, response.getOutputStream());

        PdfPTable table = new PdfPTable(6);
        table.setWidthPercentage(100);
        table.setHorizontalAlignment(Element.ALIGN_CENTER);

        PdfPCell idTitleCell = new PdfPCell(new Phrase("ID", font));
        idTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(idTitleCell);

        PdfPCell nameTitleCell = new PdfPCell(new Phrase("Họ và tên", font));
        nameTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(nameTitleCell);

        PdfPCell imageTitleCell = new PdfPCell(new Phrase("Email", font));
        imageTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(imageTitleCell);

        PdfPCell modifyDateTitleCell = new PdfPCell(new Phrase("Hình ảnh", font));
        modifyDateTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(modifyDateTitleCell);

        PdfPCell activitiesTitleCell = new PdfPCell(new Phrase("Số điện thoại", font));
        activitiesTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(activitiesTitleCell);

        PdfPCell activitiesTitleCell2 = new PdfPCell(new Phrase("Địa chỉ", font));
        activitiesTitleCell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(activitiesTitleCell2);

        document.open();

        float rowHeight = 100f;
        for (User item : brands) {
            font = new Font(baseFont);

            float[] columnWidths = {50f, 140f, 140f, 300f, 140f, 100f};
            table.setWidths(columnWidths);

            PdfPCell cell1 = new PdfPCell(new Phrase(String.valueOf(item.getUsersId()), font));
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell1.setFixedHeight(rowHeight);
            table.addCell(cell1);

            PdfPCell cell2 = new PdfPCell(new Phrase(item.getFullName(), font));
            cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell2.setFixedHeight(rowHeight);
            table.addCell(cell2);

            PdfPCell cell3 = new PdfPCell(new Phrase(item.getEmail(), font));
            cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell3.setFixedHeight(rowHeight);
            table.addCell(cell3);

            PdfPCell cell4 = new PdfPCell(new Phrase(item.getImage(), font));
            cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell4.setFixedHeight(rowHeight);
            table.addCell(cell4);

            PdfPCell cell5 = new PdfPCell(new Phrase(item.getPhone()));
            cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell5.setFixedHeight(rowHeight);
            table.addCell(cell5);

            PdfPCell cell6 = new PdfPCell(new Phrase(item.getAddress()));
            cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell6.setFixedHeight(rowHeight);
            table.addCell(cell6);
        }

        Font italicFont = new Font(baseFont, 10, Font.ITALIC);
        Paragraph titleParagraph = new Paragraph();
        titleParagraph.add(new Phrase("DANH SÁCH KHÁCH HÀNG", font));

        Paragraph dateParagraph = new Paragraph();
        dateParagraph.add(new Phrase("Ngày xuất file: " + formatDate(new Date()), font));

        document.add(titleParagraph);
        document.add(dateParagraph);
        document.add(new Paragraph("\n"));
        document.add(table);
        document.add(new Paragraph("\n"));
        document.close();
    }

    private String formatDate(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        return (date != null) ? dateFormat.format(date) : "";
    }
}
