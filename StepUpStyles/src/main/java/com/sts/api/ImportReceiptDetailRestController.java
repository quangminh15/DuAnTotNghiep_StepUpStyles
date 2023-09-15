package com.sts.api;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sts.dao.ImportReceiptDAO;
import com.sts.model.ImportReceipt;
import com.sts.model.ImportReceiptDetail;
import com.sts.service.ImportReceiptDetailService;

@CrossOrigin
@RestController
@RequestMapping("/rest/importReceiptDetails")
public class ImportReceiptDetailRestController {
    @Autowired
    ImportReceiptDetailService importReceiptDetailService;

    @Autowired
    ImportReceiptDAO importDao;

    @GetMapping
    public List<ImportReceiptDetail> getAll(){
        return importReceiptDetailService.findAll();
    }

    @GetMapping("/import/{importReceiptId}")
	public ResponseEntity<ImportReceipt> getImportId(@PathVariable Long importReceiptId) {
		Optional<ImportReceipt> importReceipt = importDao.findByImportReceiptId(importReceiptId);
		if (importReceipt.isPresent()) {
			return ResponseEntity.ok(importReceipt.get());
		} else {
			return ResponseEntity.notFound().build();
		}
	}  

    @PostMapping("/createImpDetail")
    public ImportReceiptDetail createDetail(@RequestBody ImportReceiptDetail importReceiptDetail){
        return importReceiptDetailService.create(importReceiptDetail);
    }
}
