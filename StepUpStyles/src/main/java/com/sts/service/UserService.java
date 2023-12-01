package com.sts.service;

import com.sts.model.DTO.DResponseUser;
import com.sts.model.DTO.LResponseUser;
import com.sts.model.User;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;

import java.util.List;

public interface UserService {
	User findById(Integer brandID);

	User findByEmail(String email);

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

	void loginFromOAuth2(OAuth2AuthenticationToken oauth2);
}
