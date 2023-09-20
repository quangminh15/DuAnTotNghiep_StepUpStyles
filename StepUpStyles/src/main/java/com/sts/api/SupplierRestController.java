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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sts.model.Supplier;
import com.sts.service.SupplierService;

@CrossOrigin
@RestController
@RequestMapping("/rest/supplier")
public class SupplierRestController {
    @Autowired
    SupplierService supplierService;

    @GetMapping
    public List<Supplier> getAll(){
        return supplierService.findAll();
    }

    @PostMapping("/createSupp")
    public Supplier createSupplier(@RequestBody Supplier supplier){
        return supplierService.create(supplier);
    }

    @PutMapping("/updateSupp/{supplierId}")
    public Supplier updateSupplier(@RequestBody Supplier supplier, @PathVariable("supplierId") Long supplierId){
        return supplierService.update(supplier);
    }

    @DeleteMapping("/removeSupp/{supplierId}")
    public void deleteSupplier(@PathVariable("supplierId") Long supplierId){
        supplierService.deleteById(supplierId);
    }

    @GetMapping("/getSupp/{supplierId}")
    public Supplier getOne(@PathVariable("supplierId") Long supplierId){
        return supplierService.findById(supplierId);
    }

    @GetMapping("/nodeleted")
    public List<Supplier> getActiveSuppliers() {
        return supplierService.getDeletedSuppliers();
    }

    @GetMapping("/deleted")
    public List<Supplier> getHistorySuppliers() {
        return supplierService.getHistorySuppliers();
    }

    @GetMapping("/searchSupplier")
    public List<Supplier> searchSuppliers(@RequestParam("keyword") String keyword) {
        return supplierService.findBySupplierNameContaining(keyword);
    }
}
