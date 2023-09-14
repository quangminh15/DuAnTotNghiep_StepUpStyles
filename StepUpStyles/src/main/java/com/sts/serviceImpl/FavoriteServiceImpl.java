package com.sts.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sts.dao.FavoriteDAO;
import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.User;
import com.sts.service.FavoriteService;

@Service
public class FavoriteServiceImpl implements FavoriteService{
    @Autowired
    FavoriteDAO favoriteDAO;

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
    public Favorite create(Favorite favorite) {
        return favoriteDAO.save(favorite);
    }

    @Override
    public void delete(User user, Product product) {
        favoriteDAO.deleteByUserAndProduct(user, product);
    }
    
}
