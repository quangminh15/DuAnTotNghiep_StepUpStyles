package com.sts.service;

import com.sts.model.Brand;
import com.sts.model.User;

import java.util.List;

public interface UserService {
	User findById(Integer brandID);

	List<User> findAll();

	User create(User user);

	User update(User user);

	void delete(Integer Id);

	List<User> searchByName(String keyword);
}
