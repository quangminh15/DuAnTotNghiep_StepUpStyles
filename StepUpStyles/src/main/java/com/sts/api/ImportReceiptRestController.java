package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.ImportReceipt;
import com.sts.service.ImportReceiptService;

@CrossOrigin
@RestController
@RequestMapping("/rest/importReceipt")
public class ImportReceiptRestController {
    @Autowired
    ImportReceiptService importService;

    @GetMapping
    public List<ImportReceipt> getAll(){
        return importService.findAll();
    }

    @PostMapping("/createImport")
    public ImportReceipt createImport(@RequestBody ImportReceipt importReceipt){
        return importService.create(importReceipt);
    }

     @PutMapping("/updateImp/{importReceiptID}")
    public ImportReceipt updateImp(@PathVariable("importReceiptId") Long importReceiptId, @RequestBody ImportReceipt importReceipt) {
        return importService.update(importReceipt);
    }

    @GetMapping("/getImp/{importReceiptID}")
    public ImportReceipt getImp(@PathVariable("importReceiptID") Long importReceiptId){
        return importService.findById(importReceiptId);
    }

    @DeleteMapping("/deleteImp/{importReceiptID}")
    public void deleteImp(@PathVariable("importReceiptId") Long importReceiptId){
        importService.deleteById(importReceiptId);
    }
    
    @PutMapping("/ImportReceipt/{importReceiptID}")
    public ImportReceipt updateImportReceiptTotalAmount(@PathVariable Long importReceiptId, @RequestBody ImportReceipt importReceipt) {
        return importService.updateTotalAmount(importReceiptId, importReceipt);
    }

    @GetMapping("/findIdImportReceipt/{importReceiptID}")
    public ImportReceipt findImportReceiptById(@PathVariable Long importReceiptID) {
        ImportReceipt importReceipt = importService.findImportReceiptById(importReceiptID);
        return importReceipt;
    }
}
