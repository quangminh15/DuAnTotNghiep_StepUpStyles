package com.sts.service;

import com.sts.model.Brand;
import com.sts.model.DTO.DResponseUser;
import com.sts.model.DTO.LResponseUser;
import com.sts.model.User;

import java.util.List;

public interface UserService {
	User findById(Integer brandID);

	List<LResponseUser> findAll();

	User create(User user);

	User update(User user);

	void delete(Integer Id);

	List<User> searchByName(String keyword);

	Integer getUserIdCurrent();

	String getUserEmailCurrent();

	DResponseUser getUserByEmail(String email);

	DResponseUser getUserByPhone(String phone);

	String updatePass(String email, String pass);
}
