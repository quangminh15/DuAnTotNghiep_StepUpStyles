package com.sts.serviceImpl;

import com.sts.dao.UserDAO;
import com.sts.dto.respone.OneUserForSecurity;
import com.sts.dto.respone.UserForSecurity;
import com.sts.model.Brand;
import com.sts.model.User;
import com.sts.service.UserService;
import com.sts.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;


	@Override
	public User findById(Integer userID) {
		return userDAO.findById(userID).get();
	}

	@Override
	public List<User> findAll() {
		return userDAO.findAll();
	}

	@Override
	public User create(User user) {
		return userDAO.save(user);
	}

	@Override
	public User update(User user) {
		return userDAO.save(user);
	}

	@Override
	public void delete(Integer Id) {
		userDAO.deleteById(Id);
	}

	@Override
	public List<User> searchByName(String keyword) {
		return userDAO.findByFullName(keyword);
	}

	@Override
	public Integer getUserIdCurrent() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		Integer id = userDAO.getIdByEmail(username);
		return id;
	}
}
