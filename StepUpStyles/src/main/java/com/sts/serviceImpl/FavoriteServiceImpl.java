package com.sts.serviceImpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.FavoriteDAO;
import com.sts.dao.ProductDAO;
import com.sts.dao.UserDAO;
import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.User;
import com.sts.service.FavoriteService;

@Service
public class FavoriteServiceImpl implements FavoriteService{
    @Autowired
    FavoriteDAO favoriteDAO;

    @Autowired
    ProductDAO productDAO;

    @Autowired
    UserDAO userDAO;

    @Override
    public Favorite findById(Integer favoriteID) {
        return favoriteDAO.findById(favoriteID).get();
    }

    @Override
    public List<Favorite> findAll() {
        return favoriteDAO.findAll();
    }

    @Override
    public Favorite update(Favorite favorite) {
        return favoriteDAO.save(favorite);
    }

    @Override
    public Favorite create(Integer productId, Integer userId) {
        Product product = productDAO.findById(productId).get();
        User user = userDAO.findById(userId).get();
        
        Favorite favorite = new Favorite();
        if (product != null && user != null) {
            favorite.setUser(user);
            favorite.setProduct(product);
        }
        return favoriteDAO.save(favorite);
    }

    @Override
    public void delete(User user, Product product) {
        favoriteDAO.deleteByUserAndProduct(user, product);
    }

    @Override
    public List<Favorite> findByUserId(Integer userID) {
        return favoriteDAO.findByUserId(userID);
    }

    @Override
    public Favorite getUserAndProductFavorite(Integer usersId, Integer productId) {
        return favoriteDAO.findByUserAndProduct(usersId, productId);
    }

    @Override
    public void deleteById(Integer favoriteId) {
        favoriteDAO.deleteById(favoriteId);
    }
    
}
