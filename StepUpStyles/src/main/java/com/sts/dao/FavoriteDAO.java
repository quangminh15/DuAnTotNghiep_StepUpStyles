package com.sts.dao;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.User;

public interface FavoriteDAO extends JpaRepository<Favorite, Integer>{
    @Transactional
    void deleteByUserAndProduct(User user, Product product);
}
