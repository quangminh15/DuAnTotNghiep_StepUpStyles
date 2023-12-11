package com.sts.apiFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
import com.sts.model.Size;
import com.sts.model.Supplier;

@Controller
public class PDFSizeRestController {

	@PostMapping("/size-pdf")
	@ResponseBody
	public void exportPdf(HttpServletResponse response, @RequestBody List<Size> sizes)
			throws IOException, DocumentException {
		// Thiết lập response để trình duyệt hiểu rằng sẽ nhận tệp PDF
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=DSSize.pdf");

		// Tạo một đối tượng Document của iText
		Document document = new Document();
		String relativePath = "/font-times-new-roman/font-times-new-roman.ttf"; // Đường dẫn tới font chữ, bạn cần sửa
																				// lại đúng đường dẫn của font chữ trên
																				// máy bạn
		BaseFont baseFont = BaseFont.createFont(relativePath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

		Font font = new Font(baseFont);
		// Tạo đối tượng PdfWriter để ghi dữ liệu vào response OutputStream
		PdfWriter.getInstance(document, response.getOutputStream());

		PdfPTable table = new PdfPTable(4); // Số cột tùy thuộc vào số trường thông tin của đối tượng Size

		// Đặt tiêu đề cho từng cột và canh giữa
		PdfPCell idTitleCell = new PdfPCell(new Paragraph("ID", font));
		idTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(idTitleCell);

		PdfPCell activityTitleCell = new PdfPCell(new Paragraph("Hoạt động", font));
		activityTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(activityTitleCell);

		PdfPCell quantityTitleCell = new PdfPCell(new Paragraph("Size giày", font));
		quantityTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(quantityTitleCell);

		PdfPCell adjustDateTitleCell = new PdfPCell(new Paragraph("Ngày điều chỉnh", font));
		adjustDateTitleCell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(adjustDateTitleCell);

		document.open();

		float rowHeight = 30f;
		// Thêm nội dung vào tài liệu PDF từ danh sách chi tiết size
		for (Size item : sizes) {
			font = new Font(baseFont);

			float[] columnWidths = { 40f, 80f, 60f, 60f }; // Thiết lập chiều rộng cho từng cột
			table.setWidths(columnWidths);

			PdfPCell cell1 = new PdfPCell(new Paragraph(item.getSizeID().toString(), font));
			cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell1.setFixedHeight(rowHeight);
			table.addCell(cell1);

			// Chuyển giá trị của cột "Hoạt động" thành "Đang hoạt động" hoặc "Không hoạt
			// động"
			String activityStatus = item.getActivities() ? "Đang hoạt động" : "Không hoạt động";
			PdfPCell cell2 = new PdfPCell(new Paragraph(activityStatus, font));
			cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell2.setFixedHeight(rowHeight);
			table.addCell(cell2);

			PdfPCell cell3 = new PdfPCell(new Paragraph(item.getSizeNumber().toString(), font));
			cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
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
		Chunk idChunk = new Chunk("Danh sách size", vietnameseFont);
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
