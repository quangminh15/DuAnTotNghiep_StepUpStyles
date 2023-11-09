package com.sts.serviceImpl;

import com.sts.dao.UserDAO;
import com.sts.model.Brand;
import com.sts.model.DTO.DResponseUser;
import com.sts.model.DTO.LResponseUser;
import com.sts.model.User;
import com.sts.model.DTO.OneUserForSecurity;
import com.sts.model.DTO.UserForSecurity;
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
    public List<LResponseUser> findAll() {
        return userDAO.findAllUser();
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

    @Override
    public DResponseUser getUserByEmail(String email) {
        return userDAO.getUserByEnail(email);
    }
}
