package com.sts.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import com.sts.model.Product;
import com.sts.model.ShippingAddress;

import com.sts.service.ShippingAddressService;
import com.sts.service.UserService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/address")
public class ShippingAddressRestController {

	@Autowired
	ShippingAddressService shippingAddressService;
	@Autowired
	UserService userService;

	@PostMapping("/create")
	public void addToCart(
			@RequestParam("defaultCheck") boolean check,
			@RequestParam("province") String province,
			@RequestParam("district") String district,
			@RequestParam("ward") String ward,
			@RequestParam("addressDtail") String adressdetail,
			@RequestParam("nameReceiver") String nameReceiver,
			@RequestParam("phoneReceiver") String phoneReceiver) {
		// Call the service method to insert or update cart item
		// long customerId = 2;
		// Need Modifying and @Transational to chú thích
		// để đảm bảo tính nhất quán trong quá trình thao tác với dữ liệu trong SQL
		Integer userID = userService.getUserIdCurrent();
		shippingAddressService.createAddress(userID, check, province, district, ward, adressdetail, nameReceiver,
				phoneReceiver);
	}

	@PutMapping("/updateDefault")
	public void upDateToCart(@RequestParam("shipid") Integer id) {

		shippingAddressService.updateDefault(id);

	}
@PutMapping("/update")
	public void update( @RequestBody ShippingAddress ship) {
		 shippingAddressService.update(ship);
	}
	@GetMapping
	public ResponseEntity<List<ShippingAddress>> getAddressShip() {
		; // Same static customer ID as set in the UserDetails service
		Integer userID = userService.getUserIdCurrent();
		List<ShippingAddress> address = shippingAddressService.findAddressByUser(userID);
		return new ResponseEntity<>(address, HttpStatus.OK);
	}

	@GetMapping("/default")
	public ShippingAddress getProductColors() {
		Integer userID = userService.getUserIdCurrent();
		return shippingAddressService.findAddressDefaultByUser(userID);
	}

	@DeleteMapping("/delete")
	public void delete(@RequestParam("id") Integer addressId) {
		shippingAddressService.deletedShippingAddress(addressId);
	}


}