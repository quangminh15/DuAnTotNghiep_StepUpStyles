package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


import com.sts.model.ShippingAddress;

import com.sts.service.ShippingAddressService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/address")
public class ShippingAddressRestController {

	@Autowired
	ShippingAddressService shippingAddressService;

	@PostMapping("/create")
	public void addToCart(
	@RequestParam("defaultCheck")  boolean check, 
	@RequestParam("province")  String province, 
	@RequestParam("district") String district, 
	@RequestParam("ward")String ward, 
	@RequestParam("addressDtail")String adressdetail,
	@RequestParam("nameReceiver")String nameReceiver, 
	@RequestParam("phoneReceiver")String phoneReceiver) {
	// Call the service method to insert or update cart item
	// long customerId = 2;
	// Need Modifying and @Transational to chú thích
	// để đảm bảo tính nhất quán trong quá trình thao tác với dữ liệu trong SQL
	shippingAddressService.createAddress(1,check, province, district, ward,adressdetail,nameReceiver,phoneReceiver);
	}

	@PutMapping("/updateDefault")
	public void upDateToCart(@RequestParam("shipid") Integer id) {

		shippingAddressService.updateDefault(id);

	}

	@GetMapping
	public ResponseEntity<List<ShippingAddress>> getAddressShip() {
		; // Same static customer ID as set in the UserDetails service

		List<ShippingAddress> address = shippingAddressService.findAddressByUser(1);
		return new ResponseEntity<>(address, HttpStatus.OK);
	}

	@GetMapping("/default")
	public ShippingAddress getProductColors() {
		return shippingAddressService.findAddressDefaultByUser(1);
	}

}