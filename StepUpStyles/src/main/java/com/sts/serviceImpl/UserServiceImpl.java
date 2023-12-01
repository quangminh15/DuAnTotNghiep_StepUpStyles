package com.sts.serviceImpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Service;

import com.sts.dao.UserDAO;
import com.sts.model.User;
import com.sts.model.DTO.DResponseUser;
import com.sts.model.DTO.LResponseUser;
import com.sts.service.UserService;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDAO userDAO;


    @Override
    public User findById(Integer userID) {
        return userDAO.findById(userID).get();
    }

    @Override
    public User findByEmail(String email) {
        return userDAO.findByEmailU(email);
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
    public String getUserEmailCurrent() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        return username;
    }

    @Override
    public DResponseUser getUserByEmail(String email) {
        return userDAO.getUserByEnail(email);
    }

    @Override
    public DResponseUser getUserByPhone(String phone) {
        return userDAO.getUserByPhone(phone);
    }

    @Override
    public String updatePass(String email, String pass) {
        return userDAO.updatePass(email, pass);
    }

    @Override
    public void loginFromOAuth2(OAuth2AuthenticationToken oauth2) {
        String email = oauth2.getPrincipal().getAttribute("email");
        String pass = Long.toHexString(System.currentTimeMillis());
        UserDetails u = org.springframework.security.core.userdetails.User.withUsername(email).password(pass).roles("CUSTOMER").build();
        Authentication auth = new UsernamePasswordAuthenticationToken(u, null, u.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(auth);
    }
}
